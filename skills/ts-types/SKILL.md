---
name: ts-types
description: >
  Deep type soundness guidelines based on the TypeScript Official Handbook and Effective TypeScript (Dan Vanderkam).
  Covers discriminated unions, exhaustiveness checking with never, declaration over assertion, satisfies operator,
  template literal types, mapped types sync, custom type predicates, narrowing operators, generic constraints,
  and strict compiler configuration without any.
license: MIT
---

# TypeScript Types & Soundness Skill

Guidelines and procedures for designing sound, compile-time verified TypeScript types and eliminating unverified runtime state.

## Core Rules

1. **Strict Compiler Setup & Primitive Cleanliness**:
   - [`t-strict-mode`](../../rules/t-strict-mode.md)
   - [`t-exact-optional`](../../rules/t-exact-optional.md)
   - [`t-avoid-wrapper-types`](../../rules/t-avoid-wrapper-types.md)
   - [`t-no-empty-object-type`](../../rules/t-no-empty-object-type.md)
2. **Zero `any` & Declarations over Assertions**:
   - [`t-no-any`](../../rules/t-no-any.md)
   - [`t-declaration-over-assertion`](../../rules/t-declaration-over-assertion.md)
   - [`t-satisfies-operator`](../../rules/t-satisfies-operator.md)
   - [`t-encapsulate-assertions`](../../rules/t-encapsulate-assertions.md)
   - [`t-build-objects-at-once`](../../rules/t-build-objects-at-once.md)
3. **State Modeling & Valid States Only**:
   - [`t-discriminated-unions`](../../rules/t-discriminated-unions.md)
   - [`t-valid-states-only`](../../rules/t-valid-states-only.md)
   - [`t-exhaustiveness-check`](../../rules/t-exhaustiveness-check.md)
   - [`t-mapped-types-sync`](../../rules/t-mapped-types-sync.md)
4. **Type Narrowing, Grammars & Safe Spaces**:
   - [`t-type-predicates`](../../rules/t-type-predicates.md)
   - [`t-narrowing-in-operator`](../../rules/t-narrowing-in-operator.md)
   - [`t-object-iteration-safety`](../../rules/t-object-iteration-safety.md)
   - [`t-template-literal-types`](../../rules/t-template-literal-types.md)
   - [`t-separate-types-spaces`](../../rules/t-separate-types-spaces.md)
5. **Inference Hygiene, Generics & Schemas**:
   - [`t-avoid-redundant-annotations`](../../rules/t-avoid-redundant-annotations.md)
   - [`t-variable-type-stability`](../../rules/t-variable-type-stability.md)
   - [`t-const-assertions`](../../rules/t-const-assertions.md)
   - [`t-generics-constraints`](../../rules/t-generics-constraints.md)
   - [`t-generics-simplicity`](../../rules/t-generics-simplicity.md)
   - [`t-conditional-types-over-overloads`](../../rules/t-conditional-types-over-overloads.md)
   - [`t-index-signatures-dynamic`](../../rules/t-index-signatures-dynamic.md)

## Verification Procedure

When writing or verifying types:
1. Run `npx tsc --noEmit` to ensure zero compilation errors under strict mode.
2. Confirm that every union switch statement has a `default: assertNever(val)` branch.
3. Verify that any function accepting `unknown` narrows via custom predicate or schema before accessing properties.
4. Ensure no type assertions (`as Type`) bypass structural validation at declaration sites.
5. Use `satisfies` when validating object literal schemas to preserve specific literal types without widening.
