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

// Encapsulates the unavoidable internal type assertion inside a well-typed generic boundary
export function createCache<T>() {
  const store = new Map<string, unknown>();
  return {
    get(key: string): T | undefined {
      // Unavoidable internal assertion is safely isolated within this boundary
      return store.get(key) as T | undefined;
    },
    set(key: string, value: T): void {
      store.set(key, value);
    },
  };
}

// Or a generic memoization utility:
export function memoize<Args extends unknown[], R>(
  fn: (...args: Args) => R
): (...args: Args) => R {
  const cache = new Map<string, unknown>();
  return (...args: Args): R => {
    const key = JSON.stringify(args);
    if (cache.has(key)) {
      return cache.get(key) as R; // Internal assertion hidden from callers
    }
    const result = fn(...args);
    cache.set(key, result);
    return result;
  };
}

// Consumers receive complete static safety with zero leaked inline assertions
const userCache = createCache<UserProfile>();
userCache.set("u1", { id: "u1", name: "Alice" });
const user = userCache.get("u1"); // Strictly typed as UserProfile | undefined
```

## See Also
- [t-declaration-over-assertion](t-declaration-over-assertion.md) - Prefer declarations to assertions
- [t-type-predicates](t-type-predicates.md) - Implement custom runtime type guards
