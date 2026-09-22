---
name: ts-testing
description: >
  Comprehensive guidelines for writing high-confidence, idiomatic TypeScript unit, integration,
  property-based, and type-level tests with minimal maintenance overhead and zero token waste.
---

# TypeScript Testing & Verification Guidelines

Engineering standards for robust, deterministic, and maintainable test suites in TypeScript and modern JavaScript environments. Enforces high-leverage testing patterns: property-based testing (`fast-check`), in-memory fakes, precise error assertions, deterministic timer simulation, and snapshot testing.

## Rules Index

| Rule | Impact | Summary |
|---|---|---|
| [`test-property-based`](../../rules/test-property-based.md) | HIGH | Use property-based testing (`fast-check`) for pure logic, codecs, and domain invariants. |
| [`test-assert-error-variants`](../../rules/test-assert-error-variants.md) | HIGH | Assert specific error classes and discriminated payloads; avoid blind `toThrow()`. |
| [`test-deterministic-no-sleep`](../../rules/test-deterministic-no-sleep.md) | HIGH | Eliminate wall-clock sleeps (`setTimeout`); use virtual timers (`vi.useFakeTimers()`). |
| [`test-fakes-over-heavy-mocks`](../../rules/test-fakes-over-heavy-mocks.md) | MEDIUM | Prefer simple in-memory fakes and interfaces over complex dynamic mock monkeypatching. |
| [`test-behavior-not-internals`](../../rules/test-behavior-not-internals.md) | HIGH | Test observable module contracts and invariants, not ephemeral private helper functions. |
| [`test-snapshot-for-complex-data`](../../rules/test-snapshot-for-complex-data.md) | MEDIUM | Use snapshot testing (`toMatchSnapshot()`) for complex ASTs, schemas, and serialized outputs. |
| [`wf-tdd-loop`](../../rules/wf-tdd-loop.md) | CRITICAL | Write reproducible failing tests before implementing features or bug fixes. |
| [`wf-verification-gates`](../../rules/wf-verification-gates.md) | CRITICAL | Validate changes against `tsc --noEmit`, ESLint, and test execution runners. |
| [`m-mockable-io`](../../rules/m-mockable-io.md) | HIGH | Design core domain logic decoupled from raw I/O behind dependency injection or interfaces. |

---

## 🎯 Testing Hierarchy in TypeScript

1. **Unit Tests (`src/**/*.test.ts` or `src/**/__tests__/*.ts`)**:
   - Reside alongside the implementation modules.
   - Verify specific component invariants and logic boundaries.
   - Fast, in-memory, zero network/disk access.
2. **Integration Tests (`test/**/*.test.ts`)**:
   - Exercise public package entry points (`dist/` or public exports).
   - Validate realistic end-to-end multi-component workflows and persistence layers.
   - Use in-memory or ephemeral isolated test containers.
3. **Type-Level Tests (`expectTypeOf` / `tsd`)**:
   - Validated at typecheck time (`npx tsc --noEmit` or `vitest typecheck`).
   - Guarantee that generic parameters, union narrowing, and mapped types produce expected compile-time types without runtime overhead.
