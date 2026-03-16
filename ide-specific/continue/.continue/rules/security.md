---
name: Security
alwaysApply: true
---

# Security Rules

## Input Validation
- Validate ALL user input with schema validation (Zod, Pydantic, etc.)
- Never trust client-side data
- Sanitize HTML content before rendering
- Validate file uploads: MIME type, extension, max size

## Injection Prevention
- NEVER concatenate SQL strings — use parameterized queries only
- NEVER pass user input to shell commands
- NEVER use eval() or Function() with user input
- NEVER use dangerouslySetInnerHTML without sanitization

## Secrets and Authentication
- No secrets in source code — use environment variables
- No credentials in client-side code
- Implement proper JWT validation with algorithm pinning
- Use httpOnly, secure, sameSite cookies
- Apply principle of least privilege

## API Security
- Rate limiting on all endpoints
- CORS configuration: explicit origins only
- Input size limits on all endpoints
- Proper HTTP security headers (CSP, HSTS, X-Frame-Options)

## Review
- All AI-generated code requires human security review
- Flag security concerns immediately to the developer
