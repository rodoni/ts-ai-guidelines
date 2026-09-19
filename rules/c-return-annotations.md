# c-return-annotations

> Always explicitly annotate function return types on exported module boundaries and public APIs.

## Why It Matters
While TypeScript excels at return type inference, omitting return annotations on exported functions leads to accidental breaking changes during refactoring, slows down declaration file generation (`.d.ts`), and degrades compiler performance.

## Bad
```typescript
// Return type is implicitly inferred. An accidental code tweak silently changes API return!
export function fetchAccountDetails(id: string) {
  return {
    id,
    balance: 100,
    // Omitting a property here silently changes the public contract of the module
  };
}
```

## Good
```typescript
export interface AccountDetails {
  readonly id: string;
  readonly balance: number;
}

// Explicit return type guarantees contract compliance and fast type generation
export function fetchAccountDetails(id: string): AccountDetails {
  return {
    id,
    balance: 100,
  };
}
```

## See Also
- [c-interface-vs-type](c-interface-vs-type.md) - Define contracts with interfaces
- [m-doc-contracts](m-doc-contracts.md) - Document public APIs with JSDoc
