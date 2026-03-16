# API Design Conventions for AI-Generated Code

**Critical**: Inconsistent API design compounds technical debt rapidly. AI agents must follow these conventions to produce APIs that are predictable, maintainable, and client-friendly.

## Core Principles

### 1. Consistency Over Creativity
- Follow established patterns across all endpoints
- Use the same naming, structure, and error format everywhere
- A developer who learns one endpoint should predict all others

### 2. Client-First Design
- Design for the consumer, not the database schema
- Minimize round-trips; allow field selection and resource embedding
- Provide clear, actionable error messages

### 3. Backward Compatibility by Default
- Never remove or rename fields in existing responses
- Add new fields as optional; deprecate old ones with a timeline
- Use versioning for breaking changes

## REST API Naming

### Resource Naming Rules

```
# ✅ Correct
GET    /users
GET    /users/{id}
GET    /users/{id}/orders
GET    /order-items
POST   /users/{id}/orders

# ❌ Incorrect
GET    /getUsers
GET    /user/{id}
POST   /createOrder
GET    /order_items
GET    /Users/{id}
```

- **Nouns for resources**, not verbs: `/users` not `/getUsers`
- **Plural nouns** for collections: `/users`, `/orders`
- **Nested resources** for relationships: `/users/{id}/orders`
- **kebab-case** for multi-word paths: `/order-items`
- **camelCase** for JSON property names
- **Version in URL**: `/api/v1/users` (preferred) or `Accept: application/vnd.api.v1+json` header

## HTTP Methods and Idempotency

| Method | Purpose | Idempotent | Request Body |
|--------|---------|------------|-------------|
| GET | Read resource(s) | Yes | No |
| POST | Create resource | No | Yes |
| PUT | Full replacement | Yes | Yes |
| PATCH | Partial update | No* | Yes |
| DELETE | Remove resource | Yes | No |

*PATCH is not inherently idempotent, but can be implemented as such.

- **GET** must never modify state
- **PUT** must replace the entire resource; omit fields to clear them
- **POST** to a collection creates a new resource; return `201 Created` with `Location` header
- **DELETE** should return `204 No Content`; repeated calls return `204` or `404`

## Request/Response Patterns

### Consistent Response Envelope

```typescript
// ✅ Standard response structure
interface ApiResponse<T> {
  data: T | T[]
  meta?: {
    page?: number
    perPage?: number
    total?: number
    cursor?: string
    hasMore?: boolean
  }
  errors?: ApiError[]
}

// Single resource
{ "data": { "id": "usr_123", "name": "Alice", "email": "alice@example.com" } }

// Collection
{ "data": [...], "meta": { "cursor": "eyJpZCI6MTAwfQ==", "hasMore": true } }
```

### Pagination

```typescript
// ✅ Cursor-based pagination (preferred for real-time data)
// GET /api/v1/orders?cursor=eyJpZCI6MTAwfQ==&limit=20
app.get('/api/v1/orders', async (req, res) => {
  const limit = Math.min(parseInt(req.query.limit) || 20, 100)
  const cursor = req.query.cursor
    ? JSON.parse(Buffer.from(req.query.cursor, 'base64url').toString())
    : null

  const orders = await prisma.order.findMany({
    take: limit + 1,
    ...(cursor && { cursor: { id: cursor.id }, skip: 1 }),
    orderBy: { createdAt: 'desc' },
  })

  const hasMore = orders.length > limit
  const results = hasMore ? orders.slice(0, -1) : orders
  const nextCursor = hasMore
    ? Buffer.from(JSON.stringify({ id: results.at(-1).id })).toString('base64url')
    : null

  res.json({
    data: results,
    meta: { cursor: nextCursor, hasMore, limit },
  })
})
```

```python
# ✅ Offset-based pagination (simpler, fine for stable data)
# GET /api/v1/products?page=2&per_page=20
@app.get("/api/v1/products")
async def list_products(page: int = 1, per_page: int = 20):
    per_page = min(per_page, 100)
    offset = (page - 1) * per_page
    total = await Product.count()
    products = await Product.find_all(offset=offset, limit=per_page)

    return {
        "data": [p.dict() for p in products],
        "meta": {
            "page": page,
            "perPage": per_page,
            "total": total,
            "totalPages": -(-total // per_page),
        },
    }
```

### Filtering, Sorting, and Partial Responses

```
# Filtering with query parameters
GET /api/v1/orders?status=active&customerId=usr_123

# Sorting (prefix with - for descending)
GET /api/v1/orders?sort=-createdAt,total

# Partial responses (field selection)
GET /api/v1/users/usr_123?fields=id,name,email
```

## Error Response Format (RFC 7807)

```typescript
// ✅ Problem Details for HTTP APIs (RFC 7807)
interface ProblemDetails {
  type: string       // URI reference identifying the error type
  title: string      // Short human-readable summary
  status: number     // HTTP status code
  detail: string     // Human-readable explanation specific to this occurrence
  instance?: string  // URI reference for the specific occurrence
}

// Example error response
app.use((err, req, res, next) => {
  const status = err.status || 500
  res.status(status).json({
    type: `https://api.example.com/errors/${err.code || 'internal-error'}`,
    title: err.title || 'Internal Server Error',
    status,
    detail: err.message,
    instance: req.originalUrl,
  })
})
```

```python
# ✅ RFC 7807 error responses in FastAPI
from fastapi import HTTPException, Request
from fastapi.responses import JSONResponse

@app.exception_handler(HTTPException)
async def problem_details_handler(request: Request, exc: HTTPException):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "type": f"https://api.example.com/errors/{exc.detail.get('code', 'error')}",
            "title": exc.detail.get("title", "Error"),
            "status": exc.status_code,
            "detail": exc.detail.get("message", str(exc.detail)),
            "instance": str(request.url),
        },
    )

# Raise structured errors
raise HTTPException(
    status_code=422,
    detail={"code": "validation-error", "title": "Validation Error", "message": "Email format is invalid"},
)
```

## Status Codes

### Success
- **200 OK** -- Successful GET, PUT, PATCH, or DELETE
- **201 Created** -- Successful POST; include `Location` header
- **204 No Content** -- Successful DELETE or PUT with no response body

### Client Errors
- **400 Bad Request** -- Malformed syntax, invalid JSON
- **401 Unauthorized** -- Missing or invalid authentication
- **403 Forbidden** -- Authenticated but insufficient permissions
- **404 Not Found** -- Resource does not exist
- **409 Conflict** -- State conflict (duplicate, concurrent edit)
- **422 Unprocessable Entity** -- Valid syntax but semantic errors (validation failures)
- **429 Too Many Requests** -- Rate limit exceeded; include `Retry-After` header

### Server Errors
- **500 Internal Server Error** -- Unexpected server failure; never expose internals
- **503 Service Unavailable** -- Temporary overload or maintenance; include `Retry-After`

## Rate Limiting

```typescript
// ✅ Include rate limit headers in every response
function rateLimitMiddleware(req, res, next) {
  const limit = 100
  const remaining = limit - currentRequestCount
  const resetTime = Math.ceil(windowResetTimestamp / 1000)

  res.set({
    'X-RateLimit-Limit': limit,
    'X-RateLimit-Remaining': Math.max(0, remaining),
    'X-RateLimit-Reset': resetTime,
  })

  if (remaining < 0) {
    res.set('Retry-After', resetTime - Math.ceil(Date.now() / 1000))
    return res.status(429).json({
      type: 'https://api.example.com/errors/rate-limit-exceeded',
      title: 'Too Many Requests',
      status: 429,
      detail: `Rate limit of ${limit} requests per window exceeded.`,
    })
  }

  next()
}
```

## Security

For full security implementation details, see [Security Rules](./security-rules.md).

### CORS Configuration

```typescript
// ✅ Restrict CORS to known origins
import cors from 'cors'

app.use(cors({
  origin: ['https://app.example.com', 'https://admin.example.com'],
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true,
  maxAge: 86400, // Cache preflight for 24 hours
}))
```

### Authentication Patterns

```typescript
// ✅ Bearer token authentication
function authenticateRequest(req, res, next) {
  const authHeader = req.headers.authorization
  if (!authHeader?.startsWith('Bearer ')) {
    return res.status(401).json({
      type: 'https://api.example.com/errors/unauthorized',
      title: 'Unauthorized',
      status: 401,
      detail: 'Missing or malformed Authorization header.',
    })
  }

  const token = authHeader.slice(7)
  try {
    req.user = verifyToken(token)
    next()
  } catch {
    return res.status(401).json({
      type: 'https://api.example.com/errors/invalid-token',
      title: 'Unauthorized',
      status: 401,
      detail: 'Token is expired or invalid.',
    })
  }
}

// ✅ API key authentication (for server-to-server)
// Pass via header: X-API-Key: sk_live_abc123
// Never pass API keys in query parameters (they appear in logs)
```

## Documentation

- **OpenAPI/Swagger**: Maintain an `openapi.yaml` or generate from code annotations
- **Auto-generation**: Use `tsoa`, `nestjs/swagger` (TypeScript) or `FastAPI` (Python, built-in)
- **Version docs separately**: Each API version should have its own specification
- **Include examples**: Every endpoint must have request/response examples
- **Keep docs in sync**: Generate docs in CI; fail the build if spec diverges from code

## Anti-Patterns

Avoid these common mistakes in AI-generated API code:

- **Verbs in URLs**: `/getUsers`, `/deleteOrder` -- use HTTP methods instead
- **Inconsistent naming**: Mixing `snake_case` and `camelCase` in JSON responses
- **No pagination**: Returning unbounded collections that grow without limit
- **No versioning**: Breaking clients with unversioned schema changes
- **Exposing internal IDs**: Leaking auto-increment database IDs; use UUIDs or prefixed IDs (`usr_`, `ord_`)
- **No rate limiting**: Allowing unlimited requests invites abuse and outages
- **Inconsistent errors**: Returning different error shapes from different endpoints
- **Ignoring idempotency**: POST endpoints that create duplicates on retry
- **Leaking stack traces**: Returning internal error details in production responses

## Checklist for AI Agents

Before generating or modifying API code, verify:

- [ ] Resource URLs use plural nouns, kebab-case, no verbs
- [ ] HTTP methods match CRUD semantics (GET reads, POST creates, etc.)
- [ ] All responses follow the standard envelope (`data`, `meta`, `errors`)
- [ ] Collections are paginated with a maximum page size
- [ ] Errors use RFC 7807 Problem Details format with appropriate status codes
- [ ] Rate limiting headers are included in responses
- [ ] Authentication is required on all non-public endpoints
- [ ] CORS is configured with an explicit origin allowlist
- [ ] API version is specified in the URL or accept header
- [ ] IDs are opaque (UUIDs or prefixed); no auto-increment IDs exposed
- [ ] OpenAPI specification is present and matches the implementation
- [ ] No sensitive data (passwords, tokens, internal errors) in responses

---

**Remember**: A well-designed API is a contract with your consumers. Every endpoint an AI agent generates must be consistent, documented, and safe by default.
