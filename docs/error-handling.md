# Error Handling Patterns for AI-Generated Code

**Critical**: AI models often generate code with incomplete error handling. Treat all AI-generated error handling as insufficient until reviewed.

## Core Principles

### 1. Fail Fast, Fail Explicitly
- **Detect errors at the earliest possible point**
- Validate inputs before processing, not after
- Never silently ignore failures; prefer crashes over corrupted state

### 2. Explicit Over Implicit
- Every function should declare what errors it can produce
- Use typed error classes, not generic strings
- Document error conditions in function signatures

### 3. No Silent Failures
- Empty catch blocks are bugs, not solutions
- Log every caught error with sufficient context
- If you cannot handle an error, propagate it

## Error Types: Operational vs Programmer Errors

```typescript
// ✅ Define a clear error hierarchy
class AppError extends Error {
  constructor(
    message: string,
    public readonly code: string,
    public readonly statusCode: number,
    public readonly isOperational: boolean = true
  ) {
    super(message)
    this.name = this.constructor.name
  }
}

class ValidationError extends AppError {
  constructor(message: string, public readonly fields: Record<string, string>) {
    super(message, 'VALIDATION_ERROR', 400)
  }
}

class NotFoundError extends AppError {
  constructor(resource: string, id: string) {
    super(`${resource} with id ${id} not found`, 'NOT_FOUND', 404)
  }
}
// Programmer errors (TypeError, ReferenceError) should NOT be caught; fix the code
```

```python
# ✅ Define a clear error hierarchy
class AppError(Exception):
    def __init__(self, message: str, code: str, status_code: int, is_operational: bool = True):
        super().__init__(message)
        self.code = code
        self.status_code = status_code
        self.is_operational = is_operational

class ValidationError(AppError):
    def __init__(self, message: str, fields: dict[str, str] | None = None):
        super().__init__(message, "VALIDATION_ERROR", 400)
        self.fields = fields or {}

class NotFoundError(AppError):
    def __init__(self, resource: str, resource_id: str):
        super().__init__(f"{resource} with id {resource_id} not found", "NOT_FOUND", 404)
```

## Error Propagation: Throw vs Result Types

```typescript
// ✅ Use Result types for expected failures
type Result<T, E = AppError> = { ok: true; value: T } | { ok: false; error: E }

function parseEmail(input: string): Result<string, ValidationError> {
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(input)) {
    return { ok: false, error: new ValidationError('Invalid email', { email: 'Bad format' }) }
  }
  return { ok: true, value: input.toLowerCase() }
}

// ✅ Use throw for unexpected failures (programmer errors)
function getRequiredEnvVar(name: string): string {
  const value = process.env[name]
  if (!value) throw new Error(`Missing required env var: ${name}`)
  return value
}
```

**When to catch vs re-throw:**
- **Catch** when you can meaningfully recover or transform the error
- **Re-throw** when the caller needs to handle the error
- **Wrap** when you want to add context without losing the original
- **Never catch** just to log and re-throw without adding value

## User-Facing vs Internal Errors

```typescript
// ✅ Sanitize errors before sending to clients
function toErrorResponse(error: unknown): object {
  if (error instanceof AppError && error.isOperational) {
    return {
      type: `https://api.example.com/errors/${error.code.toLowerCase()}`,
      title: error.code,
      status: error.statusCode,
      detail: error.message,
    }
  }
  // ❌ NEVER expose stack traces, SQL errors, or file paths
  return {
    type: 'https://api.example.com/errors/internal',
    title: 'INTERNAL_ERROR',
    status: 500,
    detail: 'An unexpected error occurred. Please try again later.',
  }
}
```

## HTTP Error Responses: RFC 7807 Problem Details

```typescript
// ✅ Content-Type: application/problem+json
interface ProblemDetails {
  type: string       // URI identifying the error type
  title: string      // Short human-readable summary
  status: number     // HTTP status code
  detail?: string    // Explanation specific to this occurrence
  instance?: string  // URI identifying this specific occurrence
}

// ✅ Global error handler middleware
function errorHandler(err: Error, req: Request, res: Response, next: NextFunction) {
  const correlationId = req.headers['x-correlation-id'] || crypto.randomUUID()
  logger.error('Request failed', { correlationId, error: err.message, stack: err.stack })
  const response = toErrorResponse(err)
  res.status(response.status).json({ ...response, instance: req.path })
}
```

## Retry Patterns

### Exponential Backoff

```typescript
// ✅ Retry with exponential backoff and jitter
async function withRetry<T>(
  fn: () => Promise<T>,
  { maxRetries = 3, baseDelayMs = 200, maxDelayMs = 10000 } = {}
): Promise<T> {
  for (let attempt = 0; attempt <= maxRetries; attempt++) {
    try {
      return await fn()
    } catch (error) {
      if (attempt === maxRetries) throw error
      if (error instanceof AppError && !error.isOperational) throw error
      const delay = Math.min(baseDelayMs * 2 ** attempt + Math.random() * 100, maxDelayMs)
      await new Promise(resolve => setTimeout(resolve, delay))
    }
  }
  throw new Error('Unreachable')
}
```

### Circuit Breaker

```typescript
// ✅ Circuit breaker to prevent cascading failures
class CircuitBreaker {
  private failures = 0
  private lastFailure: number | null = null
  private state: 'closed' | 'open' | 'half-open' = 'closed'

  constructor(private readonly threshold = 5, private readonly resetTimeMs = 30000) {}

  async execute<T>(fn: () => Promise<T>): Promise<T> {
    if (this.state === 'open') {
      if (Date.now() - this.lastFailure! > this.resetTimeMs) this.state = 'half-open'
      else throw new AppError('Service unavailable', 'CIRCUIT_OPEN', 503)
    }
    try {
      const result = await fn()
      this.failures = 0; this.state = 'closed'
      return result
    } catch (error) {
      this.failures++; this.lastFailure = Date.now()
      if (this.failures >= this.threshold) this.state = 'open'
      throw error
    }
  }
}
```

## Error Boundaries

```typescript
// ✅ React error boundary for graceful UI failure
class ErrorBoundary extends Component<{ fallback: ReactNode; children: ReactNode }, { hasError: boolean }> {
  state = { hasError: false }
  static getDerivedStateFromError() { return { hasError: true } }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    reportError(error, { componentStack: errorInfo.componentStack })
  }

  render() {
    return this.state.hasError ? this.props.fallback : this.props.children
  }
}

// ✅ Global unhandled error handlers (Node.js)
process.on('unhandledRejection', (reason) => {
  logger.fatal('Unhandled promise rejection', { reason })
  process.exit(1)
})

process.on('uncaughtException', (error) => {
  logger.fatal('Uncaught exception', { error: error.message, stack: error.stack })
  process.exit(1)
})
```

## Async Error Handling

```typescript
// ❌ NEVER leave promise rejections unhandled
fetch('/api/data') // Missing await and catch

// ✅ Always handle async errors
async function fetchData(): Promise<Result<Data, AppError>> {
  try {
    const response = await fetch('/api/data')
    if (!response.ok) {
      return { ok: false, error: new AppError('Fetch failed', 'FETCH_ERROR', response.status) }
    }
    return { ok: true, value: await response.json() }
  } catch {
    return { ok: false, error: new AppError('Network error', 'NETWORK_ERROR', 503) }
  }
}
```

```python
# ✅ Async error handling in Python
async def fetch_data(url: str) -> Result:
    try:
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as response:
                if response.status != 200:
                    return Err(AppError(f"Fetch failed: {response.status}", "FETCH_ERROR", response.status))
                return Ok(await response.json())
    except aiohttp.ClientError as e:
        return Err(AppError(f"Network error: {e}", "NETWORK_ERROR", 503))
```

## Error Logging

```typescript
// ✅ What to INCLUDE: rich context for debugging
logger.error('Payment processing failed', {
  correlationId: req.correlationId,
  timestamp: new Date().toISOString(),
  errorCode: error.code,
  stack: error.stack,
  userId: req.user?.id,
  endpoint: `${req.method} ${req.path}`,
  duration: Date.now() - startTime,
})

// ❌ What NOT to include: PII, secrets, credentials
// NEVER log: passwords, auth tokens, SSNs, credit card numbers
// ✅ Log safe identifiers: userId, masked email (j***@example.com), IP
```

## Anti-Patterns

```typescript
// ❌ Empty catch block (swallows errors silently)
try { await saveData() } catch (e) {}

// ❌ Generic error messages
throw new Error('Something went wrong')

// ❌ Exceptions for flow control
try { const user = await getUser(id) } catch { await createUser(id) }

// ❌ Exposing internals to users
res.status(500).json({ error: error.stack })

// ✅ Correct: use conditional logic, not exceptions
const user = await getUser(id)
if (!user) await createUser(id)
```

## Error Handling Checklist for AI Agents

Before generating or modifying code, verify:

- [ ] Custom error classes with codes, status codes, and operational flags
- [ ] All async functions have proper try-catch or Result return types
- [ ] No empty catch blocks anywhere in the codebase
- [ ] User-facing errors sanitized (no stack traces, no internal details)
- [ ] HTTP errors follow RFC 7807 Problem Details format
- [ ] Retry logic uses exponential backoff with jitter and max attempts
- [ ] Circuit breakers protect calls to external services
- [ ] React components wrapped in error boundaries
- [ ] Global handlers for unhandled rejections and uncaught exceptions
- [ ] Error logs include correlation ID, timestamp, and context
- [ ] Error logs exclude PII, secrets, and authentication tokens
- [ ] Operational errors distinguished from programmer errors
- [ ] Exceptions never used for normal control flow

---

**Remember**: Error handling is not an afterthought. Every line of AI-generated code must anticipate failure and handle it explicitly.
