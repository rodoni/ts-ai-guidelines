# t-no-any

> Never use the `any` type; use `unknown` for unchecked values and narrow before usage.

## Why It Matters
Using `any` completely disables the TypeScript type checker, breaks autocompletion, propagates unchecked assumptions across modules, and leads to unexpected runtime errors.

> **Applicability Scope**: Universal in all production codebases and libraries. In legacy migrations, isolate unchecked data to boundaries using temporary migration wrappers rather than propagating any.

## Bad
```typescript
// Disables all type safety and propagates unverified data
export function parsePayload(raw: any): string {
  return raw.user.profile.name.toUpperCase(); // Runtime TypeError if user or profile is undefined
}
```

## Good
```typescript
// Forces runtime verification and safe type narrowing before access
interface UserProfile {
  readonly name: string;
}

interface UserPayload {
  readonly user: {
    readonly profile: UserProfile;
  };
}

export function isUserPayload(val: unknown): val is UserPayload {
  return (
    typeof val === "object" &&
    val !== null &&
    "user" in val &&
    typeof (val as Record<string, unknown>).user === "object" &&
    (val as Record<string, unknown>).user !== null &&
    "profile" in (val as Record<string, { profile?: unknown }>).user! &&
    typeof (val as { user: { profile: unknown } }).user.profile === "object" &&
    typeof (val as { user: { profile: { name?: unknown } } }).user.profile?.name === "string"
  );
}

export function parsePayload(raw: unknown): string {
  if (!isUserPayload(raw)) {
    throw new TypeError("Invalid payload structure");
  }
  return raw.user.profile.name.toUpperCase();
}
```

## See Also
- [t-type-predicates](t-type-predicates.md) - Define runtime type guards
- [m-validate-inputs](m-validate-inputs.md) - Schema validation at boundary gates
