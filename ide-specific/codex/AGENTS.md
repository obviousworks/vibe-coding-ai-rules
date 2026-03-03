# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Tech Stack
- **Language**: {{PRIMARY_LANGUAGE}} ({{LANGUAGE_VERSION}})
- **Framework**: {{PRIMARY_FRAMEWORK}}
- **Database**: {{DATABASE}}
- **Testing**: {{TESTING_FRAMEWORK}}
- **Package Manager**: {{PACKAGE_MANAGER}}

### DO NOT Use
{{BANNED_DEPENDENCIES}}

## Core Rules

- Clarify intent before generating code — no guessing at business logic
- Choose simplest viable solution — justify any added complexity
- No new dependencies without explicit approval
- Validate ALL user input ({{VALIDATION_LIBRARY}})
- Never store secrets in source code — use environment variables
- Never concatenate SQL — use parameterized queries only
- Use conventional commits: `type(scope): description`

## Code Style

- Files: {{FILE_NAMING}} (e.g., `kebab-case.tsx`, `snake_case.py`)
- Components/Classes: PascalCase
- Functions: camelCase with verb prefixes (e.g., `getUserData`, `calculateTotal`)
- Constants: UPPER_SNAKE_CASE
- Explicit return types on all functions
- No `any` types — use `unknown` with type guards

## Security

- Validate all user input on both client and server
- NEVER pass user input to shell commands
- NEVER use `eval()` or `Function()` with user data
- Use httpOnly, secure, sameSite cookies for auth
- Rate limiting on all public endpoints
- CORS: explicit origins only

## Testing

- {{TEST_RUNNER}} for unit tests, {{E2E_RUNNER}} for E2E
- 85% coverage for critical paths (auth, payments, data)
- AAA pattern: Arrange, Act, Assert
- Mock external dependencies, not internal logic

## Commands

```bash
{{INSTALL_COMMAND}}
{{DEV_COMMAND}}
{{TEST_COMMAND}}
{{BUILD_COMMAND}}
```

## Key Files
{{KEY_FILES}}

## Workflow

- Atomic changes: small, self-contained modifications
- Only modify files related to the current task
- Run `{{LINT_COMMAND}}` before committing
- Always run `{{TEST_COMMAND}}` after modifying code

## When Uncertain

Ask clarifying questions before implementing. Propose alternatives with pros/cons. Reference existing patterns in the codebase.
