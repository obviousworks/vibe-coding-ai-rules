---
description: FocusFlow project context and tech stack
globs:
alwaysApply: true
---

# FocusFlow - AI-Powered Productivity Platform

## Project Overview
FocusFlow is an advanced productivity SaaS platform combining Pomodoro technique, AI-driven insights, team synchronization, and analytics for remote teams.

**Architecture**: Microservices with event-driven architecture
**Scale**: Series A startup targeting 10K+ MAU

## Tech Stack
- **Frontend**: TypeScript 5.3+, Next.js 14.2 (App Router), React 18.3, TailwindCSS 3.4
- **Backend**: NestJS 10.3, FastAPI 0.110+ (Python analytics)
- **Database**: PostgreSQL 16 (Prisma ORM), MongoDB 7.0 (analytics), Redis 7.2+ (cache)
- **Testing**: Vitest 1.4, Playwright 1.42, pytest 8.1
- **Package Manager**: pnpm 9.x

## DO NOT Use
- Redux (use Zustand)
- Axios (use native fetch)
- Moment.js (use date-fns)
- CSS-in-JS (use TailwindCSS)
- GraphQL (REST + WebSocket)

## Key Commands
```bash
pnpm install          # Install dependencies
pnpm dev              # Start all services
pnpm test             # Run tests
pnpm build            # Build for production
```

## Key Files
- `apps/web/middleware.ts` — Auth and route protection
- `services/api/prisma/schema.prisma` — Database schema
- `apps/web/lib/schemas/` — Zod validation schemas
- `apps/web/styles/tokens.ts` — Design tokens
