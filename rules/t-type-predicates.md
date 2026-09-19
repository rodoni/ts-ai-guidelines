# t-type-predicates

> Implement custom type predicates (`value is Type`) with rigorous runtime checks instead of blind type assertions.

## Why It Matters
A poorly written type guard that performs superficial checks acts like an unchecked type cast, giving false confidence to the type system while allowing malformed data to crash downstream code.

## Bad
```typescript
interface AdminUser {
  id: string;
  role: "admin";
  permissions: string[];
}

// Superficial check: does not verify id or permissions array!
function isAdmin(user: unknown): user is AdminUser {
  return typeof user === "object" && user !== null && (user as any).role === "admin";
}
```

## Good
```typescript
interface AdminUser {
  readonly id: string;
  readonly role: "admin";
  readonly permissions: readonly string[];
}

function isAdmin(user: unknown): user is AdminUser {
  if (typeof user !== "object" || user === null) {
    return false;
  }
  const candidate = user as Record<string, unknown>;
  return (
    typeof candidate.id === "string" &&
    candidate.role === "admin" &&
    Array.isArray(candidate.permissions) &&
    candidate.permissions.every((p) => typeof p === "string")
  );
}
```

## See Also
- [t-no-any](t-no-any.md) - Forbid `any` type usage
- [t-narrowing-in-operator](t-narrowing-in-operator.md) - Use structural operators for narrowing
