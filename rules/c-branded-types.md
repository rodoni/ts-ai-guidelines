# c-branded-types

> Use Branded Types (nominal typing) to prevent primitive obsession and accidental argument swapping.

## Why It Matters
TypeScript uses structural typing: any `string` is compatible with any other `string`. When functions accept multiple IDs (e.g. `userId: string, orderId: string`), callers and AI agents frequently transpose adjacent arguments without any compiler warning.

> **Applicability Scope**: Domain identifiers (IDs, keys), monetary amounts, validated strings (emails, URLs), and any function taking multiple primitive parameters of the same type.

## Bad
```typescript
// Primitive obsession: compiler cannot prevent swapped arguments
function cancelOrder(userId: string, orderId: string): void {
  // ...
}

const userId = "usr_123";
const orderId = "ord_456";

// BUG: Arguments swapped, but compiler stays completely silent!
cancelOrder(orderId, userId);
```

## Good
```typescript
// Branded types simulate nominal typing at zero runtime cost
export type UserId = string & { readonly __brand: unique symbol };
export type OrderId = string & { readonly __brand: unique symbol };

export function toUserId(id: string): UserId {
  return id as UserId;
}

export function toOrderId(id: string): OrderId {
  return id as OrderId;
}

function cancelOrder(user: UserId, order: OrderId): void {
  // ...
}

const userId = toUserId("usr_123");
const orderId = toOrderId("ord_456");

// Compiler Error: Argument of type 'OrderId' is not assignable to parameter of type 'UserId'
cancelOrder(orderId, userId);
```

## See Also
- [c-custom-type](c-custom-type.md) - Dedicated domain types over primitives
- [wf-design-for-ai](wf-design-for-ai.md) - Design types for AI comprehension
