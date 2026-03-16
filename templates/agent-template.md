# AGENTS.md - Standard Template

> This is the standard template. For a quick-start version, see templates/AGENTS.md.
> For the comprehensive version with all sections, see the root AGENTS.md.
> Copy this file to your project root and customize all `[placeholder]` values.

# [Project Name]

## Project Overview
[Brief description of the project's purpose and core functionality]

**Architecture**: [e.g., Microservices, Monolith, JAMstack]
**Domain**: [e.g., E-commerce, Healthcare, Finance]
**Scale**: [e.g., Startup MVP, High-traffic production, Enterprise]

## Tech Stack

### Core Technologies
- **Language**: [Python 3.11+, TypeScript 5.x, etc.]
- **Framework**: [FastAPI, Next.js, Spring Boot, etc.]
- **Database**: [PostgreSQL 15, MongoDB 6, etc.]
- **Cache**: [Redis 7, Memcached, etc.]
- **Package Manager**: [npm, pnpm, pip, poetry, etc.]

### Key Dependencies
- [Library/Framework]: [Version and purpose]
- [Library/Framework]: [Version and purpose]

### Development Tools
- **Linter**: [ESLint, Pylint, etc.]
- **Formatter**: [Prettier, Black, etc.]
- **Type Checker**: [TypeScript, mypy, etc.]
- **Testing**: [Vitest, pytest, JUnit, etc.]

## Setup Commands

```bash
# Install dependencies
[install command]

# Setup environment
cp .env.example .env

# Database setup
[migration commands]

# Start development server
[dev command]
```

## Build and Development Commands

```bash
# File-scoped (preferred - fast)
[lint command] path/to/file      # Lint single file
[format command] path/to/file    # Format single file
[test command] path/to/test      # Run single test

# Project-wide (use sparingly)
[full test command]     # Full test suite
[build command]         # Full build
```

Always prefer file-scoped commands. Only run project-wide commands when explicitly requested or before final commit.

## Code Style and Conventions

### Naming Conventions
- **Files**: [e.g., kebab-case for directories, PascalCase for components]
- **Variables**: [e.g., camelCase with auxiliary verbs: isLoading, hasError]
- **Functions**: [e.g., camelCase, descriptive action verbs]
- **Classes/Types**: [e.g., PascalCase, noun-based names]
- **Constants**: [e.g., UPPER_SNAKE_CASE]

### Formatting
- [e.g., 2 spaces, 100 char lines, single quotes, JSDoc comments]

### Patterns and Anti-Patterns
- **Follow**: [Pattern to follow, with reference: `path/to/example.ext`]
- **Avoid**: [Anti-pattern to avoid and why]

## Project Structure

```
/
├── [directory]/          # [Description]
├── [directory]/          # [Description]
│   ├── [subdirectory]/   # [Description]
│   └── [subdirectory]/   # [Description]
└── [directory]/          # [Description]
```

**Key Files**:
- `[path/to/important/file]`: [What it does]
- `[path/to/important/file]`: [What it does]

## Testing

```bash
[command] path/to/test.ext   # Run specific test (preferred)
[command]                    # Run all tests
[command]                    # Run with coverage
```

- **Coverage Target**: [e.g., 85% minimum]
- **Test Location**: [e.g., `*.test.ts` alongside source, `tests/` directory]
- **Mocking**: [e.g., Mock external APIs, use test database]

## Security

- **Auth**: [e.g., JWT-based authentication with refresh tokens, RBAC via middleware]
- **NEVER** commit secrets, API keys, or credentials; use env vars (see `.env.example`)
- [e.g., Parameterized queries only, validate all inputs, HTTPS in production]

## Git Workflow and PR Process

### Branch Naming
- **Feature**: `feature/[ticket-id]-brief-description`
- **Bug fix**: `fix/[ticket-id]-brief-description`
- **Hotfix**: `hotfix/brief-description`

### Commit Messages
Format: `type(scope): description`
Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

### Before Creating a PR
- [ ] Lint and type check pass
- [ ] All tests pass
- [ ] Documentation updated
- [ ] No debug code or commented-out code

### Git Safety
**Allowed**: Commits, feature branches, pushes to feature branches, PRs
**Require approval**: Force push, push to main/develop, delete shared branches, rebase shared branches

## When Stuck or Uncertain

1. **Ask clarifying questions** rather than making assumptions
2. **Propose a plan** before implementing complex changes
3. **Reference existing patterns** in the codebase for consistency
4. **Start small** - implement minimal solution first, then iterate
5. **Write tests first** when fixing bugs or adding features

---

**Last Updated**: [Date]
**Maintained By**: [Team/Individual]
