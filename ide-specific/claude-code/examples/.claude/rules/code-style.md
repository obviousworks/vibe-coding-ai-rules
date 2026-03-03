# FocusFlow Code Style

## TypeScript/React
- Strict mode with exactOptionalPropertyTypes
- Explicit return types on all functions
- Prefer `type` over `interface`
- Server Components by default; `'use client'` only when needed
- No default exports (except Next.js pages/layouts)
- Radix UI + TailwindCSS for components
- Design tokens from `apps/web/styles/tokens.ts`

## Python
- Type hints required (all functions)
- Pydantic for validation
- async/await for all I/O
- PEP 8 + Black (line length 88)

## Naming
- Files: kebab-case.tsx, snake_case.py
- Components: PascalCase
- Functions: camelCase with verb prefixes
- Constants: UPPER_SNAKE_CASE

## Patterns
- Repository pattern for data access
- Service layer for business logic
- CQRS for analytics
- Atomic design for UI
