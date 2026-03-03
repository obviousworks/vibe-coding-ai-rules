---
applyTo: "**/*.tsx,**/*.jsx"
---

# React Patterns

## Component Structure
- Functional components only (no class components)
- Server Components by default; Client Components ('use client') only when needed
- Extract business logic into custom hooks or service layer
- Max 200 lines per component file

## State Management
- Local state: useState/useReducer
- Server state: React Query / SWR
- Global state: Zustand (or specified alternative)
- URL state: nuqs or searchParams

## Performance
- Use React.memo() only with measured performance issues
- Implement proper key props for lists
- Lazy load heavy components with React.lazy() + Suspense
- Use optimistic updates for better UX

## Error Handling
- Implement Error Boundaries for fault isolation
- Use proper loading/error/empty states for async data
- Never swallow errors silently

## Accessibility
- All interactive elements need keyboard support
- Use semantic HTML elements
- Include proper ARIA labels where needed
