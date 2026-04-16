# Comments & Documentation

## The Best Comment is No Comment

Well-written code should be self-documenting. If you need a comment to explain what code does, consider rewriting the code instead.

```typescript
❌ BAD: Comment explains what code does
// Check if the user is an adult
if (user.age >= 18) { ... }

✅ GOOD: Code is self-explanatory
if (user.isAdult()) { ... }
// or
const isAdult = user.age >= MINIMUM_ADULT_AGE;
if (isAdult) { ... }
```

## When Comments ARE Useful

### 1. Explain WHY, not WHAT

```typescript
✅ GOOD: Explains reasoning
// We use insertion sort here because the data is nearly sorted,
// making it O(n) instead of O(n log n) for quicksort
insertionSort(nearySortedData);

// Retry with exponential backoff to avoid thundering herd
await retryWithBackoff(operation, { maxRetries: 5 });
```

### 2. Clarify Non-Obvious Constraints

```typescript
✅ GOOD: Explains constraint
// Must be called before database connection is established
// due to connection pooling initialization order
initializeConnectionPool();

// Format required by external payment API (ISO 8601 without timezone)
const timestamp = date.toISOString().replace('Z', '');
```

### 3. Warn About Consequences

```typescript
✅ GOOD: Warning
// WARNING: This operation cannot be undone
await permanentlyDeleteUser(userId);

// PERFORMANCE: This query can be slow for large datasets
// Consider pagination for production use
const allUsers = await userRepository.findAll();
```

### 4. TODO/FIXME Markers

```typescript
✅ GOOD: Actionable markers
// TODO: Implement caching when we have Redis available
// FIXME: Race condition when multiple users update simultaneously
// HACK: Workaround for library bug #1234, remove when fixed
```

## What NOT to Comment

### Don't Comment Obvious Code

```typescript
❌ BAD
// Increment counter
counter++;

// Get the user
const user = getUser();

// Loop through items
for (const item of items) { ... }
```

### Don't Leave Commented-Out Code

```typescript
❌ BAD: Commented code clutters and confuses
function processOrder(order) {
  // const oldTotal = calculateOldTotal(order);
  // if (oldTotal > 1000) {
  //   applyDiscount(order);
  // }
  const total = calculateTotal(order);
}

✅ GOOD: Delete it, use version control
function processOrder(order) {
  const total = calculateTotal(order);
}
```

### Don't Add Excessive Information

```typescript
❌ BAD: Too much detail
/**
 * This function was created on 2023-05-15 by John Smith
 * as part of ticket JIRA-1234. It was later modified on
 * 2023-06-20 to fix a bug with decimal handling...
 * [100 more lines of history]
 */
function calculateTax(amount) { ... }
```

## Documentation Comments (APIs)

For public APIs, document the contract:

```typescript
✅ GOOD: Public API documentation
/**
 * Creates a new user account.
 *
 * @param data - User creation data
 * @returns The created user with generated ID
 * @throws {ValidationException} If email is invalid or already exists
 * @throws {QuotaExceededException} If organization user limit reached
 *
 * @example
 * const user = await userService.create({
 *   email: 'user@example.com',
 *   name: 'John Doe'
 * });
 */
async create(data: CreateUserData): Promise<User> { ... }
```

## Keep Comments Updated

Outdated comments are worse than no comments.

```typescript
❌ BAD: Comment doesn't match code
// Returns null if user not found
function getUser(id: string): User {
  const user = repository.findById(id);
  if (!user) {
    throw new NotFoundException('User', id);  // Actually throws!
  }
  return user;
}
```

## Summary

| Do Comment | Don't Comment |
|------------|---------------|
| Why something is done | What code does (make code clearer instead) |
| Non-obvious constraints | Obvious operations |
| Warnings and consequences | History/changelog |
| API contracts | Commented-out code |
| Complex algorithms | Redundant information |

