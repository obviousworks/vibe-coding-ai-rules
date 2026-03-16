# Project Conventions

## Core Principles

### Clarify Before Coding
Understand requirements before writing code. Ask questions when intent is unclear. No code without clear goals.

### Simplicity First
Choose the simplest viable solution. Complex patterns need explicit justification. Readable code over clever code.

### Security By Default
Validate all inputs. No secrets in code. Defense in depth. Least privilege principle.

### Test-Driven Thinking
Design all code to be testable from inception. Write tests alongside code. Verify before committing.

## Code Style

### Naming Conventions
- Files: use project-consistent naming (kebab-case, snake_case, etc.)
- Components/Classes: PascalCase
- Functions/Methods: camelCase with verb prefixes (getUserData, calculateTotal)
- Variables: camelCase, booleans with is/has prefix (isLoading, hasError)
- Constants: UPPER_SNAKE_CASE

### Formatting
- Explicit return types on all functions
- Trailing commas in multi-line structures
- No `any` types — use `unknown` with type guards
- Prefer composition over inheritance

### Documentation
- Comment only complex logic or non-obvious decisions
- Use docstrings for public APIs
- Avoid documenting the obvious

## Security

### Input Validation
- Validate ALL user input with schema validation (Zod, Pydantic, etc.)
- Never trust client-side data
- Sanitize HTML content before rendering
- Validate file uploads: MIME type, extension, max size

### Injection Prevention
- NEVER concatenate SQL strings — use parameterized queries only
- NEVER pass user input to shell commands
- NEVER use eval() or Function() with user input
- NEVER use dangerouslySetInnerHTML without sanitization

### Secrets Management
- No secrets in source code — use environment variables
- No credentials in client-side code
- Implement proper JWT validation with algorithm pinning
- Use httpOnly, secure, sameSite cookies

## Testing

### Structure
- Use Arrange-Act-Assert (AAA) pattern
- One assertion concept per test
- Descriptive test names: "should [behavior] when [condition]"

### Coverage
- Critical paths: minimum 80% coverage
- Security-related code: minimum 90% coverage
- Utility functions: minimum 95% coverage

### Practices
- Mock external dependencies, not internal logic
- Use dependency injection for testability
- Reset mocks between tests
- No test interdependencies
- No hardcoded test data — use factories or fixtures

## Workflow

### Changes
- Make atomic, self-contained modifications
- Only modify files directly related to the current task
- No unrelated improvements without explicit permission

### Commits
- Use conventional commit format: type(scope): description
- Types: feat, fix, docs, style, refactor, test, chore
- Clear, descriptive commit messages

### Environment
- Never modify production configurations
- Maintain separate configs for development, test, and production
- Never hardcode environment-specific values

### Communication
- Ask before making architectural changes
- Flag security concerns immediately
- Propose alternatives with pros and cons when uncertain
