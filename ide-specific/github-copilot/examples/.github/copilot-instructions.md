# FocusFlow - AI-Powered Productivity Platform

## Project Overview
FocusFlow is an advanced productivity SaaS platform combining Pomodoro technique, AI-driven insights, team synchronization, and analytics for remote teams.

**Architecture**: Microservices with event-driven architecture
**Scale**: Series A startup targeting 10K+ MAU

## Tech Stack
- **Frontend**: TypeScript 5.3+, Next.js 14.2 (App Router), React 18.3, TailwindCSS 3.4
- **Backend**: NestJS 10.3, FastAPI 0.110+ (Python analytics)
- **Database**: PostgreSQL 16 (Prisma), MongoDB 7.0 (analytics), Redis 7.2+
- **Testing**: Vitest 1.4, Playwright 1.42, pytest 8.1
- **Package Manager**: pnpm 9.x

### DO NOT Use
- Redux (use Zustand), Axios (use fetch), Moment.js (use date-fns)
- CSS-in-JS (use TailwindCSS), GraphQL (REST + WebSocket)

## Core Principles
1. Clarify intent before generating code
2. Choose simplest viable solution
3. No new dependencies without approval
4. Validate all user input (Zod + Pydantic)
5. Never store secrets in code
6. Conventional commits: `type(scope): description`

## Code Style
- Files: `kebab-case.tsx`, `snake_case.py`
- Components: PascalCase, Functions: camelCase with verb prefixes
- 2 spaces (TS), 4 spaces (Python)
- Single quotes (TS), double quotes (Python)
- Explicit return types, no `any`
- Server Components by default; `'use client'` only when needed

## Commands
```bash
pnpm install        # Install
pnpm dev            # Dev server (all services)
pnpm test           # Run tests
pnpm build          # Build
```

## Key Files
- `apps/web/middleware.ts` — Auth and route protection
- `services/api/prisma/schema.prisma` — Database schema
- `apps/web/lib/schemas/` — Zod validation schemas
- `apps/web/styles/tokens.ts` — Design tokens

## Workflow
- Feature branches: `feature/FOCUS-123-description`
- Run `pnpm lint && pnpm typecheck && pnpm test` before PRs
