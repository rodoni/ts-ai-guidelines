# t-variable-type-stability

> Use distinct, descriptive variables for different types and domain concepts; never reassign a variable to a conflicting type.

## Why It Matters
Reassigning a mutable variable across differing types creates bloated union types (`string | number`), complicates compiler narrowing, and forces defensive runtime checking. Distinct variables communicate semantic intent clearly and enable V8 to optimize object shapes.

## Bad
```typescript
// Variable mutates type across steps, creating an unnecessary union type
let targetId: string | number = "105";
console.log(targetId.trim()); // Works while string

targetId = parseInt(targetId, 10);
// Now number, but compiler considers type union `string | number` in broader scopes
console.log(targetId.toFixed(2));
```

## Good
```typescript
// Distinct, immutable constants preserve exact type identity and clarity
const rawTargetId = "105";
const formattedId = rawTargetId.trim();

export const numericTargetId = parseInt(formattedId, 10);
console.log(numericTargetId.toFixed(2));
```

## See Also
- [c-readonly-immutability](c-readonly-immutability.md) - Mark fields and variables immutable
- [t-avoid-redundant-annotations](t-avoid-redundant-annotations.md) - Clean local inference
