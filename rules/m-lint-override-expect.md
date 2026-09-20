# m-lint-override-expect

> Use inline linter suppressions with explicit rationale comments; never disable lints globally or without justification.

## Why It Matters
Global or unannotated `eslint-disable` comments hide legitimate defects, bypass continuous quality gates, and become "zombie exemptions" that remain in the codebase indefinitely after the original context has changed.

## Bad
```typescript
/* eslint-disable @typescript-eslint/no-explicit-any */
// Disables lint for the entire file without any explanation!
function processOldFormat(data: any) {
  // ...
}
```

## Good
```typescript
// Single line suppression with explicit technical justification
// eslint-disable-next-line @typescript-eslint/no-non-null-assertion -- Legacy bridge guarantees token after handshake
function processOldFormat(token: string | undefined): void {
  const value = token!;
  // ...
}
```

## See Also
- [t-no-any](t-no-any.md) - Forbid `any` type
- [wf-verification-gates](wf-verification-gates.md) - Verification gate discipline
