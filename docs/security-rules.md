# Security Rules for AI-Generated Code

**Critical**: AI models can replicate insecure patterns from training data. Treat all AI-generated code as untrusted until reviewed.

## Core Security Principles

### 1. Trust Nothing, Verify Everything
- **All AI-generated code requires human security review**
- Run SAST (Static Application Security Testing) before merging
- Implement secrets scanning in pre-commit hooks
- Never skip security checks for "simple" changes

### 2. Defense in Depth
- Multiple layers of security controls
- Fail securely (default deny, not default allow)
- Assume breach mentality in design

### 3. Principle of Least Privilege
- Grant minimum necessary permissions
- Time-bound access when possible
- Regular permission audits

## Input Validation and Sanitization

### Required Validation Patterns

```typescript
// ✅ ALWAYS validate and sanitize user input
import { z } from 'zod'

const UserInputSchema = z.object({
  email: z.string().email().max(255),
  username: z.string().min(3).max(50).regex(/^[a-zA-Z0-9_-]+$/),
  age: z.number().int().min(0).max(150)
})

// Validate before processing
const validatedData = UserInputSchema.parse(userInput)
```

```python
# ✅ ALWAYS validate with Pydantic
from pydantic import BaseModel, EmailStr, constr, conint

class UserInput(BaseModel):
    email: EmailStr
    username: constr(min_length=3, max_length=50, regex=r'^[a-zA-Z0-9_-]+$')
    age: conint(ge=0, le=150)

# Validate before processing
validated_data = UserInput(**user_input)
```

### Common Validation Requirements

- **Email addresses**: Use email validation library, max length 255
- **Usernames**: Alphanumeric + underscore/dash only, 3-50 chars
- **URLs**: Validate protocol (https only in prod), check against SSRF
- **File uploads**: Check MIME type, file extension, max size, scan for malware
- **JSON inputs**: Validate structure, reject unknown fields in strict mode
- **Numeric inputs**: Check ranges, prevent integer overflow
- **Dates**: Validate format, check reasonable ranges (no dates in year 2100)

### SQL Injection Prevention

```typescript
// ❌ NEVER concatenate SQL strings
const query = `SELECT * FROM users WHERE email = '${userEmail}'` // VULNERABLE

// ✅ ALWAYS use parameterized queries (Prisma does this automatically)
const user = await prisma.user.findUnique({
  where: { email: userEmail }
})

// ✅ For raw SQL, use parameterization
const users = await prisma.$queryRaw`
  SELECT * FROM users WHERE email = ${userEmail}
`
```

```python
# ❌ NEVER use string formatting for SQL
query = f"SELECT * FROM users WHERE email = '{email}'"  # VULNERABLE

# ✅ ALWAYS use parameterized queries (SQLAlchemy does this automatically)
user = db.query(User).filter(User.email == email).first()

# ✅ For raw SQL, use parameters
result = db.execute(
    text("SELECT * FROM users WHERE email = :email"),
    {"email": email}
)
```

### XSS (Cross-Site Scripting) Prevention

```typescript
// ✅ React automatically escapes JSX content
<div>{userInput}</div> // Safe

// ❌ NEVER use dangerouslySetInnerHTML without sanitization
<div dangerouslySetInnerHTML={{ __html: userInput }} /> // VULNERABLE

// ✅ Sanitize HTML content if absolutely necessary
import DOMPurify from 'isomorphic-dompurify'
<div dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(userInput) }} />

// ✅ Set Content Security Policy headers
// next.config.js
const cspHeader = `
  default-src 'self';
  script-src 'self' 'unsafe-eval' 'unsafe-inline';
  style-src 'self' 'unsafe-inline';
  img-src 'self' blob: data:;
  font-src 'self';
  object-src 'none';
  base-uri 'self';
  form-action 'self';
  frame-ancestors 'none';
  upgrade-insecure-requests;
`
```

### Command Injection Prevention

```typescript
// ❌ NEVER pass user input to shell commands
const { exec } = require('child_process')
exec(`convert ${userFilename} output.jpg`) // VULNERABLE

// ✅ Use libraries that don't spawn shells
import sharp from 'sharp'
await sharp(userFilename).toFile('output.jpg')

// ✅ If shell commands unavoidable, use strict allowlisting
const allowedCommands = ['resize', 'crop', 'rotate']
if (!allowedCommands.includes(userCommand)) {
  throw new Error('Invalid command')
}
```

```python
# ❌ NEVER use shell=True with user input
import subprocess
subprocess.run(f"convert {user_filename} output.jpg", shell=True)  # VULNERABLE

# ✅ Use list format without shell
subprocess.run(['convert', user_filename, 'output.jpg'], shell=False)

# ✅ Better: use libraries instead of shell commands
from PIL import Image
img = Image.open(user_filename)
img.save('output.jpg')
```

## Authentication and Authorization

### Authentication Requirements

```typescript
// ✅ ALWAYS hash passwords with bcrypt (12+ rounds)
import bcrypt from 'bcryptjs'

const SALT_ROUNDS = 12

async function hashPassword(password: string): Promise<string> {
  return bcrypt.hash(password, SALT_ROUNDS)
}

async function verifyPassword(password: string, hash: string): Promise<boolean> {
  return bcrypt.compare(password, hash)
}

// ✅ Implement account lockout after failed attempts
const MAX_LOGIN_ATTEMPTS = 5
const LOCKOUT_DURATION = 15 * 60 * 1000 // 15 minutes

if (user.loginAttempts >= MAX_LOGIN_ATTEMPTS) {
  if (Date.now() - user.lastFailedLogin < LOCKOUT_DURATION) {
    throw new Error('Account temporarily locked')
  }
  // Reset after lockout period
  user.loginAttempts = 0
}
```

### JWT Security

```typescript
// ✅ Proper JWT configuration
import jwt from 'jsonwebtoken'

const JWT_SECRET = process.env.JWT_SECRET! // Min 256 bits
const JWT_EXPIRES_IN = '7d'
const JWT_REFRESH_EXPIRES_IN = '30d'

// Include minimal claims
const token = jwt.sign(
  {
    userId: user.id,
    role: user.role
    // Don't include sensitive data like passwords
  },
  JWT_SECRET,
  {
    expiresIn: JWT_EXPIRES_IN,
    issuer: 'your-app-name',
    audience: 'your-app-api'
  }
)

// ✅ Verify tokens properly
try {
  const decoded = jwt.verify(token, JWT_SECRET, {
    issuer: 'your-app-name',
    audience: 'your-app-api'
  })
} catch (error) {
  if (error instanceof jwt.TokenExpiredError) {
    // Handle token refresh
  }
  throw new Error('Invalid token')
}
```

### Authorization Patterns

```typescript
// ✅ Check permissions at every endpoint
export async function DELETE_user(
  req: AuthenticatedRequest,
  { params }: { params: { userId: string } }
) {
  // Check if user can delete this resource
  if (req.user.id !== params.userId && req.user.role !== 'admin') {
    return new Response('Forbidden', { status: 403 })
  }

  // Proceed with deletion
  await deleteUser(params.userId)
  return new Response(null, { status: 204 })
}

// ✅ Implement RBAC (Role-Based Access Control)
const permissions = {
  admin: ['read', 'write', 'delete', 'manage'],
  editor: ['read', 'write'],
  viewer: ['read']
}

function hasPermission(user: User, action: string): boolean {
  return permissions[user.role]?.includes(action) ?? false
}
```

## Secrets Management

### Environment Variables

```bash
# ✅ .env.example (commit this)
DATABASE_URL="postgresql://user:password@localhost:5432/db"
JWT_SECRET="generate-secure-random-string-min-256-bits"
OPENAI_API_KEY="your-key-here"
STRIPE_SECRET_KEY="sk_test_..."

# ❌ NEVER commit .env file (add to .gitignore)
```

### Secret Rotation

```typescript
// ✅ Support multiple valid secrets during rotation
const CURRENT_JWT_SECRET = process.env.JWT_SECRET!
const PREVIOUS_JWT_SECRET = process.env.JWT_SECRET_PREVIOUS

function verifyToken(token: string) {
  try {
    return jwt.verify(token, CURRENT_JWT_SECRET)
  } catch (error) {
    if (PREVIOUS_JWT_SECRET) {
      return jwt.verify(token, PREVIOUS_JWT_SECRET)
    }
    throw error
  }
}
```

### API Key Security

```typescript
// ✅ Store API keys encrypted
import crypto from 'crypto'

const ENCRYPTION_KEY = Buffer.from(process.env.ENCRYPTION_KEY!, 'hex')
const IV_LENGTH = 16

function encryptApiKey(apiKey: string): string {
  const iv = crypto.randomBytes(IV_LENGTH)
  const cipher = crypto.createCipheriv('aes-256-gcm', ENCRYPTION_KEY, iv)

  let encrypted = cipher.update(apiKey, 'utf8', 'hex')
  encrypted += cipher.final('hex')

  const authTag = cipher.getAuthTag()

  return iv.toString('hex') + ':' + authTag.toString('hex') + ':' + encrypted
}
```

## Data Protection

### Encryption at Rest

```typescript
// ✅ Encrypt sensitive fields in database
import { createCipheriv, createDecipheriv, randomBytes } from 'crypto'

class EncryptionService {
  private readonly algorithm = 'aes-256-gcm'
  private readonly key = Buffer.from(process.env.ENCRYPTION_KEY!, 'hex')

  encrypt(text: string): string {
    const iv = randomBytes(16)
    const cipher = createCipheriv(this.algorithm, this.key, iv)

    let encrypted = cipher.update(text, 'utf8', 'hex')
    encrypted += cipher.final('hex')

    const authTag = cipher.getAuthTag()

    return iv.toString('hex') + ':' + authTag.toString('hex') + ':' + encrypted
  }

  decrypt(encryptedText: string): string {
    const [ivHex, authTagHex, encrypted] = encryptedText.split(':')

    const decipher = createDecipheriv(
      this.algorithm,
      this.key,
      Buffer.from(ivHex, 'hex')
    )

    decipher.setAuthTag(Buffer.from(authTagHex, 'hex'))

    let decrypted = decipher.update(encrypted, 'hex', 'utf8')
    decrypted += decipher.final('utf8')

    return decrypted
  }
}

// Mark sensitive fields in Prisma schema
// model User {
//   email String @db.Text // Store encrypted
//   ssn   String @db.Text // Store encrypted
// }
```

### GDPR Compliance

```typescript
// ✅ Implement data export
export async function exportUserData(userId: string) {
  const userData = await prisma.user.findUnique({
    where: { id: userId },
    include: {
      sessions: true,
      teams: true,
      // Include all related data
    }
  })

  return userData
}

// ✅ Implement data deletion
export async function deleteUserData(userId: string) {
  // Soft delete first (30-day grace period)
  await prisma.user.update({
    where: { id: userId },
    data: {
      deletedAt: new Date(),
      email: `deleted-${userId}@example.com`, // Anonymize
      name: 'Deleted User'
    }
  })

  // Hard delete after 30 days (scheduled job)
}
```

### Audit Logging

```typescript
// ✅ Log sensitive operations
interface AuditLog {
  userId: string
  action: string
  resource: string
  resourceId: string
  ipAddress: string
  userAgent: string
  timestamp: Date
  metadata?: Record<string, any>
}

async function createAuditLog(log: AuditLog) {
  await prisma.auditLog.create({ data: log })

  // Also send to external log system (immutable)
  await sendToLogStream(log)
}

// Track these actions:
// - Authentication (login, logout, password changes)
// - Authorization changes (role updates, permission grants)
// - Data access (viewing PII, exporting data)
// - Data modifications (creating, updating, deleting records)
// - Administrative actions (user management, system config)
```

## Common Vulnerabilities to Prevent

### CWE-94: Code Injection

```typescript
// ❌ NEVER use eval or Function constructor with user input
eval(userInput) // VULNERABLE
new Function(userInput)() // VULNERABLE

// ✅ Use safe alternatives
const allowedOperations = {
  add: (a, b) => a + b,
  subtract: (a, b) => a - b
}

const result = allowedOperations[userOperation]?.(a, b)
```

### CWE-78: OS Command Injection

See "Command Injection Prevention" section above.

### CWE-190: Integer Overflow

```typescript
// ✅ Validate numeric ranges
const MAX_SAFE_INTEGER = Number.MAX_SAFE_INTEGER // 2^53 - 1

function safeAdd(a: number, b: number): number {
  if (a > MAX_SAFE_INTEGER - b) {
    throw new Error('Integer overflow')
  }
  return a + b
}

// ✅ Use BigInt for large numbers
const largeNumber = BigInt("9007199254740991")
```

### CWE-306: Missing Authentication

```typescript
// ❌ NEVER skip authentication checks
app.delete('/api/users/:id', async (req, res) => {
  await deleteUser(req.params.id) // VULNERABLE - no auth check
})

// ✅ ALWAYS require authentication
app.delete('/api/users/:id', requireAuth, async (req, res) => {
  // req.user populated by requireAuth middleware
  if (req.user.id !== req.params.id && req.user.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' })
  }
  await deleteUser(req.params.id)
})
```

### CWE-434: Unrestricted File Upload

```typescript
// ✅ Validate file uploads strictly
import multer from 'multer'
import path from 'path'

const ALLOWED_MIME_TYPES = ['image/jpeg', 'image/png', 'image/webp']
const MAX_FILE_SIZE = 10 * 1024 * 1024 // 10MB

const upload = multer({
  limits: { fileSize: MAX_FILE_SIZE },
  fileFilter: (req, file, cb) => {
    if (!ALLOWED_MIME_TYPES.includes(file.mimetype)) {
      return cb(new Error('Invalid file type'))
    }

    // Validate file extension matches MIME type
    const ext = path.extname(file.originalname).toLowerCase()
    const validExtensions = ['.jpg', '.jpeg', '.png', '.webp']

    if (!validExtensions.includes(ext)) {
      return cb(new Error('Invalid file extension'))
    }

    cb(null, true)
  }
})

// ✅ Scan files for malware (use ClamAV or similar)
// ✅ Store files outside web root
// ✅ Generate random filenames (don't use user-provided names)
```

### SSRF (Server-Side Request Forgery)

```typescript
// ✅ Validate and restrict outbound requests
const ALLOWED_DOMAINS = ['api.trusted-service.com']

async function fetchExternalResource(url: string) {
  const parsedUrl = new URL(url)

  // Block private IP ranges
  const hostname = parsedUrl.hostname
  if (
    hostname === 'localhost' ||
    hostname.startsWith('127.') ||
    hostname.startsWith('192.168.') ||
    hostname.startsWith('10.') ||
    hostname.match(/^172\.(1[6-9]|2[0-9]|3[0-1])\./)
  ) {
    throw new Error('Access to private IPs denied')
  }

  // Allowlist approach
  if (!ALLOWED_DOMAINS.some(domain => hostname.endsWith(domain))) {
    throw new Error('Domain not in allowlist')
  }

  return fetch(url)
}
```

## Security Headers

```typescript
// next.config.js or middleware.ts
export function middleware(request: NextRequest) {
  const response = NextResponse.next()

  // Security headers
  response.headers.set('X-DNS-Prefetch-Control', 'on')
  response.headers.set('Strict-Transport-Security', 'max-age=63072000; includeSubDomains; preload')
  response.headers.set('X-Frame-Options', 'SAMEORIGIN')
  response.headers.set('X-Content-Type-Options', 'nosniff')
  response.headers.set('Referrer-Policy', 'origin-when-cross-origin')
  response.headers.set('Permissions-Policy', 'camera=(), microphone=(), geolocation=()')

  // CSP header
  response.headers.set('Content-Security-Policy', cspHeader.replace(/\s{2,}/g, ' ').trim())

  return response
}
```

## Rate Limiting

```typescript
// ✅ Implement rate limiting
import rateLimit from 'express-rate-limit'

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP',
  standardHeaders: true,
  legacyHeaders: false,
})

app.use('/api/', limiter)

// ✅ Stricter limits for sensitive endpoints
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5, // 5 attempts per 15 minutes
  skipSuccessfulRequests: true, // Don't count successful logins
})

app.post('/api/auth/login', authLimiter, loginHandler)
```

## Security Checklist for AI Agents

Before generating or modifying code, verify:

- [ ] All user inputs are validated with strict schemas
- [ ] No SQL string concatenation (use parameterized queries)
- [ ] No `eval()`, `Function()`, or `exec()` with user input
- [ ] Passwords hashed with bcrypt (12+ rounds)
- [ ] JWT secrets are 256+ bits, stored securely
- [ ] Authentication required on all protected endpoints
- [ ] Authorization checks before data access/modification
- [ ] No secrets committed to code (use environment variables)
- [ ] Sensitive data encrypted at rest (PII, payment info)
- [ ] File uploads validated (MIME type, extension, size)
- [ ] Rate limiting implemented on API endpoints
- [ ] Security headers set (CSP, HSTS, X-Frame-Options)
- [ ] Audit logging for sensitive operations
- [ ] Error messages don't leak sensitive information
- [ ] Dependencies scanned for vulnerabilities

---

**Remember**: Security is not optional. Every line of AI-generated code must be reviewed with a security-first mindset.
