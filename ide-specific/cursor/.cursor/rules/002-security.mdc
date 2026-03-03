---
description: Security rules for AI-generated code — applied to all files
globs:
alwaysApply: true
---

# Security Rules

## Core Principles
- All AI-generated code requires human security review
- Trust nothing, verify everything
- Defense in depth: multiple security layers
- Principle of least privilege

## Input Validation (MANDATORY)
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
