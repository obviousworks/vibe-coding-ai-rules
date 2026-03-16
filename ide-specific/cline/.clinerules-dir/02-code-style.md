# Code Style & Conventions

## Naming Conventions
- Files: {{FILE_NAMING}} (e.g., kebab-case.tsx, snake_case.py)
- Components: PascalCase
- Functions: camelCase with verb prefixes (getUserData, calculateTotal)
- Variables: camelCase with auxiliary verbs for booleans (isLoading, hasError)
- Constants: UPPER_SNAKE_CASE
- Types/Interfaces: PascalCase

## Formatting
- Indentation: {{INDENTATION}} (e.g., 2 spaces)
- Line Length: {{LINE_LENGTH}} max (e.g., 100 chars)
- Quotes: {{QUOTE_STYLE}} (e.g., single quotes)
- Semicolons: {{SEMICOLONS}} (e.g., required)
- Trailing Commas: always in multi-line structures

## Readability
Code must be immediately understandable. Use descriptive naming. Maintain clear structure. Readable code over clever code.

## Do's
- Use explicit return types for functions
- Prefer composition over inheritance
- Use const assertions for literal types
- Implement proper error boundaries

## Don'ts
- No `any` types — use `unknown` with type guards
- No unhandled promise rejections
- No inline styles (use CSS framework)
- No business logic in UI components
