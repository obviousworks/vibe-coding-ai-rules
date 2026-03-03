# FocusFlow

AI-powered productivity SaaS: Pomodoro + AI insights + team sync + analytics for remote teams.

## Tech Stack
- TypeScript 5.3+ (strict), Python 3.12+ (analytics)
- Next.js 14.2 (App Router), NestJS 10.3, FastAPI 0.110+
- PostgreSQL 16 (Prisma), MongoDB 7.0, Redis 7.2+
- Vitest 1.4, Playwright 1.42, pytest 8.1
- pnpm 9.x (monorepo)

DO NOT use: Redux, Axios, Moment.js, CSS-in-JS, GraphQL

## Core Rules
- Clarify intent before generating code
- Simplest viable solution — justify complexity
- No new deps without approval
- Validate all input (Zod client+server, Pydantic backend)
- No secrets in code — env vars only
- No SQL concatenation — Prisma parameterized queries
- Conventional commits: type(scope): description

## Code Style
- Files: kebab-case.tsx, snake_case.py
- 2 spaces (TS), 4 spaces (Python)
- Single quotes (TS), double quotes (Python)
- Explicit return types, no `any`

## Commands
```bash
pnpm install          # Install
pnpm dev              # All services
pnpm test             # Tests
pnpm build            # Build
```

## Key Files
- `apps/web/middleware.ts` — Auth
- `services/api/prisma/schema.prisma` — DB schema
- `apps/web/lib/schemas/` — Zod schemas
- `apps/web/styles/tokens.ts` — Design tokens

## When Uncertain
Ask first. Propose plan for complex changes. Reference existing patterns.
