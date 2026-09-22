# test-assert-error-variants

> Assert specific error classes, error codes, or discriminated error shapes; never use blind generic `toThrow()`.

## Why It Matters
Blindly asserting `expect(() => fn()).toThrow()` passes if the function throws *any* unexpected exception—such as a `TypeError` from an undefined property, an unhandled network error, or a syntax bug. Robust tests must verify that the failure occurred for the exact domain reason intended.

## Bad
```typescript
import { expect, it } from "vitest";

it("rejects duplicate email registration", async () => {
  const repo = new UserRepository();
  await repo.insert({ email: "alice@example.com" });

  // BAD: Passes if insert fails for ANY reason (e.g. database timeout or TypeError)!
  await expect(repo.insert({ email: "alice@example.com" })).rejects.toThrow();
});
```

## Good
```typescript
import { expect, it } from "vitest";
import { DuplicateEmailError } from "./errors.js";

it("rejects duplicate email registration with exact error details", async () => {
  const repo = new UserRepository();
  await repo.insert({ email: "alice@example.com" });

  // GOOD: Asserts the exact domain error class and inspects error payload properties
  await expect(
    repo.insert({ email: "alice@example.com" })
  ).rejects.toThrowError(DuplicateEmailError);

  // Or asserting discriminated Result / AppError shapes:
  const result = await repo.safeInsert({ email: "alice@example.com" });
  expect(result.ok).toBe(false);
  if (!result.ok) {
    expect(result.error.code).toBe("ERR_DUPLICATE_EMAIL");
    expect(result.error.context).toEqual({ email: "alice@example.com" });
  }
});
```

## See Also
- [m-app-error](m-app-error.md) - Strongly typed error hierarchies
- [test-behavior-not-internals](test-behavior-not-internals.md) - Validate domain contracts
