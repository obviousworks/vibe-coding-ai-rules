# Workflow Rules

## Changes
- Atomic: small, self-contained modifications
- Scope: only files related to current task
- No unrelated "improvements" without permission

## Commits
- Conventional format: type(scope): description
- Types: feat, fix, docs, style, refactor, test, chore
- Clear, descriptive messages

## Environment
- Never modify production configs
- Separate DEV/TEST/PROD configurations
- Never hardcode environment-specific values

## Communication
- Tag rule applications: [SF], [RP], [DM]
- Ask before architectural changes
- Flag security concerns immediately
- Propose alternatives with pros/cons when uncertain

## Context Management
- Use file-scoped commands for individual changes
- Only run project-wide commands when requested
- Keep files focused and modular
