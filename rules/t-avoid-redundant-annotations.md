# t-avoid-redundant-annotations

> Avoid cluttering code with inferable local type annotations; annotate function signatures and exported module boundaries, and let TypeScript infer local variables.

## Why It Matters
Manually annotating obvious local variables wastes LLM context tokens, clutters code readability, and actively hampers refactoring. When an underlying function signature changes, redundant annotations prevent TypeScript from automatically propagating updated types across call sites.

## Bad
```typescript
interface User {
  readonly id: string;
  readonly name: string;
}

function getUser(id: string): User {
  return { id, name: "Alice" };
}

// Redundant annotations on trivial literals and obvious call returns
const count: number = 10;
const greeting: string = "hello";
const user: User = getUser("u1");
const numbers: number[] = [1, 2, 3];
```

## Good
```typescript
interface User {
  readonly id: string;
  readonly name: string;
}

// Annotate public function boundaries and parameters
export function getUser(id: string): User {
  return { id, name: "Alice" };
}

// Let TypeScript naturally infer local variable types from expressions
const count = 10;
const greeting = "hello";
const user = getUser("u1");
const numbers = [1, 2, 3];
```

## See Also
- [c-return-annotations](c-return-annotations.md) - Explicit return types on public boundaries
- [t-const-assertions](t-const-assertions.md) - Preserve literal types with `as const`
