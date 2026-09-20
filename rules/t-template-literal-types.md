# t-template-literal-types

> Use template literal types (`${Entity}:${Action}`) to enforce structured string patterns and API contracts at compile time.

## Why It Matters
Using plain `string` for event names, route patterns, CSS properties, or database keys leads to silent runtime typos. Template literal types build grammar rules directly into TypeScript's type system, catching invalid combinations before execution.

## Bad
```typescript
// Plain strings permit arbitrary typos and provide no editor completion
type EventName = string;

function emit(event: EventName, payload: unknown) {
  // typo "usre:create" compiles without warning
}

emit("usre:create", { id: "123" });
```

## Good
```typescript
type Entity = "user" | "order" | "invoice";
type Action = "created" | "updated" | "deleted";

// Compile-time grammar: guarantees only valid entity-action combinations compile
export type DomainEvent = `${Entity}:${Action}`;

export function emit(event: DomainEvent, payload: unknown): void {
  // Implementation
}

emit("user:created", { id: "123" });
// emit("usre:create", { id: "123" }); // Compiler error: Argument is not assignable!
```

## See Also
- [c-branded-types](c-branded-types.md) - Nominal typing for domain identifiers
- [c-custom-type](c-custom-type.md) - Express domain intent through dedicated types
