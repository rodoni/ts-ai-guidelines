# test-deterministic-no-sleep

> Eliminate wall-clock sleeps (`setTimeout`, delays) in unit tests; use virtual timers (`vi.useFakeTimers()`).

## Why It Matters
Using real `setTimeout` or sleep helper promises causes sluggish CI pipelines and flaky test suites. Under variable CI loads, arbitrary timeouts (e.g. `await delay(50)`) often expire prematurely or trail behind execution, resulting in non-deterministic race conditions and transient failures.

## Bad
```typescript
import { it, expect } from "vitest";

it("resets rate limiter window after expiry", async () => {
  const limiter = new RateLimiter({ windowMs: 50, maxRequests: 1 });
  await limiter.acquire();

  // BAD: Real wall-clock sleep; burns execution time and introduces CI flakiness
  await new Promise((resolve) => setTimeout(resolve, 60));

  expect(limiter.canAcquire()).toBe(true);
});
```

## Good
```typescript
import { it, expect, vi, beforeEach, afterEach } from "vitest";

beforeEach(() => {
  vi.useFakeTimers();
});

afterEach(() => {
  vi.useRealTimers();
});

it("resets rate limiter window deterministically using fake timers", async () => {
  const limiter = new RateLimiter({ windowMs: 60_000, maxRequests: 1 });
  await limiter.acquire();

  // GOOD: Deterministically advances virtual clock without burning wall-clock time
  vi.advanceTimersByTime(60_000);

  expect(limiter.canAcquire()).toBe(true);
});
```

## See Also
- [m-mockable-io](m-mockable-io.md) - Decouple system clocks via injectable interfaces
- [wf-verification-gates](wf-verification-gates.md) - Fast, deterministic feedback loops
