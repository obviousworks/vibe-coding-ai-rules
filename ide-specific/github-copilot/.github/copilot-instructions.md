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

1. **Problem Clarity First**: Clarify intent before generating code. No code without clear requirements.
2. **Simplicity First**: Choose the simplest viable solution. Complex patterns need justification.
3. **Readability Priority**: Code must be immediately understandable by humans and AI.
4. **Dependency Minimalism**: No new libraries without explicit request or justification.
5. **Security First**: Validate all inputs, no secrets in code, defense in depth.
6. **Test-Driven Thinking**: Design all code to be testable from inception.

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
- Tag rule applications with abbreviations: [SF], [RP], [DM]

## When Uncertain
- Ask clarifying questions before implementing
- Reference existing patterns in the codebase
- Start small and iterate
