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
# Edit .env with required values

# Database setup
[migration commands]

# Start development server
[dev command]
```

## Build and Development Commands

### File-Scoped Commands (Preferred - Fast)
```bash
# Type check single file (3 seconds)
[command] path/to/file.ext

# Format single file
[command] path/to/file.ext

# Lint single file
[command] path/to/file.ext

# Run single test file
[command] path/to/test.ext
```

### Project-Wide Commands (Use Sparingly)
```bash
# Full type check (2 minutes)
[command]

# Full test suite (3 minutes)
[command]

# Full build (5 minutes)
[command]
```

**Important**: Always use file-scoped commands for checking individual changes. Only run project-wide commands when explicitly requested or before final commit.

## Code Style and Conventions

### Language-Specific Rules
- [e.g., Use TypeScript strict mode with exactOptionalPropertyTypes]
- [e.g., Python type hints required for all functions]
- [e.g., Prefer composition over inheritance]

### Naming Conventions
- **Files**: [e.g., lowercase-with-dashes for directories, PascalCase for components]
- **Variables**: [e.g., camelCase with auxiliary verbs: isLoading, hasError]
- **Functions**: [e.g., camelCase, descriptive action verbs]
- **Classes**: [e.g., PascalCase, noun-based names]
- **Constants**: [e.g., UPPER_SNAKE_CASE]

### Formatting Rules
- **Indentation**: [tabs/spaces and size]
- **Line Length**: [max characters]
- **Quotes**: [single/double]
- **Semicolons**: [required/optional]
- **Trailing Commas**: [yes/no]
- **Comments**: [Use JSDoc docstrings / follow PEP 257 / etc.]

### Do's ✅
- [Specific pattern to use - reference actual file]
- [Another approved pattern - reference actual file]
- [Framework-specific best practice]
- [Design pattern to follow]

### Don'ts ❌
- [Specific anti-pattern to avoid - reference bad example if exists]
- [Another pattern to avoid]
- [Deprecated approach]
- [Common mistake specific to your project]

### Good and Bad Examples

**Avoid** (Anti-patterns):
- [File/pattern to avoid]: [Brief explanation why]

**Prefer** (Good patterns):
- [File/pattern to copy]: [Brief explanation why]
- [For feature X, copy]: `path/to/good/example.ext`

## Project Structure

```
/
├── [directory]/          # [Description and what lives here]
├── [directory]/          # [Description]
│   ├── [subdirectory]/   # [Description]
│   └── [subdirectory]/   # [Description]
└── [directory]/          # [Description]
```

**Key Files**:
- `[path/to/important/file]`: [What it does]
- `[path/to/important/file]`: [What it does]

**Architecture Patterns**:
- [Pattern used, e.g., Repository pattern for data access]
- [Pattern used, e.g., Service layer for business logic]
- [State management approach]

## Testing Instructions

### Testing Framework
- **Unit Tests**: [Framework and location]
- **Integration Tests**: [Framework and location]
- **E2E Tests**: [Framework and location]

### Running Tests
```bash
# Run all tests
[command]

# Run specific test file
[command] path/to/test.ext

# Run tests with coverage
[command]

# Run tests in watch mode
[command]
```

### Test Requirements
- **Coverage Target**: [e.g., 85% minimum]
- **Test Location**: [e.g., `*.test.ts` alongside source, `tests/` directory]
- **Test Naming**: [e.g., Omit "should" from test names]
- **Mocking Strategy**: [e.g., Mock external APIs, use test database]

### Testing Patterns
```[language]
# Example test structure
[Paste a good test example from your codebase]
```

## Security Considerations

### Authentication & Authorization
- [e.g., JWT-based authentication]
- [e.g., Role-based access control implemented via middleware]
- [e.g., All non-public endpoints require authentication]

### Input Validation
- [e.g., Validate all user inputs on both client and server]
- [e.g., Use Zod schemas for validation]
- [e.g., Sanitize inputs to prevent XSS]

### Secrets Management
- **NEVER** commit secrets, API keys, or credentials
- Use environment variables for sensitive data
- Reference: `.env.example` for required variables
- [Secret management tool if used, e.g., AWS Secrets Manager]

### Security Requirements
- [e.g., All database queries must use parameterization]
- [e.g., Passwords hashed with bcrypt]
- [e.g., HTTPS enforced in production]
- [e.g., CORS properly configured]

### Data Protection
- [e.g., PII must be encrypted at rest]
- [e.g., Audit logs for sensitive operations]
- [e.g., Data retention policies]

## Git Workflow and PR Process

### Branch Naming
- **Feature branches**: `feature/[ticket-id]-brief-description`
- **Bug fixes**: `fix/[ticket-id]-brief-description`
- **Hotfixes**: `hotfix/brief-description`

### Commit Messages
Format: `type(scope): description`

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

**Examples**:
- `feat(auth): add password reset functionality`
- `fix(api): handle null response from external service`
- `docs(readme): update setup instructions`

### Pull Request Requirements

**Before Creating PR**:
- [ ] Run `[lint command]` - all checks pass
- [ ] Run `[type check command]` - no errors
- [ ] Run `[test command]` - all tests pass
- [ ] Run `[security scan]` - no high/critical issues (if applicable)
- [ ] Update relevant documentation
- [ ] Remove debug logs and commented code

**PR Title**: `[type(scope): description]` matching commit convention

**PR Description Must Include**:
- Summary of changes
- Related issue/ticket number
- Testing performed
- Screenshots for UI changes (if applicable)
- Breaking changes highlighted

### Git Operations Safety

**Allowed Without Asking**:
- Creating commits with descriptive messages
- Creating feature branches
- Pushing to feature branches
- Creating pull requests
- Searching git history

**Require Approval First**:
- Force pushing (use `--force-with-lease` if needed)
- Pushing to main/master/develop
- Deleting branches (except own feature branches)
- Rebasing shared branches
- Modifying git history

## Safety and Permissions

### Operations Allowed Without Prompting
- Read files, list directory contents
- Type check, lint, format single files
- Run single unit test
- Search codebase, read documentation
- Create git branches and commits

### Operations That Require Approval
- Installing new packages or dependencies
- Modifying configuration files (package.json, tsconfig.json, etc.)
- Running full project build
- Running full test suite or E2E tests
- Git push operations
- Deleting files or directories
- Modifying database schemas
- Changing environment variables

## Performance Considerations

### Optimization Guidelines
1. **Clarity First**: Write readable code, then optimize based on profiling
2. **Algorithmic Efficiency**: Be mindful of time complexity (prefer O(n log n) over O(n²))
3. **Caching**: [e.g., Use Redis for expensive query results]
4. **Database**: [e.g., Add indexes for frequently queried fields]

### Performance Requirements
- [e.g., API endpoints must respond within 200ms p95]
- [e.g., Database queries optimized to avoid N+1 problems]
- [e.g., Pagination required for list endpoints]
- [e.g., Lazy loading for heavy components]

## Troubleshooting and Common Issues

### Common Gotchas
- [Known issue and solution]
- [Common mistake developers make]
- [Environment-specific quirk]

### Debugging
- [How to access logs]
- [Debugging tool setup]
- [Common error messages and solutions]

## When Stuck or Uncertain

1. **Ask clarifying questions** rather than making assumptions
2. **Propose a plan** before implementing complex changes
3. **Reference existing patterns** in the codebase for consistency
4. **Start small** - implement minimal solution first, then iterate
5. **Write tests first** when fixing bugs or adding features
6. **Request review** before making significant architectural changes

## Additional Resources

- **Documentation**: [Link to docs]
- **Design System**: [Link or reference to design system]
- **API Documentation**: [Link to API docs]
- **Architecture Decision Records**: [Path to ADRs]
- **Team Wiki**: [Link to internal wiki]

## Context Management Notes

**For AI Agents**:
- Focus on files in current working directory context
- Reference `@specific/file.ext` when needing broader context
- Prioritize recent git history for understanding changes
- Check related test files when modifying code
- Review PR history for patterns and conventions

---

**Last Updated**: [Date]
**Maintained By**: [Team/Individual]
**Version**: [Semantic version if tracking]
