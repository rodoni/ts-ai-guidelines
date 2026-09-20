# t-encapsulate-assertions

> Encapsulate unavoidable type assertions inside well-typed utility functions, exposing strictly typed public signatures to consumers.

## Why It Matters
When low-level operations (like memoization, binary parsing, or cache lookups) require type assertions or `unknown` casts, leaking `as TargetType` into application logic spreads fragility across the codebase. Containing the assertion inside a dedicated utility function maintains a strong type boundary.

## Bad
```typescript
interface UserProfile {
  readonly id: string;
  readonly name: string;
}

const cache = new Map<string, unknown>();

// Leak: Every caller must cast manually, risking unverified type divergence
const user = cache.get("u1") as UserProfile;
console.log(user.name.toUpperCase());
```

## Good
```typescript
interface UserProfile {
  readonly id: string;
  readonly name: string;
}

const cache = new Map<string, unknown>();

// Encapsulates the assertion/narrowing cleanly within a reusable boundary
export function getCached<T>(
  store: Map<string, unknown>,
  key: string,
  predicate: (val: unknown) => val is T
): T | undefined {
  const value = store.get(key);
  return predicate(value) ? value : undefined;
}

function isUserProfile(val: unknown): val is UserProfile {
  return typeof val === "object" && val !== null && "name" in val;
}

// Caller receives a completely safe, verified type with zero inline assertions
const user = getCached(cache, "u1", isUserProfile);
```

## See Also
- [t-declaration-over-assertion](t-declaration-over-assertion.md) - Prefer declarations to assertions
- [t-type-predicates](t-type-predicates.md) - Implement custom runtime type guards
