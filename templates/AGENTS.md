# AGENTS.md - Quick-Start Template

> This is the quick-start template. For the comprehensive version, see the root AGENTS.md.
> Copy this file to your project root and fill in the `[placeholder]` values.

# [Project Name]

## Project Overview
[One-sentence description of the project]

**Architecture**: [Monolith / Microservices / Serverless / JAMstack]
**Domain**: [E-commerce / Healthcare / Finance / SaaS / etc.]

## Tech Stack
- **Language**: [e.g., TypeScript 5.x, Python 3.12+]
- **Framework**: [e.g., Next.js, FastAPI, Spring Boot]
- **Database**: [e.g., PostgreSQL 16, MongoDB 7]
- **Package Manager**: [npm / pnpm / pip / poetry]

## Setup Commands
```bash
[install command]        # Install dependencies
[env setup command]      # Setup environment
[dev command]            # Start development server
```

## Core Rules

### 1. Clarify Before Coding
Understand requirements before writing code. Ask questions when intent is unclear. No code without clear goals.

### 2. Simplicity First
Choose the simplest viable solution. Complex patterns need explicit justification. Readable code over clever code.

### 3. Security By Default
Validate all inputs. No secrets in code. Defense in depth. Least privilege principle.

### 4. Test-Driven Thinking
Design all code to be testable from inception. Write tests alongside code. Verify before committing.

## Code Style
- **Naming**: [e.g., camelCase functions, PascalCase components, UPPER_SNAKE constants]
- **Formatting**: [e.g., 2 spaces, 100 char line limit, single quotes]
- **Linter/Formatter**: [e.g., ESLint + Prettier / Ruff + Black]

## Testing
```bash
[command] path/to/test   # Run single test (preferred)
[command]                # Run full suite (use sparingly)
```
- **Test location**: [e.g., __tests__/ directories, *.test.ts alongside source]
- **Mocking**: [e.g., Mock external APIs, use test database]

## Security
- **Auth**: [e.g., JWT-based, OAuth2, session-based]
- **Secrets**: Use `.env` for local, [e.g., AWS Secrets Manager] for production
- **Validation**: [e.g., Zod schemas on client and server]

## Git Workflow
- **Branches**: `feature/[id]-description`, `fix/[id]-description`
- **Commits**: `type(scope): description` (types: feat, fix, docs, refactor, test, chore)
- **Before PR**: Run lint, type check, and tests; remove debug code

---

**Last Updated**: [Date]
**Maintained By**: [Team/Individual]
