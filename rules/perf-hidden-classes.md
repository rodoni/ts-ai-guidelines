# perf-hidden-classes

> Initialize all object properties in constructors or factory functions in a consistent order to preserve hidden classes.

## Why It Matters
V8 and modern JS engines optimize property accesses via hidden classes (shapes / maps). Adding properties dynamically in different orders or using `delete` causes polymorphic transitions, deoptimizing inline caches (ICs) into slow dictionary lookups.

> **Applicability Scope**: While negligible in ordinary UI/CRUD logic, maintaining stable hidden classes is critical in hot paths, high-throughput backend servers, AST parsers (such as the TypeScript compiler itself), serializers (e.g., Fastify), game engines, and numerical/data pipelines where property accesses execute millions of times per second.

## Bad
```typescript
// Changing shapes dynamically causes inline cache deoptimization
function createPoint(x: number, y: number, z?: number) {
  const point: Record<string, number> = { x, y };
  if (z !== undefined) {
    point.z = z; // Triggers shape transition
  }
  return point;
}
```

## Good
```typescript
// Predictable object shape initialized consistently in one place
export interface Point3D {
  readonly x: number;
  readonly y: number;
  readonly z: number | null;
}

export function createPoint(x: number, y: number, z?: number): Point3D {
  return {
    x,
    y,
    z: z ?? null, // Consistent property initialization ensures stable hidden class
  };
}
```

## See Also
- [perf-sparse-arrays](perf-sparse-arrays.md) - Avoid deoptimizing collection layouts
- [c-readonly-immutability](c-readonly-immutability.md) - Prefer immutable objects
