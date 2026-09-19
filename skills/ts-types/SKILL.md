---
name: ts-types
description: >
  Deep type soundness guidelines based on the TypeScript Handbook. Covers discriminated unions,
  exhaustiveness checking with never, custom type predicates, narrowing operators, generic constraints,
  and strict compiler configuration without any.
license: MIT
---

# TypeScript Types & Soundness Skill

Guidelines and procedures for designing sound, compile-time verified TypeScript types and eliminating unverified runtime state.

## Core Rules

1. **Strict Compiler Setup**: Enforce all strict compiler flags.
   - [`t-strict-mode`](../../rules/t-strict-mode.md)
   - [`t-exact-optional`](../../rules/t-exact-optional.md)
2. **Zero `any` Policy**: Disallow `any`; use `unknown` with safe narrowing.
   - [`t-no-any`](../../rules/t-no-any.md)
3. **State Modeling**: Use discriminated unions and exhaustive branch verification.
   - [`t-discriminated-unions`](../../rules/t-discriminated-unions.md)
   - [`t-exhaustiveness-check`](../../rules/t-exhaustiveness-check.md)
4. **Type Narrowing**: Implement robust type guards and structural checks.
   - [`t-type-predicates`](../../rules/t-type-predicates.md)
   - [`t-narrowing-in-operator`](../../rules/t-narrowing-in-operator.md)
5. **Generics & Literal Types**: Constrain generics and enforce literals with `as const`.
   - [`t-const-assertions`](../../rules/t-const-assertions.md)
   - [`t-generics-constraints`](../../rules/t-generics-constraints.md)
   - [`t-generics-simplicity`](../../rules/t-generics-simplicity.md)

## Verification Procedure

When writing or verifying types:
1. Run `npx tsc --noEmit` to ensure zero compilation errors under strict mode.
2. Confirm that every union switch statement has a `default: assertNever(val)` branch.
3. Verify that any function accepting `unknown` narrows via custom predicate or schema before accessing properties.
