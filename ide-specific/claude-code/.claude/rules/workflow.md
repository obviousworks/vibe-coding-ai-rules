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
- Ask before architectural changes
- Flag security concerns immediately
- Propose alternatives with pros/cons when uncertain

## Context Management
- Use file-scoped commands for individual changes
- Only run project-wide commands when requested
- Keep files focused and modular

## Dependency Governance
- Never add new dependencies without explicit approval or compelling justification

## Token Efficiency
- Use file-scoped commands. Reference docs instead of pasting. Optimize context window usage.

## Industry Standards
- Follow established conventions for the relevant language and tech stack

## Strategic Documentation
- Comment only complex logic or critical functions. Avoid documenting the obvious.

## Self-Review Before Commit
- After generating code, argue against your own solution. Check for redundancy, unnecessary complexity, or simpler alternatives.
