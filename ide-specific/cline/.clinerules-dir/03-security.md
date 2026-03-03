# Security Rules

## Input Validation
- Validate ALL user input with schema validation (Zod, Pydantic, etc.)
- Never trust client-side data
- Sanitize HTML content before rendering
- Validate file uploads: MIME type, extension, max size

## Injection Prevention
- NEVER concatenate SQL strings — use parameterized queries
- NEVER pass user input to shell commands
- NEVER use dangerouslySetInnerHTML without DOMPurify
- NEVER use eval() or Function() with user input

## Authentication & Secrets
- Never store secrets in source code or client-side code
- Use environment variables for all credentials
- Implement proper JWT validation with algorithm pinning
- Use httpOnly, secure, sameSite cookies

## API Security
- Rate limiting on all endpoints
- CORS configuration: explicit origins only
- Input size limits on all endpoints
- Proper HTTP security headers (CSP, HSTS, etc.)
