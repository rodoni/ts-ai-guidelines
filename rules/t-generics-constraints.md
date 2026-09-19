# t-generics-constraints

> Constrain generic type parameters (`T extends Base`) rather than using unbounded generics.

## Why It Matters
Unbounded generic parameters (`<T>`) behave like `unknown` inside the function body, preventing property access without casting. Constraining parameters with `extends` documents required capabilities and ensures caller compatibility.

## Bad
```typescript
// Unbounded T forces dangerous type casting inside the function
function getIdentifier<T>(entity: T): string {
  return (entity as any).id; // Runtime failure if entity lacks 'id'
}
```

## Good
```typescript
// Explicit generic constraint enforces that entity contains a valid string id
interface Identifiable {
  readonly id: string;
}

function getIdentifier<T extends Identifiable>(entity: T): string {
  return entity.id; // Fully type-safe and verified at compile time
}
```

## See Also
- [t-generics-simplicity](t-generics-simplicity.md) - Avoid over-engineering with generics
- [c-interface-vs-type](c-interface-vs-type.md) - Using interfaces for extensible bounds
