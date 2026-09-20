# t-no-empty-object-type

> Avoid `{}` and `Function` types; use `Record<string, never>` for strictly empty objects, `object` for non-primitives, and explicit function signatures.

## Why It Matters
In TypeScript, the empty object type `{}` represents any non-nullish value—including primitives like numbers, booleans, and strings. The global `Function` type accepts any callable with implicit `any` arguments and returns. Both types create major holes in compile-time type safety.

## Bad
```typescript
// Bizarrely allows numbers, strings, and booleans!
const invalidObject: {} = 42;
const invalidString: {} = "hello";

// Allows unsafe invocations with untyped arguments
const execute: Function = (x: number, y: number) => x + y;
execute("untyped", true, 99); // No compiler error!
```

## Good
```typescript
// Enforces a genuinely empty object with zero permissible properties
export type EmptyObject = Record<string, never>;
export const emptyConfig: EmptyObject = {};

// Use `object` for any non-primitive reference type
export function freezeObject(target: object): void {
  Object.freeze(target);
}

// Explicit function type signature ensures parameter and return type safety
export type BinaryOperation = (x: number, y: number) => number;
export const add: BinaryOperation = (x, y) => x + y;
```

## See Also
- [t-avoid-wrapper-types](t-avoid-wrapper-types.md) - Avoid wrapper types like String and Object
- [t-no-any](t-no-any.md) - Eliminate unsafe type escapes
