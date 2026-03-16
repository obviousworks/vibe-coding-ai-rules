# {{PROJECT_NAME}}

## Project Overview
{{PROJECT_DESCRIPTION}}

**Architecture**: {{ARCHITECTURE_TYPE}}
**Language**: {{PRIMARY_LANGUAGE}} ({{LANGUAGE_VERSION}})
**Framework**: {{PRIMARY_FRAMEWORK}}

## Tech Stack
- Frontend: {{FRONTEND_FRAMEWORKS}}
- Backend: {{BACKEND_FRAMEWORKS}}
- Database: {{DATABASE}}
- Testing: {{TESTING_FRAMEWORK}}
- Package Manager: {{PACKAGE_MANAGER}}

### DO NOT Use
- {{BANNED_DEPENDENCY_1}} (use {{ALTERNATIVE_1}} instead)
- {{BANNED_DEPENDENCY_2}} (use {{ALTERNATIVE_2}} instead)

## Core Principles

1. **Clarify Before Coding**: Understand requirements before writing code. Ask questions when intent is unclear. No code without clear goals.
2. **Simplicity First**: Choose the simplest viable solution. Complex patterns need explicit justification. Readable code over clever code.
3. **Security By Default**: Validate all inputs. No secrets in code. Defense in depth. Least privilege principle.
4. **Test-Driven Thinking**: Design all code to be testable from inception. Write tests alongside code. Verify before committing.

## Setup Commands

```bash
{{INSTALL_COMMAND}}
{{DEV_COMMAND}}
{{TEST_COMMAND}}
{{BUILD_COMMAND}}
```

## Workflow
- Atomic changes: small, self-contained modifications
- Conventional commits: `type(scope): description`
- Only modify files directly related to the current task
- Never add new dependencies without explicit approval or compelling justification
- Use file-scoped commands. Reference docs instead of pasting. Optimize context window usage.
- Follow established conventions for the relevant language and tech stack
- Comment only complex logic or critical functions. Avoid documenting the obvious.
- After generating code, argue against your own solution. Check for redundancy, unnecessary complexity, or simpler alternatives.

## When Uncertain
- Ask clarifying questions before implementing
- Reference existing patterns in the codebase
- Start small and iterate
