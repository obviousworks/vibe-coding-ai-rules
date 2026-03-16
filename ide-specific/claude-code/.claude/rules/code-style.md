# Code Style Guidelines

## Readability
Code must be immediately understandable. Use descriptive naming. Maintain clear structure. Readable code over clever code.

## Naming Conventions
- Files: {{FILE_NAMING}} (e.g., kebab-case.tsx, snake_case.py)
- Components/Classes: PascalCase
- Functions/Methods: camelCase with verb prefixes (getUserData, calculateTotal)
- Variables: camelCase, booleans with is/has prefix (isLoading, hasError)
- Constants: UPPER_SNAKE_CASE
- Types/Interfaces: PascalCase

## Formatting
- Indentation: {{INDENTATION}} (e.g., 2 spaces)
- Line Length: {{LINE_LENGTH}} max
- Quotes: {{QUOTE_STYLE}}
- Semicolons: {{SEMICOLONS}}
- Trailing commas in multi-line structures

## TypeScript
- Strict mode required
- Explicit return types on all functions
- Prefer `type` over `interface` for object shapes
- No `any` — use `unknown` with type guards
- Prefer composition over inheritance

## Python
- Type hints required for all function signatures
- PEP 8 strictly
- Pydantic for data validation
- Prefer dataclasses over plain dicts
- Use pathlib over os.path

## Patterns
- No business logic in UI components
- No inline styles — use CSS framework
- No unhandled promise rejections
