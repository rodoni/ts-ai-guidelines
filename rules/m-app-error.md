# m-app-error

> Return strongly typed error unions (`Result<T, E>`) or throw custom typed `Error` subclasses; never throw plain strings or objects.

## Why It Matters
Throwing arbitrary strings or untyped objects (`throw "error"`) strips stack traces, prevents `instanceof` narrowing in catch blocks, and turns runtime exception handling into fragile guessing games.

## Bad
```typescript
// Throwing untyped string loses stack trace and cannot be safely inspected
function authenticate(token: string) {
  if (!token) {
    throw "Invalid token"; // Loses stack trace, catches as unknown
  }
}
```

## Good
```typescript
// Dedicated custom error subclass preserves stack trace and supports instanceof narrowing
export class AuthenticationError extends Error {
  constructor(message: string, readonly reason: "expired" | "malformed" | "missing") {
    super(message);
    this.name = "AuthenticationError";
  }
}

// Or functional Result pattern for predictable fallible operations
export type Result<T, E> =
  | { readonly ok: true; readonly value: T }
  | { readonly ok: false; readonly error: E };

export function parseToken(token: string): Result<{ userId: string }, AuthenticationError> {
  if (!token) {
    return {
      ok: false,
      error: new AuthenticationError("Token is missing", "missing"),
    };
  }
  return { ok: true, value: { userId: "usr_123" } };
}
```

## See Also
- [t-discriminated-unions](t-discriminated-unions.md) - Model variants with discriminated unions
- [m-doc-contracts](m-doc-contracts.md) - Document exceptions in JSDoc `@throws`
