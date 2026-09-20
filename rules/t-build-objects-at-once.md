# t-build-objects-at-once

> Build objects all at once using object literals or object spread rather than mutating properties incrementally on empty objects (`const x = {} as T`).

## Why It Matters
Starting with an empty object and asserting its type (`const pt = {} as Point`) disables type checking during construction, allowing partially uninitialized objects to be referenced if an exception occurs or if a property is forgotten. Building objects at once preserves type inference and hidden-class optimization in V8.

## Bad
```typescript
interface Point3D {
  readonly x: number;
  readonly y: number;
  readonly z: number;
}

// Partial initialization: object is incomplete and violates Point3D contract during construction
const pt = {} as Point3D;
pt.x = 3;
pt.y = 4;
// Forgot pt.z = 5! Compiles without error due to `as Point3D`.
```

## Good
```typescript
interface Point3D {
  readonly x: number;
  readonly y: number;
  readonly z: number;
}

// Complete initialization in a single literal expression
export const pt: Point3D = {
  x: 3,
  y: 4,
  z: 5,
};

// Or incrementally combine using object spread with immutable updates
const base = { x: 3, y: 4 };
export const pt3d: Point3D = { ...base, z: 5 };
```

## See Also
- [perf-hidden-classes](perf-hidden-classes.md) - Consistent property initialization for V8
- [t-declaration-over-assertion](t-declaration-over-assertion.md) - Avoid unsafe type assertions
