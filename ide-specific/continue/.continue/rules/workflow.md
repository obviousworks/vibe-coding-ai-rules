---
name: Workflow Standards
alwaysApply: true
---

# Workflow Standards

## Changes
- Make atomic, self-contained modifications for traceability and rollback
- Only modify files directly related to the current task
- No unrelated improvements without explicit permission

## Commits
- Use conventional commit format: type(scope): description
- Types: feat, fix, docs, style, refactor, test, chore
- Clear, descriptive commit messages

## Environment
- Never modify production configurations
- Maintain separate configs for development, test, and production
- Never hardcode environment-specific values

## Communication
- Ask before making architectural changes
- Flag security concerns immediately
- Propose alternatives with pros and cons when uncertain

## Context Management
- Use file-scoped commands for individual changes
- Only run project-wide commands when explicitly requested
- Keep files focused and modular
