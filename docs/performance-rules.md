# Performance Rules for AI-Generated Code

**Critical**: AI models often generate functional but suboptimal code. Apply these performance patterns to ensure efficient, scalable applications.

## Core Performance Principles

### 1. Measure Before Optimizing
- Profile before making performance changes
- Use data-driven decisions, not assumptions
- Set measurable performance budgets
- Benchmark before and after optimizations

### 2. Clarity First, Performance Second
- Write readable code first, optimize based on profiling
- Premature optimization is the root of all evil
- Document performance-critical sections with complexity annotations

### 3. Think in Systems
- Consider end-to-end performance, not just individual functions
- Network latency often matters more than CPU optimization
- Database queries are usually the bottleneck

## Frontend Performance

### Bundle Size Optimization

```typescript
// ✅ Use dynamic imports for heavy components
const Chart = dynamic(() => import('./Chart'), {
  loading: () => <ChartSkeleton />,
  ssr: false,
});

// ✅ Tree-shake imports
import { format } from 'date-fns'; // Good - single function
// ❌ import * as dateFns from 'date-fns'; // Bad - imports everything
```

### Rendering Performance

```typescript
// ✅ Memoize expensive computations
const sortedItems = useMemo(
  () => items.sort((a, b) => a.name.localeCompare(b.name)),
  [items]
);

// ✅ Virtualize long lists
import { FixedSizeList } from 'react-window';

function VirtualList({ items }: { items: Item[] }) {
  return (
    <FixedSizeList
      height={600}
      itemCount={items.length}
      itemSize={50}
      width="100%"
    >
      {({ index, style }) => (
        <div style={style}>{items[index].name}</div>
      )}
    </FixedSizeList>
  );
}

// ✅ Use React.memo only with measured performance issues
const ExpensiveComponent = React.memo(({ data }: Props) => {
  // Only re-renders when data actually changes
  return <ComplexVisualization data={data} />;
});
```

### Core Web Vitals Targets

| Metric | Good | Needs Improvement | Poor |
|--------|------|-------------------|------|
| LCP (Largest Contentful Paint) | ≤2.5s | ≤4.0s | >4.0s |
| FID (First Input Delay) | ≤100ms | ≤300ms | >300ms |
| CLS (Cumulative Layout Shift) | ≤0.1 | ≤0.25 | >0.25 |
| FCP (First Contentful Paint) | ≤1.8s | ≤3.0s | >3.0s |
| TTFB (Time to First Byte) | ≤800ms | ≤1.8s | >1.8s |

### Image Optimization

```typescript
// ✅ Use Next.js Image component with proper sizing
import Image from 'next/image';

<Image
  src="/hero.jpg"
  alt="Hero image"
  width={1200}
  height={600}
  priority // Above-the-fold images
  sizes="(max-width: 768px) 100vw, 1200px"
/>

// ✅ Use modern formats (WebP, AVIF)
// ✅ Implement lazy loading for below-fold images
// ✅ Set explicit width/height to prevent CLS
```

## Backend Performance

### Database Query Optimization

```typescript
// ❌ N+1 Query Problem
const users = await prisma.user.findMany();
for (const user of users) {
  const posts = await prisma.post.findMany({ where: { authorId: user.id } });
  // Each iteration = 1 additional query
}

// ✅ Eager Loading (Single Query)
const users = await prisma.user.findMany({
  include: { posts: true },
});

// ✅ Use select to fetch only needed fields
const users = await prisma.user.findMany({
  select: {
    id: true,
    name: true,
    email: true,
    // Don't load large fields unnecessarily
  },
});
```

### Pagination

```typescript
// ✅ Cursor-based pagination (efficient for large datasets)
const nextPage = await prisma.post.findMany({
  take: 20,
  skip: 1,
  cursor: { id: lastPostId },
  orderBy: { createdAt: 'desc' },
});

// ✅ Always limit query results
// ❌ NEVER: await prisma.post.findMany() // Unbounded query
```

### Caching Strategies

```typescript
// ✅ Redis caching for expensive operations
async function getUserProfile(userId: string) {
  const cacheKey = `user:${userId}:profile`;

  // Check cache first
  const cached = await redis.get(cacheKey);
  if (cached) return JSON.parse(cached);

  // Fetch from database
  const profile = await prisma.user.findUnique({
    where: { id: userId },
    include: { preferences: true, teams: true },
  });

  // Cache for 5 minutes
  await redis.set(cacheKey, JSON.stringify(profile), 'EX', 300);

  return profile;
}

// ✅ Cache invalidation on updates
async function updateUserProfile(userId: string, data: UpdateData) {
  const updated = await prisma.user.update({
    where: { id: userId },
    data,
  });

  // Invalidate cache
  await redis.del(`user:${userId}:profile`);

  return updated;
}
```

### API Response Times

| Endpoint Type | p50 Target | p95 Target | p99 Target |
|--------------|-----------|-----------|-----------|
| Cached reads | <50ms | <100ms | <200ms |
| Database reads | <100ms | <200ms | <500ms |
| Write operations | <200ms | <500ms | <1000ms |
| AI-powered | <500ms | <2000ms | <5000ms |
| Batch operations | <1000ms | <5000ms | <10000ms |

## Algorithm Complexity

### Common Patterns to Watch

```typescript
// ❌ O(n²) - Nested loops over same data
for (const user of users) {
  for (const other of users) {
    if (user.id !== other.id && user.team === other.team) {
      // ...
    }
  }
}

// ✅ O(n) - Use Map/Set for lookups
const teamMap = new Map<string, User[]>();
for (const user of users) {
  const team = teamMap.get(user.team) ?? [];
  team.push(user);
  teamMap.set(user.team, team);
}

// ❌ O(n) repeated lookups in array
const found = items.find(item => item.id === targetId); // Each call is O(n)

// ✅ O(1) lookup with Map
const itemMap = new Map(items.map(item => [item.id, item]));
const found = itemMap.get(targetId); // O(1)
```

### Complexity Guidelines

- **O(1)**: Hash maps, direct access - Always preferred
- **O(log n)**: Binary search, balanced trees - Good
- **O(n)**: Single pass, linear scan - Acceptable
- **O(n log n)**: Efficient sorting - Acceptable for sorting
- **O(n²)**: Nested loops - Avoid for large datasets (>1000 items)
- **O(2^n)**: Exponential - Never acceptable in production

## Async and Concurrency

### Parallel Operations

```typescript
// ❌ Sequential (slow)
const user = await fetchUser(id);
const posts = await fetchPosts(id);
const comments = await fetchComments(id);

// ✅ Parallel (fast)
const [user, posts, comments] = await Promise.all([
  fetchUser(id),
  fetchPosts(id),
  fetchComments(id),
]);

// ✅ Parallel with error handling
const results = await Promise.allSettled([
  fetchUser(id),
  fetchPosts(id),
  fetchComments(id),
]);
```

### Connection Pooling

```typescript
// ✅ Database connection pooling
// In prisma/schema.prisma or connection config
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
  // Connection pool: min 2, max 10
}

// ✅ Redis connection reuse
const redis = new Redis({
  maxRetriesPerRequest: 3,
  lazyConnect: true,
  keepAlive: 30000,
});
```

## Memory Management

### Preventing Memory Leaks

```typescript
// ✅ Clean up subscriptions and timers
useEffect(() => {
  const interval = setInterval(tick, 1000);
  const subscription = eventBus.subscribe('event', handler);

  return () => {
    clearInterval(interval);
    subscription.unsubscribe();
  };
}, []);

// ✅ Use WeakMap for object associations
const metadata = new WeakMap<object, Metadata>();
// Objects can be garbage collected when no other references exist

// ✅ Stream large files instead of loading into memory
import { createReadStream } from 'fs';
const stream = createReadStream('large-file.csv');
stream.pipe(csvParser).on('data', processRow);
```

## Performance Checklist for AI Agents

Before generating or modifying code, verify:

- [ ] Database queries use eager loading (no N+1 problems)
- [ ] Pagination implemented for list endpoints (max 100 items)
- [ ] Heavy components are lazy loaded
- [ ] Images use proper sizing, formats, and lazy loading
- [ ] Expensive computations are memoized or cached
- [ ] API calls are parallelized where possible (Promise.all)
- [ ] No unbounded queries or unlimited result sets
- [ ] Proper connection pooling for databases and external services
- [ ] Algorithm complexity is O(n log n) or better for common operations
- [ ] Subscriptions and timers are cleaned up properly
- [ ] Bundle size impact considered for new dependencies

---

**Remember**: Performance is a feature. Measure first, optimize with data, and always keep code readable.
