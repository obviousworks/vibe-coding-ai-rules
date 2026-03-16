# Logging Standards for AI-Generated Code

**Critical**: AI models frequently generate `console.log` statements with no levels and no structure. Treat all AI-generated logging as production-unready until reviewed.

## Core Principles

### 1. Structured Over Unstructured
- **Every log entry must be machine-parseable**
- Use JSON format, not free-text strings
- Consistent field names across the entire codebase

### 2. Leveled and Intentional
- Every log statement must have the correct severity level
- Too much logging is as harmful as too little
- Production logs are different from development logs

### 3. Contextual and Traceable
- Every log must carry enough context to be useful in isolation
- Correlation IDs link logs across services and requests
- Include the "who, what, where, when" in every entry

## Log Levels

```typescript
import { createLogger, format, transports } from 'winston'

const logger = createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: format.combine(format.timestamp(), format.json()),
  transports: [new transports.Console()],
})

// DEBUG: Detailed diagnostics. Never enable in prod unless actively debugging.
logger.debug('Cache lookup', { key: 'user:123', hit: false, ttl: 300 })

// INFO: Normal operational events confirming things work.
logger.info('Order processed', { orderId: 'ord_abc', amount: 99.99, currency: 'USD' })

// WARN: Unexpected conditions that need attention but are not errors.
logger.warn('Rate limit approaching', { current: 450, limit: 500, window: '1m' })

// ERROR: Failures affecting a single operation, not the whole system.
logger.error('Payment failed', { orderId: 'ord_abc', errorCode: 'card_declined', retryable: true })

// FATAL: System-wide failures requiring immediate attention and likely restart.
logger.error('DB pool exhausted', { level: 'fatal', active: 100, max: 100, pending: 47 })
```

```python
import logging, json, sys

class JSONFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        entry = {"timestamp": self.formatTime(record), "level": record.levelname,
                 "message": record.getMessage(), "logger": record.name}
        if hasattr(record, "extra_data"):
            entry.update(record.extra_data)
        return json.dumps(entry)

handler = logging.StreamHandler(sys.stdout)
handler.setFormatter(JSONFormatter())
logger = logging.getLogger("app")
logger.addHandler(handler)
logger.setLevel(logging.INFO)

logger.info("Order processed", extra={"extra_data": {"order_id": "ord_abc", "amount": 99.99}})
logger.warning("Rate limit approaching", extra={"extra_data": {"current": 450, "limit": 500}})
logger.error("Payment failed", extra={"extra_data": {"order_id": "ord_abc", "error": "declined"}})
```

## Structured Logging: Consistent Fields

```typescript
// ✅ Standardize field names across the codebase
interface LogContext {
  correlationId: string    // Trace across services
  requestId: string        // Unique per request
  userId?: string          // Authenticated user
  service: string          // Service name
  operation: string        // What is being done
  duration?: number        // Milliseconds elapsed
}

// ✅ Request-scoped logger via middleware
app.use((req, res, next) => {
  req.log = logger.child({
    correlationId: req.headers['x-correlation-id'] || crypto.randomUUID(),
    requestId: crypto.randomUUID(),
    userId: req.user?.id,
    service: 'order-service',
  })
  const start = Date.now()
  res.on('finish', () => {
    req.log.info('Request completed', { statusCode: res.statusCode, duration: Date.now() - start })
  })
  next()
})
```

## What to Log

```typescript
// ✅ Request/response metadata
logger.info('Incoming request', { method, path, userAgent, ip })

// ✅ State changes
logger.info('Order status changed', { orderId, from: 'pending', to: 'confirmed' })

// ✅ External service calls
logger.info('External API call', { service: 'stripe', operation: 'charge', duration: 230 })
logger.error('External API failure', { service: 'stripe', statusCode: 502, retryAttempt: 2 })

// ✅ Performance metrics
logger.warn('Slow query detected', { query: 'searchProducts', duration: 3200, threshold: 1000 })

// ✅ Security events
logger.warn('Failed login attempt', { userId, ip, attemptCount: 3 })
```

## What NOT to Log

```typescript
// ❌ NEVER log any of the following
logger.info('User login', {
  password: req.body.password,        // Passwords
  token: req.headers.authorization,   // Auth tokens / JWTs
  apiKey: config.stripeKey,           // API keys
  ssn: user.socialSecurityNumber,     // Government IDs
  creditCard: payment.cardNumber,     // Financial data
  sessionToken: req.cookies.session,  // Session tokens
})

// ✅ Log safe identifiers and metadata only
logger.info('User login', {
  userId: user.id,
  email: maskPii(user.email),  // j***@example.com
  ip: req.ip,
  success: true,
})

function maskPii(email: string): string {
  const [local, domain] = email.split('@')
  return `${local[0]}***@${domain}`
}
```

## Correlation IDs: Request Tracing

```typescript
// ✅ Propagate correlation IDs across services
import { AsyncLocalStorage } from 'node:async_hooks'

const asyncLocalStorage = new AsyncLocalStorage<{ correlationId: string }>()

app.use((req, res, next) => {
  const correlationId = req.headers['x-correlation-id'] as string || crypto.randomUUID()
  res.setHeader('x-correlation-id', correlationId)
  asyncLocalStorage.run({ correlationId }, () => next())
})

// ✅ Pass to downstream services
async function callDownstream(path: string, body: object) {
  const cid = asyncLocalStorage.getStore()?.correlationId || 'unknown'
  return fetch(`https://downstream${path}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'x-correlation-id': cid },
    body: JSON.stringify(body),
  })
}
```

```python
# ✅ Correlation ID in Python (FastAPI)
from contextvars import ContextVar
from uuid import uuid4
from starlette.middleware.base import BaseHTTPMiddleware

correlation_id_var: ContextVar[str] = ContextVar("correlation_id", default="unknown")

class CorrelationIdMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        cid = request.headers.get("x-correlation-id", str(uuid4()))
        correlation_id_var.set(cid)
        response = await call_next(request)
        response.headers["x-correlation-id"] = cid
        return response
```

## Log Aggregation

```typescript
// ✅ Winston with environment-specific transports
import WinstonCloudWatch from 'winston-cloudwatch'

const logger = createLogger({
  format: format.combine(format.timestamp(), format.errors({ stack: true }), format.json()),
  defaultMeta: { service: process.env.SERVICE_NAME },
  transports: [
    new transports.Console({
      format: process.env.NODE_ENV === 'development'
        ? format.combine(format.colorize(), format.simple()) : format.json(),
    }),
  ],
})

// Add CloudWatch / ELK / Datadog in production
if (process.env.NODE_ENV === 'production') {
  logger.add(new WinstonCloudWatch({
    logGroupName: `/app/${process.env.SERVICE_NAME}`,
    logStreamName: process.env.HOSTNAME,
    jsonMessage: true,
  }))
}
```

## Performance

```typescript
// ✅ Log sampling for high-volume events
class SampledLogger {
  private counts = new Map<string, number>()
  log(level: string, message: string, meta: object, sampleRate = 1.0) {
    const key = `${level}:${message}`
    const count = (this.counts.get(key) || 0) + 1
    this.counts.set(key, count)
    if (Math.random() < sampleRate) {
      logger.log(level, message, { ...meta, sampleRate, totalCount: count })
    }
  }
}

sampledLogger.log('debug', 'Health check', { status: 'ok' }, 0.1) // Sample 10%

// ✅ Conditional logging to avoid expensive serialization
if (logger.isLevelEnabled('debug')) {
  logger.debug('Query result', { result: JSON.stringify(largeObject) })
}
```

## Frontend Logging

```typescript
// ✅ Privacy-aware client-side logging
class ClientLogger {
  private buffer: object[] = []

  error(message: string, meta: object = {}) {
    this.buffer.push({
      level: 'error', message, ...meta,
      timestamp: new Date().toISOString(),
      sessionId: this.getAnonymousSessionId(), // NOT the auth token
      page: window.location.pathname,
    })
    this.flush()
  }

  private async flush() {
    if (!this.buffer.length) return
    const entries = this.buffer.splice(0)
    await fetch('/api/logs', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ logs: entries }),
      keepalive: true,
    }).catch(() => { /* re-queue with limit to prevent memory leak */ })
  }

  private getAnonymousSessionId(): string {
    let id = sessionStorage.getItem('log_session_id')
    if (!id) { id = crypto.randomUUID(); sessionStorage.setItem('log_session_id', id) }
    return id
  }
}

// ✅ Global browser error handlers
window.addEventListener('error', (e) => clientLogger.error('Uncaught error', { stack: e.error?.stack }))
window.addEventListener('unhandledrejection', (e) => clientLogger.error('Unhandled rejection', { reason: String(e.reason) }))
```

## Anti-Patterns

```typescript
// ❌ Console.log in production
console.log('user data:', userData) // No level, no structure, no context

// ❌ Logging sensitive data
logger.info('Request body', { body: req.body }) // May contain passwords/tokens

// ❌ Excessive logging in hot paths
for (const item of millionItems) { logger.debug('Processing item', { item }) }

// ❌ String interpolation instead of structured fields
logger.info(`User ${userId} bought ${productName} for $${price}`)

// ❌ Logging without context
logger.error('Failed') // What failed? Where? Why?

// ✅ Correct alternatives
logger.info('Item purchased', { userId, productName, price, currency: 'USD' })
logger.info('Batch processed', { totalItems: millionItems.length, duration: 4500 })
```

## Logging Checklist for AI Agents

Before generating or modifying code, verify:

- [ ] All log statements use a structured logger, not `console.log` or `print`
- [ ] Every log entry has the correct severity level (DEBUG/INFO/WARN/ERROR/FATAL)
- [ ] Log output is JSON-formatted with consistent field names
- [ ] Correlation IDs present and propagated across service boundaries
- [ ] No PII, passwords, tokens, or secrets in any log statement
- [ ] Request/response metadata logged at INFO level
- [ ] Errors logged with full context (code, message, stack, correlation ID)
- [ ] Slow operations logged with duration and threshold values
- [ ] High-volume log paths use sampling or aggregation
- [ ] Log levels configurable via environment variable
- [ ] Frontend logging is privacy-aware (anonymous session IDs, no user data)
- [ ] No string interpolation in log messages (use structured key-value pairs)

---

**Remember**: Logs are your production lifeline. Every line of AI-generated code must include deliberate, structured, and privacy-respecting logging.
