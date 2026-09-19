# t-generics-simplicity

> Avoid generic over-engineering; prefer concrete types or minimal type parameters where type inference suffices.

## Why It Matters
Adding unnecessary generic type parameters complicates call sites, bloats compiler diagnostics, confuses AI coding agents, and obscures simple business logic that only operates on concrete shapes.

## Bad
```typescript
// Excessive type parameters that are only used once in arguments
function formatUserName<T extends string, U extends string>(first: T, last: U): string {
  return `${first} ${last}`.trim();
}

// Pointless generic function when parameter and return type do not relate
function logMessage<T>(msg: T): void {
  console.log(String(msg));
}
```

## Good
```typescript
// Clean, direct, self-documenting signatures
function formatUserName(first: string, last: string): string {
  return `${first} ${last}`.trim();
}

function logMessage(msg: unknown): void {
  console.log(String(msg));
}
```

## See Also
- [t-generics-constraints](t-generics-constraints.md) - Constrain generics when truly needed
- [c-return-annotations](c-return-annotations.md) - Explicit return type annotations
