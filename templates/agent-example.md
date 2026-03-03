# FocusFlow - AI-Powered Productivity Platform

## Project Overview
FocusFlow is an advanced productivity SaaS platform combining Pomodoro technique, AI-driven insights, team synchronization, and analytics to optimize deep work and collaboration for remote teams.

**Architecture**: Microservices with event-driven architecture
**Domain**: Productivity SaaS / Team Collaboration
**Scale**: Series A startup targeting 10K+ MAU

## Tech Stack

### Core Technologies
- **Language**: TypeScript 5.3+ (strict mode), Python 3.12+ (analytics services)
- **Framework**: Next.js 14.2 (App Router), FastAPI 0.110+
- **Database**: PostgreSQL 16 with Prisma ORM 5.x, MongoDB 7.0 (time-series analytics)
- **Cache**: Redis 7.2+ (sessions, real-time state)
- **Package Manager**: pnpm 9.x (workspace management)

### Key Dependencies
- **Frontend**: React 18.3, TailwindCSS 3.4, Radix UI primitives, Zustand 4.5
- **Backend**: NestJS 10.3, Fastify 4.26, Socket.io 4.7 (real-time)
- **Testing**: Vitest 1.4, Playwright 1.42, pytest 8.1
- **Observability**: OpenTelemetry, Grafana, Sentry
- **AI/ML**: OpenAI GPT-4, LangChain, Pinecone (vector DB)

### Development Tools
- **Linter**: ESLint 9.x with TypeScript plugin, Ruff (Python)
- **Formatter**: Prettier 3.2, Black (Python)
- **Type Checker**: TypeScript strict mode, mypy strict
- **Testing**: Jest for unit, Playwright for E2E, pytest for Python

### Explicitly DO NOT Use
- Redux (use Zustand instead)
- Axios (use native fetch with retry logic)
- Moment.js (use date-fns)
- class-based React components (functional only)
- CSS-in-JS libraries (TailwindCSS only)
- GraphQL (REST + WebSocket architecture)

## Setup Commands

```bash
# Install dependencies (monorepo)
pnpm install

# Setup environment
cp .env.example .env
# Edit .env with: DATABASE_URL, REDIS_URL, OPENAI_API_KEY, etc.

# Database setup
pnpm db:migrate:deploy
pnpm db:seed

# Start development (all services)
pnpm dev

# Start individual services
pnpm dev:web      # Frontend on :3000
pnpm dev:api      # API gateway on :8000
pnpm dev:analytics # Analytics service on :8001
```

## Build and Development Commands

### File-Scoped Commands (Preferred - Fast)

```bash
# Type check single file (2-3 seconds)
pnpm tsc --noEmit apps/web/app/dashboard/page.tsx

# Format single file
pnpm prettier --write apps/web/components/Timer.tsx

# Lint single file
pnpm eslint apps/web/lib/utils.ts

# Run single test file
pnpm vitest run apps/web/__tests__/timer.test.ts

# Python type check single file
mypy services/analytics/app/insights.py

# Python lint single file
ruff check services/analytics/app/models.py
```

### Project-Wide Commands (Use Sparingly)

```bash
# Full type check (90 seconds)
pnpm typecheck

# Full test suite (4 minutes)
pnpm test

# Full build (5 minutes)
pnpm build

# E2E tests (6 minutes)
pnpm test:e2e
```

**Important**: Always use file-scoped commands for individual changes. Only run project-wide commands when explicitly requested or before final commit/PR creation.

## Code Style and Conventions

### TypeScript/React Rules
- Use TypeScript strict mode with `exactOptionalPropertyTypes` enabled
- All functions must have explicit return types
- Prefer `type` over `interface` for object shapes
- Use `const` assertions for literal types
- Server Components by default; Client Components only when needed (`'use client'`)
- No default exports (except for Next.js pages/layouts)

### Python Rules
- Type hints required for all functions (including return type)
- Use Pydantic models for data validation
- Async/await for all I/O operations
- Follow PEP 8 style guide strictly
- Use structural pattern matching (Python 3.10+) over complex if/else

### Naming Conventions
- **Files**: `kebab-case.tsx`, `snake_case.py`
- **Components**: `PascalCase` (e.g., `TimerWidget.tsx`)
- **Functions**: `camelCase` with verb prefixes (e.g., `getUserSessions`, `calculateProductivity`)
- **Variables**: `camelCase` with auxiliary verbs for booleans (e.g., `isActive`, `hasPermission`)
- **Constants**: `UPPER_SNAKE_CASE`
- **Types/Interfaces**: `PascalCase` (e.g., `UserProfile`, `SessionData`)
- **Enums**: `PascalCase` for name, `UPPER_SNAKE_CASE` for values

### Formatting Rules
- **Indentation**: 2 spaces (TS/JS), 4 spaces (Python)
- **Line Length**: 100 characters max (TS), 88 characters (Python)
- **Quotes**: Single quotes (TS), double quotes (Python)
- **Semicolons**: Required (TypeScript)
- **Trailing Commas**: Always (multi-line)
- **Comments**: JSDoc for public APIs, inline for complex logic

### Do's ✅
- Use server actions for mutations: `apps/web/app/actions/timer.ts`
- Implement optimistic updates for better UX
- Use Zod for runtime validation: `apps/web/lib/schemas/user.ts`
- Leverage React Query for server state management
- Use design tokens from `apps/web/styles/tokens.ts` - never hardcode colors/spacing
- Implement proper error boundaries: `apps/web/components/ErrorBoundary.tsx`
- Use Prisma transactions for multi-step operations
- Implement retry logic with exponential backoff for external API calls
- Use WebSocket rooms for team synchronization features

### Don'ts ❌
- No `any` types - use `unknown` and type guards instead
- No unhandled promise rejections - always handle errors
- No direct DOM manipulation - use React refs when necessary
- No inline styles - use TailwindCSS utilities
- No blocking operations in React components
- No SQL string concatenation - use Prisma parameterized queries
- No business logic in components - use service layer
- No secrets in client-side code

### Good and Bad Examples

**Avoid** (Anti-patterns):
- `apps/web/app/(old)/dashboard/OLD_Timer.tsx` - Legacy class component pattern
- `services/api/src/routes/users/unprotected.ts` - Missing authentication middleware
- `apps/web/lib/utils/string-utils.ts` - Duplicate lodash functionality

**Prefer** (Good patterns):
- `apps/web/app/dashboard/components/TimerCard.tsx` - Modern server component pattern
- `services/api/src/services/ai/insights-generator.ts` - Clean service layer implementation
- `apps/web/lib/hooks/use-timer.ts` - Reusable custom hook pattern
- For authentication: Copy `apps/web/middleware.ts` pattern
- For API endpoints: Follow `services/api/src/routes/sessions/create.ts` structure

## Project Structure

```
focusflow/
├── apps/
│   ├── web/                    # Next.js frontend
│   │   ├── app/               # App router pages
│   │   ├── components/        # Shared React components
│   │   ├── lib/               # Utilities, hooks, schemas
│   │   └── styles/            # Global styles, tokens
│   │
│   └── mobile/                # React Native (future)
│
├── services/
│   ├── api/                   # NestJS API gateway
│   │   ├── src/
│   │   │   ├── modules/      # Feature modules
│   │   │   ├── services/     # Business logic
│   │   │   └── middleware/   # Auth, logging, etc.
│   │   └── prisma/           # Database schema
│   │
│   ├── analytics/            # Python FastAPI analytics
│   │   ├── app/
│   │   │   ├── models/       # Data models
│   │   │   ├── services/     # Analytics logic
│   │   │   └── routers/      # API endpoints
│   │   └── tests/            # pytest tests
│   │
│   └── realtime/             # Socket.io server
│       └── src/              # WebSocket handlers
│
├── packages/
│   ├── shared-types/         # Shared TypeScript types
│   ├── ui-components/        # Shared React components
│   └── config/               # Shared configs
│
└── infrastructure/           # Docker, K8s, Terraform
```

**Key Files**:
- `apps/web/middleware.ts` - Authentication and route protection
- `services/api/src/services/ai/insights-generator.ts` - AI productivity insights
- `apps/web/lib/schemas/` - Zod validation schemas
- `services/api/prisma/schema.prisma` - Database schema
- `apps/web/styles/tokens.ts` - Design system tokens

**Architecture Patterns**:
- Repository pattern for data access (services layer)
- Service layer for business logic (separated from routes)
- Event-driven communication between microservices
- CQRS for analytics (separate read/write models)
- BFF (Backend for Frontend) pattern

## Testing Instructions

### Testing Framework
- **Unit Tests**: Vitest (TS/JS), pytest (Python) - colocated with source
- **Integration Tests**: Playwright (E2E), pytest (API integration)
- **E2E Tests**: Playwright with fixtures for authenticated flows

### Running Tests

```bash
# Run all tests
pnpm test

# Run specific test file
pnpm vitest run apps/web/lib/utils/__tests__/time.test.ts

# Run tests with coverage
pnpm test:coverage

# Run tests in watch mode
pnpm test:watch

# Run E2E tests
pnpm test:e2e

# Python tests
cd services/analytics && pytest
```

### Test Requirements
- **Coverage Target**: 85% minimum for critical paths (auth, payments, data processing)
- **Test Location**: `__tests__` directory alongside source or `.test.ts` suffix
- **Test Naming**: Describe behavior, not implementation (e.g., "calculates productivity score correctly")
- **Mocking Strategy**: Mock external APIs (OpenAI, Stripe), use test database for integration tests

### Testing Patterns

```typescript
// Example: Timer logic test (apps/web/lib/timer/__tests__/timer.test.ts)
import { describe, it, expect, vi, beforeEach } from 'vitest'
import { TimerManager } from '../timer-manager'

describe('TimerManager', () => {
  let timer: TimerManager

  beforeEach(() => {
    timer = new TimerManager({ duration: 25 * 60 })
    vi.useFakeTimers()
  })

  it('transitions to break after work session completes', () => {
    timer.start()

    vi.advanceTimersByTime(25 * 60 * 1000)

    expect(timer.getState()).toBe('break')
    expect(timer.getRemainingTime()).toBe(5 * 60)
  })

  it('emits tick events every second', () => {
    const onTick = vi.fn()
    timer.on('tick', onTick)

    timer.start()
    vi.advanceTimersByTime(3000)

    expect(onTick).toHaveBeenCalledTimes(3)
  })
})
```

```python
# Example: Analytics test (services/analytics/tests/test_insights.py)
import pytest
from app.services.insights import ProductivityAnalyzer
from app.models import SessionData

@pytest.fixture
def sample_sessions():
    return [
        SessionData(duration=1500, interruptions=2, focus_score=0.8),
        SessionData(duration=1500, interruptions=1, focus_score=0.9),
    ]

def test_calculates_average_focus_score(sample_sessions):
    analyzer = ProductivityAnalyzer()

    result = analyzer.calculate_metrics(sample_sessions)

    assert result.avg_focus_score == 0.85
    assert result.total_duration == 3000
```

## Security Considerations

### Authentication & Authorization
- JWT-based authentication with refresh tokens
- Role-based access control (RBAC): Admin, Team Owner, Member, Viewer
- All API endpoints require authentication except `/auth/*` and `/health`
- Team-scoped data access enforced at middleware level
- Session tokens expire after 7 days, refresh after 30 days

### Input Validation
- Validate all user inputs on both client and server using Zod schemas
- Sanitize user-generated content (team names, notes) to prevent XSS
- Rate limiting: 100 requests/minute per user, 1000 requests/minute per team
- File upload validation: max 10MB, allowed types: image/png, image/jpeg

### Secrets Management
- **NEVER** commit secrets, API keys, or credentials to Git
- Use environment variables for all sensitive data
- Reference `.env.example` for required variables
- Secrets stored in AWS Secrets Manager in production
- Rotate API keys quarterly, database credentials every 6 months

### Security Requirements
- All database queries use Prisma parameterization (no SQL injection)
- Passwords hashed with bcrypt (12 rounds)
- HTTPS enforced in production (HSTS enabled)
- CORS configured for `app.focusflow.com` only
- Content Security Policy (CSP) headers on all responses
- API request signing for service-to-service communication

### Data Protection
- PII (email, name) encrypted at rest using AES-256
- Audit logs for sensitive operations (team creation, user deletion, data exports)
- Data retention: User data deleted 30 days after account deletion request
- GDPR compliance: data export and deletion endpoints implemented
- Session recordings anonymized (no keystrokes, only interaction events)

### Security Scanning
- Snyk for dependency vulnerabilities (run on every PR)
- SAST with SonarQube (weekly scans)
- Secrets scanning with GitGuardian (pre-commit hooks)
- Penetration testing quarterly

## Git Workflow and PR Process

### Branch Naming
- **Feature branches**: `feature/FOCUS-123-add-team-insights`
- **Bug fixes**: `fix/FOCUS-456-timer-timezone-bug`
- **Hotfixes**: `hotfix/critical-auth-bypass`
- **Chore**: `chore/upgrade-nextjs-14`

### Commit Messages
Format: `type(scope): description`

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`

**Examples**:
- `feat(timer): implement pause/resume functionality`
- `fix(analytics): correct productivity score calculation for partial sessions`
- `docs(api): add OpenAPI specs for insights endpoints`
- `perf(web): lazy load dashboard charts`

### Pull Request Requirements

**Before Creating PR**:
- [ ] Run `pnpm lint` - all checks pass
- [ ] Run `pnpm typecheck` - no errors
- [ ] Run `pnpm test` - all tests pass
- [ ] Run `pnpm build` - builds successfully
- [ ] Run security scan locally: `pnpm audit`
- [ ] Update relevant documentation (README, API docs)
- [ ] Remove debug logs, console.logs, commented code
- [ ] Add/update tests for new functionality

**PR Title**: `feat(timer): add pause/resume with state persistence`

**PR Description Must Include**:
```markdown
## Summary
Brief description of changes and why they're needed

## Related Issue
Fixes #123 or Related to #456

## Changes Made
- Added pause/resume buttons to timer UI
- Implemented state persistence to localStorage
- Updated timer tests to cover new functionality

## Testing Performed
- [ ] Unit tests added and passing
- [ ] Manual testing in Chrome, Firefox, Safari
- [ ] Tested with 10+ team members in staging

## Screenshots (for UI changes)
[Attach screenshots here]

## Breaking Changes
- None / List breaking changes if any

## Deployment Notes
- Database migrations required: Yes/No
- Environment variables added: Yes/No (list them)
- Third-party service changes: Yes/No
```

**PR Review Checklist**:
- Code follows style guidelines
- Tests cover new functionality
- Documentation updated
- No console.logs or debug code
- Security considerations addressed
- Performance impact assessed

### Git Operations Safety

**Allowed Without Asking**:
- Creating commits with descriptive messages
- Creating feature branches from `main`
- Pushing to your feature branches
- Creating pull requests
- Searching git history and blame
- Fetching and pulling latest changes

**Require Approval First**:
- Force pushing (use `--force-with-lease` if absolutely necessary)
- Pushing directly to `main`, `develop`, or `staging`
- Deleting branches (except your own feature branches after merge)
- Rebasing shared branches
- Modifying git history (rebase, squash on shared branches)
- Cherry-picking commits between branches

## Safety and Permissions

### Operations Allowed Without Prompting
- Read files, list directory contents, search codebase
- Type check, lint, format single files
- Run single unit test file
- View git history, diffs, and logs
- Install dev dependencies listed in package.json
- Create new feature branches
- Commit changes to feature branches

### Operations That Require Approval
- Installing NEW packages or dependencies (not in package.json)
- Modifying configuration files (`package.json`, `tsconfig.json`, `next.config.js`, `.env`)
- Running full project build (`pnpm build`)
- Running full test suite (`pnpm test` without file specification)
- Running E2E tests (`pnpm test:e2e`)
- Database migrations (`pnpm db:migrate:dev`)
- Git push operations to shared branches
- Deleting files or directories
- Modifying database schemas (`prisma/schema.prisma`)
- Changing environment variables
- Deploying to any environment
- Making changes to CI/CD pipelines (`.github/workflows`)

## Performance Considerations

### Optimization Guidelines
1. **Clarity First**: Write readable, maintainable code; optimize based on profiling
2. **Algorithmic Efficiency**: Avoid O(n²) operations; prefer efficient data structures
3. **React Performance**:
   - Use `useMemo` for expensive computations
   - Use `useCallback` for functions passed to memoized children
   - Implement virtualization for long lists (react-window)
4. **Database**:
   - Add indexes for frequently queried fields
   - Use database-level aggregations instead of in-memory processing
   - Implement cursor-based pagination for large datasets
5. **Caching**:
   - Redis for session data (TTL: 7 days)
   - Cache AI insights for 24 hours
   - Edge caching for static assets (CDN)

### Performance Requirements
- **API Response Times**:
  - p50: <100ms for cached data
  - p95: <200ms for database queries
  - p99: <500ms for AI-powered endpoints
- **Frontend Metrics**:
  - First Contentful Paint (FCP): <1.5s
  - Largest Contentful Paint (LCP): <2.5s
  - Time to Interactive (TTI): <3.5s
  - Cumulative Layout Shift (CLS): <0.1
- **Database**:
  - N+1 queries prohibited - use eager loading with Prisma
  - Pagination required for endpoints returning >50 items
  - Database connection pooling: max 20 connections
- **Bundle Size**:
  - Initial bundle: <200KB gzipped
  - Route-based code splitting required
  - Lazy load heavy components (charts, editors)

### Monitoring
- OpenTelemetry traces for all API calls
- Real User Monitoring (RUM) with Sentry
- Database query performance tracked with Prisma metrics
- Core Web Vitals monitored via Next.js Analytics

## Troubleshooting and Common Issues

### Common Gotchas
- **WebSocket connections**: Must handle reconnection logic; see `apps/web/lib/websocket/client.ts`
- **Timer drift**: JavaScript timers are not precise; use server-side validation for session duration
- **Timezone handling**: Always store dates in UTC; convert to user timezone in UI only
- **Prisma transactions**: Max 2 seconds timeout; break into smaller transactions if needed
- **Next.js dynamic imports**: Use `ssr: false` for components using browser APIs

### Debugging
- **Frontend logs**: Available in browser console; use `DEBUG=focusflow:*` for verbose logging
- **API logs**: CloudWatch Logs (production), Docker logs (development)
- **Database queries**: Enable Prisma query logging with `DEBUG=prisma:query`
- **Common errors**:
  - `ECONNREFUSED`: Redis not running - run `docker-compose up redis`
  - `P2002 Unique constraint failed`: Duplicate entry - check for race conditions
  - `JWT expired`: Implement token refresh logic - see `apps/web/lib/auth/refresh.ts`

### Performance Debugging
```bash
# Profile React components
pnpm dev -- --profile

# Analyze bundle size
pnpm build:analyze

# Profile API endpoint
curl -w "@curl-format.txt" -o /dev/null -s "http://localhost:8000/api/sessions"

# Database query analysis
pnpm prisma studio
```

## When Stuck or Uncertain

1. **Ask clarifying questions** before implementing - especially for security-sensitive features
2. **Propose a plan** for complex changes:
   ```
   I propose to implement X feature by:
   1. Adding new database table Y with fields Z
   2. Creating API endpoint at /api/v1/endpoint
   3. Implementing UI component at apps/web/components/Feature
   4. Adding tests for each layer

   Does this approach align with our architecture?
   ```
3. **Reference existing patterns**: "Should I follow the pattern in `apps/web/app/dashboard/components/SessionCard.tsx`?"
4. **Start small**: Implement minimal viable solution first, then iterate based on feedback
5. **Write tests first** when fixing bugs to prevent regression
6. **Request review** before:
   - Making architectural changes (new services, database schema changes)
   - Implementing third-party integrations
   - Modifying authentication/authorization logic
   - Making changes that affect multiple teams

## Additional Resources

- **Documentation**: https://docs.focusflow.com
- **Design System**: https://design.focusflow.com (Figma)
- **API Documentation**: https://api.focusflow.com/docs (OpenAPI/Swagger)
- **Architecture Decision Records**: `/docs/adr/` directory
- **Team Wiki**: Notion workspace (internal)
- **Monitoring**: Grafana dashboard at https://metrics.focusflow.com
- **Error Tracking**: Sentry at https://sentry.io/focusflow

## Context Management Notes

**For AI Agents**:
- **Focus on current workspace context** - don't load entire monorepo unnecessarily
- **Reference specific files** when needing broader context: `@apps/web/middleware.ts`
- **Check related test files** when modifying code - maintain test coverage
- **Review recent git history** for understanding recent changes: `git log --oneline -10`
- **Check PR patterns** for similar features: search closed PRs in GitHub
- **Service boundaries**: Changes in `services/api` shouldn't require `services/analytics` context unless explicitly integrating

**Context Priority** (load in this order):
1. Current file being edited
2. Related test files
3. Imported dependencies (direct imports only)
4. Related API/component files
5. Documentation files (if implementing documented feature)

**Context Window Management**:
- File-scoped operations keep context under 4K tokens
- Full type check requires ~15K tokens
- Full test suite requires ~25K tokens
- Monitor context size; create new session if approaching limits

## AI Agent Workflow (Feature Development)

When implementing a new feature, follow this sequence:

1. **Understand Requirements**
   - Read related issue/ticket
   - Check ADRs (Architecture Decision Records) for relevant decisions
   - Ask clarifying questions if requirements unclear

2. **Plan Implementation**
   - Identify affected services/components
   - Propose database schema changes if needed
   - List required tests
   - Estimate breaking changes

3. **Implement Backend** (if needed)
   - Update Prisma schema
   - Generate migration: `pnpm prisma migrate dev --name feature-name`
   - Implement service layer logic
   - Add API endpoints
   - Write unit tests

4. **Implement Frontend** (if needed)
   - Create/modify components
   - Implement server actions or API calls
   - Add client-side validation
   - Update routing if needed
   - Write component tests

5. **Test Integration**
   - Run unit tests: `pnpm test`
   - Manual testing in development
   - Write E2E tests for critical paths
   - Test error scenarios

6. **Documentation**
   - Update API documentation if endpoints changed
   - Add JSDoc comments for complex logic
   - Update README if setup changed
   - Add ADR for architectural decisions

7. **Create PR**
   - Follow PR template
   - Request review from relevant team members
   - Address feedback
   - Ensure CI passes

---

**Last Updated**: January 2025
**Maintained By**: Engineering Team
**Version**: 2.1.0
