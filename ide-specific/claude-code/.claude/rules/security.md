# Security Rules

## Input Validation
- Validate ALL user input with schema validation (Zod, Pydantic)
- Never trust client-side data
- Sanitize HTML before rendering (DOMPurify)
- Validate file uploads: MIME type, extension, max size

## Injection Prevention
- NEVER concatenate SQL — parameterized queries only
- NEVER pass user input to shell commands
- NEVER use eval() or Function() with user data
- NEVER use dangerouslySetInnerHTML without sanitization

## Secrets & Auth
- No secrets in source code — environment variables only
- No credentials in client-side code
- JWT validation with algorithm pinning
- httpOnly, secure, sameSite cookies
- Principle of least privilege

## API Security
- Rate limiting on all endpoints
- CORS: explicit origins only
- Input size limits
- Security headers (CSP, HSTS, X-Frame-Options)

## Review
- All AI-generated code requires human security review
- Flag security concerns immediately to the developer
