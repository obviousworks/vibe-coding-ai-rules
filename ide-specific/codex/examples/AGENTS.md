# FocusFlow - AI-Powered Productivity Platform

## Project Overview

FocusFlow is an advanced productivity SaaS platform combining Pomodoro technique, AI-driven insights, team synchronization, and analytics to optimize deep work and collaboration for remote teams.

**Architecture**: Microservices with event-driven architecture
**Domain**: Productivity SaaS / Team Collaboration
**Scale**: Series A startup targeting 10K+ MAU

## Tech Stack

- **Language**: TypeScript 5.3+ (strict mode), Python 3.12+ (analytics)
- **Framework**: Next.js 14.2 (App Router), NestJS 10.3, FastAPI 0.110+
- **Database**: PostgreSQL 16 (Prisma ORM), MongoDB 7.0 (analytics), Redis 7.2+
- **Testing**: Vitest 1.4, Playwright 1.42, pytest 8.1
- **Package Manager**: pnpm 9.x (monorepo)
- **Frontend**: React 18.3, TailwindCSS 3.4, Radix UI, Zustand 4.5
- **Real-time**: Socket.io 4.7

### DO NOT Use
- Redux (use Zustand), Axios (use native fetch), Moment.js (use date-fns)
- CSS-in-JS (use TailwindCSS), GraphQL (REST + WebSocket)

## Core Rules

- Clarify intent before generating code — no guessing at business logic
- Choose simplest viable solution — justify any added complexity
- No new dependencies without explicit approval
- Validate all user input: Zod (client + server), Pydantic (Python)
- Never store secrets in code — env vars only
- Never concatenate SQL — Prisma parameterized queries only
- Use conventional commits: `type(scope): description`

## Code Style

### TypeScript/React
- Strict mode with `exactOptionalPropertyTypes`
- All functions must have explicit return types
- Prefer `type` over `interface` for object shapes
- Server Components by default; `'use client'` only when needed
- No default exports (except Next.js pages/layouts)
- No `any` — use `unknown` with type guards

### Python
- Type hints required for all functions (including return type)
- Pydantic models for data validation
- Async/await for all I/O operations
- PEP 8 + Black (line length 88)

### Naming
- Files: `kebab-case.tsx`, `snake_case.py`
- Components: PascalCase
- Functions: camelCase with verb prefixes (`getUserData`, `calculateTotal`)
- Constants: UPPER_SNAKE_CASE

### Formatting
- Indentation: 2 spaces (TS), 4 spaces (Python)
- Line length: 100 chars (TS), 88 chars (Python)
- Single quotes (TS), double quotes (Python)
- Semicolons required (TS)

## Security

- Zod schemas on client AND server, Pydantic for Python backend
- JWT with refresh tokens, algorithm pinning (RS256)
- RBAC: Admin, Team Owner, Member, Viewer
- All endpoints require auth except `/auth/*` and `/health`
- NEVER pass user input to shell commands
- NEVER use `eval()` or `Function()` with user data
- Rate limiting: 100 req/min per user
- CORS: `app.focusflow.com` only

## Testing

- Vitest 1.4 (TS unit), Playwright 1.42 (E2E), pytest 8.1 (Python)
- 85% coverage for critical paths (auth, payments, data processing)
- Mock external APIs (OpenAI, Stripe), use test DB for integration
- AAA pattern: Arrange, Act, Assert
- Test location: `__tests__/` or `.test.ts` suffix

## Commands

```bash
pnpm install          # Install dependencies
pnpm dev              # Start all services
pnpm test             # Run tests
pnpm build            # Build for production
pnpm lint             # Lint
pnpm typecheck        # Type check
pnpm test:e2e         # E2E tests
```

Always run `pnpm test` after modifying code. Use file-scoped commands for individual changes:
```bash
pnpm vitest run path/to/file.test.ts   # Single test
pnpm eslint path/to/file.ts            # Single file lint
```

## Key Files

- `apps/web/middleware.ts` — Auth and route protection
- `services/api/prisma/schema.prisma` — Database schema
- `apps/web/lib/schemas/` — Zod validation schemas
- `apps/web/styles/tokens.ts` — Design tokens
- `apps/web/app/dashboard/components/TimerCard.tsx` — Server component example
- `apps/web/lib/hooks/use-timer.ts` — Custom hook example
- `services/api/src/services/ai/insights-generator.ts` — Service layer example

## Project Structure

```
focusflow/
├── apps/
│   └── web/                    # Next.js frontend
├── services/
│   ├── api/                    # NestJS API gateway
│   ├── analytics/              # Python FastAPI analytics
│   └── realtime/               # Socket.io server
├── packages/
│   ├── shared-types/           # Shared TypeScript types
│   ├── ui-components/          # Shared React components
│   └── config/                 # Shared configs
└── infrastructure/             # Docker, K8s, Terraform
```

## Patterns

- Repository pattern for data access
- Service layer for business logic
- CQRS for analytics (separate read/write models)
- Atomic design for UI components
- Event-driven communication between microservices

## Workflow

- Atomic changes: small, self-contained modifications
- Only modify files related to the current task
- Branches: `feature/FOCUS-123-description`, `fix/FOCUS-456-description`
- Before PR: `pnpm lint && pnpm typecheck && pnpm test`
- Remove debug logs and commented code before committing

## When Uncertain

Ask clarifying questions before implementing — especially for security-sensitive features. Propose a plan for complex changes. Reference existing patterns in the codebase.
