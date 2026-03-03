# Testing Standards

## Structure
- Arrange-Act-Assert (AAA) pattern
- One assertion concept per test
- Descriptive names: "should [behavior] when [condition]"

## Coverage
- Critical paths: 80% minimum
- Security code: 90% minimum
- Utilities: 95% minimum

## Types
- Unit: isolated, fast, no external deps
- Integration: component interactions
- E2E: critical user journeys only

## Mocking
- Mock external dependencies, not internal logic
- Use dependency injection for testability
- Reset mocks between tests

## Anti-Patterns
- No test interdependencies
- No hardcoded test data (use factories)
- No testing implementation details
- No sleeping/waiting (proper async patterns)
