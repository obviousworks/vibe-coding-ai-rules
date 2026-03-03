# FocusFlow - Project Context

## Overview
FocusFlow is an advanced productivity SaaS platform combining Pomodoro technique, AI-driven insights, team synchronization, and analytics for remote teams.

**Architecture**: Microservices with event-driven architecture
**Scale**: Series A startup targeting 10K+ MAU

## Tech Stack
- **Frontend**: TypeScript 5.3+, Next.js 14.2, React 18.3, TailwindCSS 3.4
- **Backend**: NestJS 10.3, FastAPI 0.110+ (Python)
- **Database**: PostgreSQL 16 (Prisma), MongoDB 7.0, Redis 7.2+
- **Testing**: Vitest 1.4, Playwright 1.42, pytest 8.1
- **Package Manager**: pnpm 9.x

## DO NOT Use
- Redux (use Zustand), Axios (use fetch), Moment.js (use date-fns)
- CSS-in-JS (use TailwindCSS), GraphQL (REST + WebSocket)

## Commands
```bash
pnpm install        # Install
pnpm dev            # All services
pnpm test           # Tests
pnpm build          # Build
```

## Key Files
- `apps/web/middleware.ts` — Auth
- `services/api/prisma/schema.prisma` — DB schema
- `apps/web/lib/schemas/` — Zod schemas
