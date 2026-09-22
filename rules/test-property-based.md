# test-property-based

> Use property-based testing (`fast-check`) for pure functions, parsers, serialization, and domain invariants.

## Why It Matters
Example-based unit tests only check hand-picked inputs that adhere to human (or AI) bias, frequently missing integer boundaries, empty strings, unescaped characters, Unicode surrogates, and unexpected edge states. Property-based tests generate hundreds of pseudo-random inputs and automatically shrink failing cases to the minimal reproducible counterexample.

## Bad
```typescript
// Only tests two arbitrary happy-path examples; misses boundary cases and edge states
describe("encode / decode", () => {
  it("encodes and decodes strings", () => {
    const input = "hello";
    const encoded = encodePayload(input);
    expect(decodePayload(encoded)).toBe(input);
  });
});
```

## Good
```typescript
import { describe, it } from "vitest";
import fc from "fast-check";
import { encodePayload, decodePayload } from "./codec.js";

describe("encode / decode roundtrip", () => {
  it("preserves any arbitrary string payload through roundtrip", () => {
    fc.assert(
      fc.property(fc.fullUnicodeString(), (original) => {
        const encoded = encodePayload(original);
        const decoded = decodePayload(encoded);
        return decoded === original;
      }),
      { numRuns: 200 }
    );
  });

  it("satisfies numeric bounds invariant", () => {
    fc.assert(
      fc.property(fc.integer({ min: 0, max: 10_000 }), fc.integer({ min: 1, max: 10_000 }), (a, b) => {
        const ratio = safeDivideScale(a, b);
        return ratio <= a;
      })
    );
  });
});
```

## See Also
- [test-behavior-not-internals](test-behavior-not-internals.md) - Focus tests on domain invariants
- [wf-tdd-loop](wf-tdd-loop.md) - Define behavioral properties before implementing
