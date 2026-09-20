# t-avoid-wrapper-types

> Always use lowercase primitive types (`string`, `number`, `boolean`, `symbol`, `bigint`) and never uppercase object wrapper types (`String`, `Number`, `Boolean`, `Object`).

## Why It Matters
JavaScript primitive types have corresponding object wrappers (`new String("a")`, `new Number(1)`), which behave fundamentally differently from primitive values. Using uppercase wrapper types in TypeScript annotations accepts wrapper instances but rejects plain primitives, leading to baffling type mismatches.

## Bad
```typescript
// Uses Object wrapper types instead of primitives
function formatRecord(name: String, count: Number, active: Boolean): Object {
  // Disallows passing plain string or number in strict mode contexts
  return { name, count, active };
}
```

## Good
```typescript
// Uses idiomatic TypeScript lowercase primitive types
export interface FormattedRecord {
  readonly name: string;
  readonly count: number;
  readonly active: boolean;
}

export function formatRecord(
  name: string,
  count: number,
  active: boolean
): FormattedRecord {
  return { name, count, active };
}
```

## See Also
- [t-no-any](t-no-any.md) - Eliminate unchecked types
- [c-interface-vs-type](c-interface-vs-type.md) - Define explicit interface contracts
