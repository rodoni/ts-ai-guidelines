# m-mockable-io

> Decouple core domain logic from external I/O (network, filesystem, system clock) using interfaces or dependency injection.

## Why It Matters
Directly embedding `fetch`, `fs.readFile`, or `Date.now()` inside business calculations couples tests to the environment, causes test flakiness, and prevents deterministic unit testing by AI agents.

## Bad
```typescript
import fs from "node:fs";

export class OrderService {
  processOrder(orderId: string): boolean {
    // Hardcoded I/O inside domain calculation
    const raw = fs.readFileSync(`/data/orders/${orderId}.json`, "utf-8");
    const order = JSON.parse(raw);
    return order.total > 0;
  }
}
```

## Good
```typescript
export interface OrderReader {
  readOrder(orderId: string): Promise<Order | null>;
}

export class OrderService {
  constructor(private readonly reader: OrderReader) {}

  async processOrder(orderId: string): Promise<boolean> {
    const order = await this.reader.readOrder(orderId);
    if (!order) {
      return false;
    }
    return order.total > 0;
  }
}
```

## See Also
- [c-interface-vs-type](c-interface-vs-type.md) - Define contracts with interfaces
- [wf-tdd-loop](wf-tdd-loop.md) - Test-driven development workflows
