# test-behavior-not-internals

> Test observable module contracts and domain invariants, not private volatile implementation details.

## Why It Matters
Unit tests coupled to private helper functions, hidden internal states, or transient computation steps become brittle refactoring anchors. They fail upon harmless structural changes even when the public contract is preserved. Testing at the interface boundary ensures tests serve as long-lasting safety nets.

## Bad
```typescript
import { it, expect } from "vitest";
import { TokenGenerator } from "./token.js";

it("computes private intermediate hash step", () => {
  const generator = new TokenGenerator();
  // BAD: Accessing internal private helper via type cast or reflection
  const nonce = (generator as any).computeInternalNonce("seed");
  expect(nonce).toBe("0xcafe");
});
```

## Good
```typescript
import { it, expect } from "vitest";
import { TokenGenerator } from "./token.js";

it("satisfies token length, entropy, and validity invariants", () => {
  const generator = new TokenGenerator();
  const token = generator.generateToken("seed");

  // GOOD: Asserts observable public invariants guaranteed by contract
  expect(token).toHaveLength(32);
  expect(generator.isValidToken(token)).toBe(true);
});
```

## See Also
- [c-dont-leak-internals](c-dont-leak-internals.md) - Encapsulate internal module machinery
- [test-property-based](test-property-based.md) - Validate invariant properties across inputs
