# c-custom-type

> Convey domain intent through dedicated domain types and literal unions rather than ambiguous boolean flags.

## Why It Matters
Boolean arguments at call sites (`execute(true, false)`) are completely cryptic, obscure intent, and encourage AI models and developers to transpose argument order. Dedicated literal types make call sites self-documenting.

## Bad
```typescript
// What does true and false mean at the call site?
function findUsers(includeInactive: boolean, sortAscending: boolean) {
  // ...
}

// Opaque call site:
findUsers(true, false);
```

## Good
```typescript
export type InactiveFilter = "include-inactive" | "active-only";
export type SortOrder = "ascending" | "descending";

export interface FindUsersOptions {
  readonly filter: InactiveFilter;
  readonly sort: SortOrder;
}

function findUsers(options: FindUsersOptions): void {
  // ...
}

// Self-documenting call site:
findUsers({
  filter: "include-inactive",
  sort: "descending",
});
```

## See Also
- [c-branded-types](c-branded-types.md) - Nominal types for primitive distinction
- [wf-design-for-ai](wf-design-for-ai.md) - Design code for AI comprehension
