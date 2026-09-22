# test-fakes-over-heavy-mocks

> Favor in-memory fakes and interface decoupling over heavy dynamic mocking libraries.

## Why It Matters
Deep mocking libraries often couple tests to brittle implementation mechanics (exact call order, method names, and mock setup boilerplates). Simple in-memory fakes (such as `Map`-backed repositories or queue implementations) provide type-safe, reusable test doubles that execute at native speed and survive internal refactorings.

## Bad
```typescript
import { it, expect, vi } from "vitest";

it("creates an order using brittle dynamic mocks", async () => {
  // Overly coupled to internal method names and call sequences
  const mockDb = {
    getUser: vi.fn().mockResolvedValue({ id: 123, active: true }),
    saveOrder: vi.fn().mockResolvedValue(undefined),
  };

  const service = new OrderService(mockDb as any);
  await service.createOrder(123, 50);

  expect(mockDb.getUser).toHaveBeenCalledWith(123);
  expect(mockDb.saveOrder).toHaveBeenCalledTimes(1);
});
```

## Good
```typescript
import { it, expect } from "vitest";
import type { DatabaseClient, User, Order } from "./types.js";

// Clean, reusable in-memory fake implementing domain contract
class InMemoryDatabase implements DatabaseClient {
  readonly users = new Map<number, User>();
  readonly orders: Order[] = [];

  async getUser(id: number): Promise<User | null> {
    return this.users.get(id) ?? null;
  }

  async saveOrder(order: Order): Promise<void> {
    this.orders.push(order);
  }
}

it("creates an order using a durable in-memory fake", async () => {
  const db = new InMemoryDatabase();
  db.users.set(123, { id: 123, active: true });

  const service = new OrderService(db);
  await service.createOrder(123, 50);

  expect(db.orders).toHaveLength(1);
  expect(db.orders[0]?.userId).toBe(123);
});
```

## See Also
- [m-mockable-io](m-mockable-io.md) - Decouple core domain logic from I/O
- [test-behavior-not-internals](test-behavior-not-internals.md) - Test observable outcomes
