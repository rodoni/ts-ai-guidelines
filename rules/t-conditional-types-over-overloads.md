# t-conditional-types-over-overloads

> Prefer conditional types (`T extends A ? B : C`) over repetitive function overloads to model dependent return types cleanly and preserve union distributions.

## Why It Matters
Function overloads often produce fragile signatures that fail when passed unions of argument types. Conditional types express the direct input-to-output type mapping in a single unified signature that cleanly distributes over union arguments.

## Bad
```typescript
// Overloads fail to resolve when argument is a union like `string | number`
function double(x: number): number;
function double(x: string): string;
function double(x: number | string): number | string {
  return typeof x === "number" ? x * 2 : x + x;
}

const input: number | string = Math.random() > 0.5 ? 10 : "hi";
// Compiler error: No overload matches this call!
const result = double(input);
```

## Good
```typescript
// Single conditional signature accurately models dependent return type
export type DoubleResult<T extends number | string> = T extends number ? number : string;

export function double<T extends number | string>(x: T): DoubleResult<T> {
  return castDoubleResult(typeof x === "number" ? x * 2 : x + x);
}

function castDoubleResult<T extends number | string>(value: number | string): DoubleResult<T> {
  // The runtime branch above proves the mapping; keep this unavoidable assertion local.
  return value as DoubleResult<T>;
}

const input: number | string = Math.random() > 0.5 ? 10 : "hi";
const result = double(input); // Accurately typed as number | string
```

## See Also
- [t-generics-constraints](t-generics-constraints.md) - Constrain generic parameters
- [t-discriminated-unions](t-discriminated-unions.md) - Model variants with discriminated unions
