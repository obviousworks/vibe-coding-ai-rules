---
name: Testing Standards
globs: ["**/*.test.*", "**/*.spec.*", "**/__tests__/**", "**/test/**", "**/tests/**"]
alwaysApply: false
---

# Testing Standards

## Test Structure
- Use Arrange-Act-Assert (AAA) pattern
- One assertion concept per test
- Descriptive test names: "should [expected behavior] when [condition]"

## Coverage Requirements
- Critical paths: minimum 80% coverage
- Security-related code: minimum 90% coverage
- Utility functions: minimum 95% coverage

## Test Types
- Unit tests: isolated, fast, no external dependencies
- Integration tests: test component interactions
- E2E tests: critical user journeys only

## Mocking
- Mock external dependencies, not internal logic
- Use dependency injection for testability
- Reset mocks between tests

## Anti-Patterns to Avoid
- No test interdependencies
- No hardcoded test data — use factories or fixtures
- No testing implementation details — test behavior
- No sleeping or waiting — use proper async patterns
