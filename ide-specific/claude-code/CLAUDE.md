# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Tech Stack
- {{PRIMARY_LANGUAGE}} ({{LANGUAGE_VERSION}})
- {{PRIMARY_FRAMEWORK}}
- {{DATABASE}}
- {{TESTING_FRAMEWORK}}

DO NOT use: {{BANNED_DEPENDENCIES}}

## Core Principles (Non-Negotiable)
1. **Clarify Before Coding** — Understand requirements before writing code. Ask questions when intent is unclear. No code without clear goals.
2. **Simplicity First** — Choose the simplest viable solution. Complex patterns need explicit justification. Readable code over clever code.
3. **Security By Default** — Validate all inputs. No secrets in code. Defense in depth. Least privilege principle.
4. **Test-Driven Thinking** — Design all code to be testable from inception. Write tests alongside code. Verify before committing.

## Additional Rules
- No new dependencies without explicit approval or compelling justification
- Use conventional commits: type(scope): description
- Validate ALL user input (Zod, Pydantic, etc.)
- Never concatenate SQL — use parameterized queries

## Code Style
- Code must be immediately understandable. Use descriptive naming. Maintain clear structure. Readable code over clever code.
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
- Ask before making architectural changes
- Flag security concerns immediately
- Use file-scoped commands. Reference docs instead of pasting. Optimize context window usage.
- Follow established conventions for the relevant language and tech stack
- Comment only complex logic or critical functions. Avoid documenting the obvious.
- After generating code, argue against your own solution. Check for redundancy, unnecessary complexity, or simpler alternatives.

## When Uncertain
Ask clarifying questions. Propose alternatives with pros/cons.
