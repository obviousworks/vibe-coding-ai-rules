---
applyTo: "**/*.tsx,**/*.jsx"
---

# FocusFlow React Patterns

## Component Guidelines
- Server Components by default; `'use client'` only when needed
- Use Radix UI primitives with TailwindCSS styling
- Design tokens from `apps/web/styles/tokens.ts`
- Error boundaries: `apps/web/components/ErrorBoundary.tsx`

## State Management
- Local: useState/useReducer
- Server: React Query 5.0
- Global: Zustand 4.5
- URL: nuqs

## Performance
- Lazy load dashboard charts
- Use react-window for long lists
- Optimistic updates for timer operations
- Route-based code splitting

## Auth Pattern
Follow `apps/web/middleware.ts`. All pages except `/auth/*` require auth.

## Good Examples
- `apps/web/app/dashboard/components/TimerCard.tsx` — Server component
- `apps/web/lib/hooks/use-timer.ts` — Custom hook
- `apps/web/app/actions/timer.ts` — Server action
