# t-exact-optional

> Distinguish between omitted optional properties and explicit `undefined` values using `exactOptionalPropertyTypes`.

## Why It Matters
In JavaScript, an object with key `foo: undefined` is fundamentally different from an object where `foo` does not exist (`"foo" in obj` is true vs false; `Object.keys()` includes "foo"). Without `exactOptionalPropertyTypes`, TypeScript conflates the two, introducing subtle bugs in mergers, serialization, and database updates.

> **Applicability Scope**: Universal for object patch payloads, DTOs, database updates, configuration merges, and API serialization contracts.

## Bad
```typescript
interface UpdateUserDto {
  nickname?: string; // Without exactOptionalPropertyTypes, nickname: undefined is allowed
}

function applyUpdate(current: { nickname: string }, update: UpdateUserDto) {
  // If update is { nickname: undefined }, spreading overwrites nickname with undefined!
  return { ...current, ...update };
}
```

## Good
```typescript
// With "exactOptionalPropertyTypes": true in tsconfig.json:
interface UpdateUserDto {
  readonly nickname?: string; // Must be string or omitted; cannot explicitly pass undefined
  readonly bio?: string | undefined; // Explicitly allows passing undefined if deletion is intended
}

function applyUpdate(
  current: { readonly nickname: string; readonly bio?: string },
  update: UpdateUserDto
) {
  const result = { ...current };
  if (update.nickname !== undefined) {
    // Safely updated only when provided
    Object.assign(result, { nickname: update.nickname });
  }
  return result;
}
```

## See Also
- [t-strict-mode](t-strict-mode.md) - Compiler strict configuration
- [c-readonly-immutability](c-readonly-immutability.md) - Immutable data structures
