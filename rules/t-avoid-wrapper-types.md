# t-avoid-wrapper-types

> Always use lowercase primitive types (`string`, `number`, `boolean`, `symbol`, `bigint`) and never uppercase object wrapper types (`String`, `Number`, `Boolean`, `Object`).

## Why It Matters
JavaScript primitive types have corresponding object wrappers (`new String("a")`, `new Number(1)`), which behave fundamentally differently from primitive values. While TypeScript allows assigning primitives (`string`) to wrapper types (`String`), the reverse is forbidden: wrapper types cannot be assigned to primitives. Moreover, object wrappers introduce runtime traps (such as `new Boolean(false)` evaluating as truthy, and `typeof new String("a") === "object"`), breaking downstream API contracts.

## Bad
```typescript
// Uses Object wrapper types instead of primitives
function formatRecord(name: String, count: Number, active: Boolean): { name: String; count: Number; active: Boolean } {
  return { name, count, active };
}

const record = formatRecord("item", 42, true);

function sanitize(val: string): string {
  return val.trim();
}

// Compiler Error: Argument of type 'String' is not assignable to parameter of type 'string'.
// 'string' is a primitive, but 'String' is a wrapper object!
// sanitize(record.name);
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

function sanitize(val: string): string {
  return val.trim();
}

const record = formatRecord("item", 42, true);
sanitize(record.name); // Fully compatible with standard primitive contracts
```

## See Also
- [t-no-any](t-no-any.md) - Eliminate unchecked types
- [c-interface-vs-type](c-interface-vs-type.md) - Define explicit interface contracts
