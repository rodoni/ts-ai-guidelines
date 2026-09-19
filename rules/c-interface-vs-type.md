# c-interface-vs-type

> Prefer `interface` for extensible object contracts and public APIs; prefer `type` for unions, intersections, primitives, and tuples.

## Why It Matters
Interfaces provide clear declaration merging, better compiler error messages for object shapes, and idiomatic extensibility via `extends`. Type aliases are essential for complex type manipulation like unions, mapped types, and primitive aliases.

> **Applicability Scope**: Universal across public APIs, library definitions, application state shapes, and domain type declarations.

## Bad
```typescript
// Using type alias for a standard extensible object shape
type ServiceConfig = {
  host: string;
  port: number;
};

// Using interface for a union (invalid TypeScript syntax!)
// interface Status = "idle" | "running";
```

## Good
```typescript
// Interface for object contracts, public APIs, and class implementations
export interface ServiceConfig {
  readonly host: string;
  readonly port: number;
}

export interface ExtendedServiceConfig extends ServiceConfig {
  readonly timeoutMs: number;
}

// Type alias for unions, intersections, primitives, and tuples
export type ServiceStatus = "idle" | "running" | "stopped";
export type Coordinates = readonly [latitude: number, longitude: number];
export type WithAudit<T> = T & { readonly createdAt: Date };
```

## See Also
- [c-readonly-immutability](c-readonly-immutability.md) - Mark fields readonly
- [t-discriminated-unions](t-discriminated-unions.md) - Model variants with unions
