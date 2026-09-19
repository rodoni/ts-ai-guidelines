# t-const-assertions

> Use `as const` on literal objects, arrays, and tuples to preserve literal types and enforce deep immutability.

## Why It Matters
Without `as const`, TypeScript widens literal expressions like `["admin", "user"]` to `string[]` and `{ method: "GET" }` to `{ method: string }`, losing precise compile-time constraints and allowing unintentional mutations.

## Bad
```typescript
// Type widened to string[], mutable, lost literal values
const HTTP_METHODS = ["GET", "POST", "PUT", "DELETE"];

function request(url: string, method: "GET" | "POST") {
  // ...
}

// Compiler error: Argument of type 'string' is not assignable to 'GET' | 'POST'
request("/api", HTTP_METHODS[0]);
```

## Good
```typescript
// Preserved as readonly ["GET", "POST", "PUT", "DELETE"] with exact literal types
export const HTTP_METHODS = ["GET", "POST", "PUT", "DELETE"] as const;
export type HttpMethod = (typeof HTTP_METHODS)[number]; // "GET" | "POST" | "PUT" | "DELETE"

function request(url: string, method: HttpMethod): void {
  // Type-safe and verified
}

request("/api", HTTP_METHODS[0]); // Fully valid and type-safe
```

## See Also
- [c-avoid-enums](c-avoid-enums.md) - Prefer const objects/unions over TypeScript enums
- [c-readonly-immutability](c-readonly-immutability.md) - Enforce immutability across contracts
