# t-separate-types-spaces

> Keep the distinction between type space and value space explicit to eliminate syntactic ambiguity and runtime errors.

## Why It Matters
In TypeScript, symbols with identical names can exist simultaneously in the type space (erased at compile time) and the value space (retained at runtime). Misunderstanding how operators like `typeof` and `InstanceType` behave across boundaries leads to silent logic errors.

## Bad
```typescript
interface Cylinder {
  readonly radius: number;
  readonly height: number;
}

export const Cylinder = (radius: number, height: number) => ({ radius, height });

// Ambiguous: typeof Cylinder in value space refers to the function, not the interface!
function calculateVolume(shape: typeof Cylinder) {
  // shape is typed as the function signature, not the Cylinder object!
}
```

## Good
```typescript
// Clear separation of object interface and constructor/factory function
export interface Cylinder {
  readonly radius: number;
  readonly height: number;
}

export function createCylinder(radius: number, height: number): Cylinder {
  return { radius, height };
}

// Explicitly use the type identifier in type annotations
export function calculateVolume(c: Cylinder): number {
  return Math.PI * c.radius * c.radius * c.height;
}
```

## See Also
- [perf-type-imports](perf-type-imports.md) - Use explicit `import type` to isolate type space
- [c-interface-vs-type](c-interface-vs-type.md) - Define explicit object contracts
