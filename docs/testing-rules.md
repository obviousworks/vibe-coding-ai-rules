# Testing Rules for AI-Generated Code

**Critical**: AI-generated code requires thorough testing. Untested AI code is a liability - always verify behavior through automated tests.

## Core Testing Principles

### 1. Test Behavior, Not Implementation
- Tests should describe what the code does, not how it does it
- Refactoring should not break tests
- Focus on inputs and outputs, not internal state

### 2. AI Code Needs More Testing, Not Less
- AI models can generate plausible but incorrect code
- Edge cases are frequently missed by AI
- Always verify AI-generated logic with targeted tests

### 3. Tests as Documentation
- Test names should describe expected behavior
- Tests serve as living documentation of feature requirements
- New developers should understand features by reading tests

## Test Pyramid

```
      /\
     /  \     10% E2E Tests
    /    \    (slow, brittle, high value)
   /------\
  /        \  30% Integration Tests
 /          \ (medium speed, medium value)
/____________\
               60% Unit Tests
               (fast, reliable, focused)
```

### Unit Tests
- **Scope**: Pure functions, utilities, business logic, data transformations
- **Speed**: <10ms per test
- **Dependencies**: None - fully isolated with mocks/stubs
- **When to write**: Every function with logic, calculations, or transformations

### Integration Tests
- **Scope**: API endpoints, database operations, service interactions
- **Speed**: ~100ms per test
- **Dependencies**: Test database, mock external APIs
- **When to write**: Every API endpoint, every database operation

### E2E Tests
- **Scope**: Critical user journeys only
- **Speed**: 5-30 seconds per test
- **Dependencies**: Full application stack
- **When to write**: Authentication flow, payment flow, core user journeys

## Test Structure: AAA Pattern

```typescript
describe('calculateProductivity', () => {
  it('returns high score for sessions with minimal interruptions', () => {
    // Arrange - Set up test data
    const sessions = [
      { duration: 1500, interruptions: 0, focusScore: 0.95 },
      { duration: 1500, interruptions: 1, focusScore: 0.90 },
    ];

    // Act - Execute the function
    const result = calculateProductivity(sessions);

    // Assert - Verify the outcome
    expect(result.score).toBeGreaterThan(0.85);
    expect(result.level).toBe('high');
  });
});
```

## Test Naming Conventions

### Pattern: "should [expected behavior] when [condition]"

```typescript
// Good test names - describe behavior
it('should return 401 when authentication token is missing')
it('should calculate total price including tax')
it('should retry failed API calls up to 3 times')
it('should emit tick event every second while timer is running')

// Bad test names - describe implementation
it('should call the database')
it('should set isLoading to true')
it('should use the correct SQL query')
it('test calculateTotal function')
```

## Coverage Requirements

| Code Category | Minimum Coverage | Rationale |
|--------------|-----------------|-----------|
| Security-critical (auth, encryption) | 90% | High risk, high impact |
| Business logic (calculations, rules) | 85% | Core value, must be correct |
| API endpoints | 80% | User-facing, must be reliable |
| Utility functions | 95% | Highly reusable, easy to test |
| UI components | 70% | Focus on behavior, not rendering |
| Configuration/setup | 50% | Low risk, hard to test |

## Mocking Best Practices

### Mock External Dependencies, Not Internal Logic

```typescript
// Mock external services
vi.mock('../lib/stripe', () => ({
  createCheckout: vi.fn().mockResolvedValue({ id: 'cs_test_123' }),
}));

// Mock time for timer tests
vi.useFakeTimers();
vi.advanceTimersByTime(5000);

// Don't mock internal functions you're testing
// This tests nothing meaningful
vi.mock('../lib/calculate', () => ({
  calculate: vi.fn().mockReturnValue(42),
}));
```

### Reset Mocks Between Tests

```typescript
beforeEach(() => {
  vi.clearAllMocks();
  vi.restoreAllMocks();
});

afterEach(() => {
  vi.useRealTimers();
});
```

## Testing Patterns by Type

### API Endpoint Tests

```typescript
describe('POST /api/sessions', () => {
  it('should create a new session with valid data', async () => {
    const response = await request(app)
      .post('/api/sessions')
      .set('Authorization', `Bearer ${testToken}`)
      .send({
        duration: 1500,
        type: 'focus',
      });

    expect(response.status).toBe(201);
    expect(response.body).toMatchObject({
      id: expect.any(String),
      duration: 1500,
      type: 'focus',
    });
  });

  it('should return 400 for invalid duration', async () => {
    const response = await request(app)
      .post('/api/sessions')
      .set('Authorization', `Bearer ${testToken}`)
      .send({ duration: -1 });

    expect(response.status).toBe(400);
    expect(response.body.error).toContain('duration');
  });

  it('should return 401 without authentication', async () => {
    const response = await request(app)
      .post('/api/sessions')
      .send({ duration: 1500 });

    expect(response.status).toBe(401);
  });
});
```

### React Component Tests

```typescript
import { render, screen, fireEvent } from '@testing-library/react';

describe('TimerWidget', () => {
  it('should display formatted time remaining', () => {
    render(<TimerWidget initialSeconds={1500} />);

    expect(screen.getByText('25:00')).toBeInTheDocument();
  });

  it('should start countdown when start button is clicked', async () => {
    render(<TimerWidget initialSeconds={1500} />);

    fireEvent.click(screen.getByRole('button', { name: /start/i }));

    // Wait for timer to tick
    await waitFor(() => {
      expect(screen.getByText('24:59')).toBeInTheDocument();
    });
  });

  it('should call onComplete when timer reaches zero', async () => {
    const onComplete = vi.fn();
    render(<TimerWidget initialSeconds={1} onComplete={onComplete} />);

    fireEvent.click(screen.getByRole('button', { name: /start/i }));

    await waitFor(() => {
      expect(onComplete).toHaveBeenCalledOnce();
    });
  });
});
```

### Database Integration Tests

```typescript
describe('UserRepository', () => {
  beforeAll(async () => {
    await setupTestDatabase();
  });

  afterEach(async () => {
    await cleanupTestData();
  });

  afterAll(async () => {
    await teardownTestDatabase();
  });

  it('should create user with hashed password', async () => {
    const user = await userRepo.create({
      email: 'test@example.com',
      password: 'SecurePass123!',
    });

    expect(user.id).toBeDefined();
    expect(user.password).not.toBe('SecurePass123!'); // Hashed
    expect(user.email).toBe('test@example.com');
  });

  it('should enforce unique email constraint', async () => {
    await userRepo.create({ email: 'test@example.com', password: 'pass1' });

    await expect(
      userRepo.create({ email: 'test@example.com', password: 'pass2' })
    ).rejects.toThrow(/unique constraint/i);
  });
});
```

## Anti-Patterns to Avoid

### 1. Test Interdependencies
```typescript
// Tests depend on execution order
it('should create a user', () => { /* creates global user */ });
it('should find the created user', () => { /* depends on test above */ });

// Each test is independent
it('should find user by email', async () => {
  const user = await createTestUser({ email: 'find@test.com' });
  const found = await userRepo.findByEmail('find@test.com');
  expect(found.id).toBe(user.id);
});
```

### 2. Hardcoded Test Data
```typescript
// Hardcoded, fragile data
expect(result.total).toBe(127.50);

// Use factories and calculated expectations
const items = [createItem({ price: 100 }), createItem({ price: 50 })];
const result = calculateTotal(items, { taxRate: 0.085 });
expect(result.total).toBe(150 * 1.085);
```

### 3. Testing Implementation Details
```typescript
// Testing how, not what
expect(component.state.isLoading).toBe(true);
expect(mockFetch).toHaveBeenCalledWith('/api/users', { method: 'GET' });

// Testing behavior
expect(screen.getByText('Loading...')).toBeInTheDocument();
await waitFor(() => {
  expect(screen.getByText('John Doe')).toBeInTheDocument();
});
```

### 4. Sleeping in Tests
```typescript
// Arbitrary waits
await new Promise(resolve => setTimeout(resolve, 2000));

// Use proper async patterns
await waitFor(() => expect(element).toBeVisible());
await vi.advanceTimersByTimeAsync(2000);
```

## Test Data Factories

```typescript
// factories/user.ts
function createTestUser(overrides: Partial<User> = {}): User {
  return {
    id: randomUUID(),
    email: `test-${randomUUID()}@example.com`,
    name: 'Test User',
    role: 'member',
    createdAt: new Date(),
    ...overrides,
  };
}

// factories/session.ts
function createTestSession(overrides: Partial<Session> = {}): Session {
  return {
    id: randomUUID(),
    duration: 1500,
    type: 'focus',
    interruptions: 0,
    focusScore: 0.85,
    ...overrides,
  };
}
```

## Testing Checklist for AI Agents

Before considering code complete, verify:

- [ ] Unit tests cover all business logic and utility functions
- [ ] Integration tests cover all API endpoints
- [ ] Error scenarios tested (invalid input, network failures, timeouts)
- [ ] Edge cases tested (empty arrays, null values, boundary values)
- [ ] Tests are independent and can run in any order
- [ ] Test names describe behavior clearly
- [ ] No hardcoded test data (use factories)
- [ ] Mocks reset between tests
- [ ] Coverage meets minimum thresholds
- [ ] Tests run fast (<30 seconds for unit suite)

---

**Remember**: Every bug is a missing test. Write the test that would have caught it, then fix the code.
