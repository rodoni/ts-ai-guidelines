# t-no-any

> Never use the `any` type; use `unknown` for unchecked values and narrow before usage.

## Why It Matters
Using `any` completely disables the TypeScript type checker, breaks autocompletion, propagates unchecked assumptions across modules, and leads to unexpected runtime errors.

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

function isRecord(val: unknown): val is Record<string, unknown> {
  return typeof val === "object" && val !== null;
}

export function isUserPayload(val: unknown): val is UserPayload {
  if (!isRecord(val) || !("user" in val) || !isRecord(val.user)) {
    return false;
  }
  if (!("profile" in val.user) || !isRecord(val.user.profile)) {
    return false;
  }
  return typeof val.user.profile.name === "string";
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
