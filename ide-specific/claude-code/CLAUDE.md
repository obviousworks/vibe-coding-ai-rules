# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Tech Stack
- {{PRIMARY_LANGUAGE}} ({{LANGUAGE_VERSION}})
- {{PRIMARY_FRAMEWORK}}
- {{DATABASE}}
- {{TESTING_FRAMEWORK}}

DO NOT use: {{BANNED_DEPENDENCIES}}

## Core Rules (Non-Negotiable)
- Clarify intent before generating code — no guessing
- Choose simplest viable solution — justify complexity
- No new dependencies without explicit approval
- Validate ALL user input (Zod, Pydantic, etc.)
- Never store secrets in source code — use env vars
- Never concatenate SQL — use parameterized queries
- Use conventional commits: type(scope): description

## Code Style
- Files: {{FILE_NAMING}}
- Components: PascalCase
- Functions: camelCase with verb prefixes
- Constants: UPPER_SNAKE_CASE
- Explicit return types on all functions
- No `any` types — use `unknown` with type guards

## Commands
```bash
{{INSTALL_COMMAND}}
{{DEV_COMMAND}}
{{TEST_COMMAND}}
{{BUILD_COMMAND}}
```

## Workflow
- Atomic changes: small, self-contained modifications
- Only modify files related to the current task
- Tag rule applications: [SF], [RP], [DM]
- Ask before making architectural changes
- Flag security concerns immediately

## When Uncertain
Ask clarifying questions. Propose alternatives with pros/cons.
