# wf-tdd-loop

> Develop guided by tests (TDD): write or define automated tests before implementing feature logic.

## Why It Matters
Writing tests first forces clear API design, clarifies edge cases early, provides immediate deterministic feedback to the AI agent during implementation, and prevents regression bugs.

## Bad
```typescript
// Writing implementation without tests:
export function parseSemver(version: string): { major: number; minor: number; patch: number } {
  const parts = version.split(".");
  // Forgets validation, ignores pre-release tags, and leaves error behavior undefined!
  return { major: Number(parts[0]), minor: Number(parts[1]), patch: Number(parts[2]) };
}
```

## Good
```typescript
// 1. Write the test specification first (e.g. using Vitest):
import { describe, it, expect } from "vitest";
import { parseSemver } from "./semver.js";

describe("parseSemver", () => {
  it("parses valid semver strings", () => {
    expect(parseSemver("1.2.3")).toEqual({ major: 1, minor: 2, patch: 3 });
  });

  it("throws on malformed versions", () => {
    expect(() => parseSemver("invalid")).toThrowError(TypeError);
  });
});

// 2. Then write the minimal implementation that passes the verification gate
```

## See Also
- [wf-verification-gates](wf-verification-gates.md) - Deterministic verification loops
- [m-mockable-io](m-mockable-io.md) - Testable domain logic
