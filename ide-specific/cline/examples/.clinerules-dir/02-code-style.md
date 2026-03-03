# FocusFlow Code Style

## TypeScript/React
- Strict mode with exactOptionalPropertyTypes
- Explicit return types on all functions
- Prefer `type` over `interface`
- Server Components by default; `'use client'` only when needed
- No default exports (except Next.js pages/layouts)

## Python
- Type hints required for all functions
- Pydantic for validation
- async/await for all I/O
- PEP 8 + Black (line length 88)

## Naming
- Files: kebab-case.tsx, snake_case.py
- Components: PascalCase
- Functions: camelCase with verb prefixes
- Constants: UPPER_SNAKE_CASE

## Formatting
- 2 spaces (TS), 4 spaces (Python)
- 100 chars (TS), 88 chars (Python)
- Single quotes (TS), double quotes (Python)

## Patterns
- Repository pattern, Service layer, CQRS, Atomic design
