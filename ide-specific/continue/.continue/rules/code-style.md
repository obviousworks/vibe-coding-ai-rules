---
name: Code Style
alwaysApply: true
---

# Code Style and Conventions

## Naming Conventions
- Files: use project-consistent naming (kebab-case, snake_case, etc.)
- Components/Classes: PascalCase
- Functions/Methods: camelCase with verb prefixes (getUserData, calculateTotal)
- Variables: camelCase, booleans with is/has prefix (isLoading, hasError)
- Constants: UPPER_SNAKE_CASE
- Types/Interfaces: PascalCase

## Formatting
- Explicit return types on all functions
- Trailing commas in multi-line structures
- Prefer composition over inheritance

## Do's
- Use const assertions for literal types
- Implement proper error boundaries
- Use type guards for runtime type checking
- Keep files focused and modular

## Don'ts
- No `any` types — use `unknown` with type guards
- No unhandled promise rejections
- No inline styles — use CSS framework
- No business logic in UI components
