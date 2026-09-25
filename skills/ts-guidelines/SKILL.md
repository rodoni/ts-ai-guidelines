---
name: ts-guidelines
description: >
  Zero-overhead, low-context TypeScript engineering guidelines combining the Official TypeScript
  Handbook, Effective TypeScript (Dan Vanderkam, O'Reilly), and the Tweag Agentic Coding Handbook (Core Workflows).
  Contains prioritized rules for strict type safety, API ergonomics, performance, resilience, and agentic workflows.
license: MIT
metadata:
  version: "1.2.0"
  sources:
    - https://www.typescriptlang.org/docs/handbook/intro.html
    - https://effectivetypescript.com
    - https://tweag.github.io/agentic-coding-handbook/workflows/
---

# TypeScript Guidelines Master Hub

Ultra-concise, low-context engineering rules for AI coding agents and TypeScript developers. Prioritized by impact to prevent token waste and hallucinations.

## Quick Index by Priority

| Priority | Category | Prefix | Impact | Skill File |
|---|---|---|---|---|
| 1 | **Type Soundness & Strictness** | `t-` | CRITICAL | [ts-types](../ts-types/SKILL.md) |
| 2 | **API & Type Ergonomics** | `c-` | HIGH | [ts-api](../ts-api/SKILL.md) |
| 3 | **Apps, Resilience & Telemetry** | `m-` | HIGH | [ts-resilience-app](../ts-resilience-app/SKILL.md) |
| 4 | **Agentic Workflows (Tweag)** | `wf-` | HIGH | [ts-agentic-workflow](../ts-agentic-workflow/SKILL.md) |
| 5 | **Testing & Verification** | `test-` | HIGH | [ts-testing](../ts-testing/SKILL.md) |
| 6 | **Performance, Memory & Bundle** | `perf-` | MEDIUM | [ts-perf](../ts-perf/SKILL.md) |

---

## All Rules Index (Load rules on-demand)

### 1. Type Soundness & Strictness (CRITICAL)
- [`t-strict-mode`](../../rules/t-strict-mode.md) - Always enable `strict: true` and all strict family compiler flags.
- [`t-no-any`](../../rules/t-no-any.md) - Never use `any`; use `unknown` for unchecked values and narrow before usage.
- [`t-declaration-over-assertion`](../../rules/t-declaration-over-assertion.md) - Prefer type declarations (`const x: T = ...`) over type assertions (`as T`).
- [`t-satisfies-operator`](../../rules/t-satisfies-operator.md) - Use `satisfies` to validate contracts without widening inferred literal types.
- [`t-no-empty-object-type`](../../rules/t-no-empty-object-type.md) - Avoid `{}` and `Function`; use `Record<string, never>`, `object`, or typed callables.
- [`t-avoid-redundant-annotations`](../../rules/t-avoid-redundant-annotations.md) - Avoid cluttering code with inferable local types; annotate public boundaries.
- [`t-variable-type-stability`](../../rules/t-variable-type-stability.md) - Use distinct variables for different types; never reassign variables to conflicting types.
- [`t-discriminated-unions`](../../rules/t-discriminated-unions.md) - Model polymorphic states using discriminated unions with a common literal tag.
- [`t-valid-states-only`](../../rules/t-valid-states-only.md) - Design types such that illegal states are unrepresentable; push null to the perimeter.
- [`t-exhaustiveness-check`](../../rules/t-exhaustiveness-check.md) - Enforce compile-time exhaustiveness checking on union branches with `never`.
- [`t-type-predicates`](../../rules/t-type-predicates.md) - Implement custom type predicates (`value is Type`) with rigorous runtime checks.
- [`t-narrowing-in-operator`](../../rules/t-narrowing-in-operator.md) - Use `typeof`, `instanceof`, and `'prop' in obj` operators for safe structural narrowing.
- [`t-mapped-types-sync`](../../rules/t-mapped-types-sync.md) - Use mapped types (`[K in keyof T]`) to keep consumer logic synchronized with domain types.
- [`t-template-literal-types`](../../rules/t-template-literal-types.md) - Use template literal types (`${Entity}:${Action}`) to enforce string grammar patterns.
- [`t-encapsulate-assertions`](../../rules/t-encapsulate-assertions.md) - Encapsulate unavoidable type assertions inside well-typed utility functions.
- [`t-object-iteration-safety`](../../rules/t-object-iteration-safety.md) - Acknowledge structural typing in object iteration; avoid unsafe `Object.keys(obj) as (keyof T)[]`.
- [`t-separate-types-spaces`](../../rules/t-separate-types-spaces.md) - Keep the distinction between type space and value space explicit and unambiguous.
- [`t-conditional-types-over-overloads`](../../rules/t-conditional-types-over-overloads.md) - Prefer conditional types over repetitive function overloads.
- [`t-avoid-wrapper-types`](../../rules/t-avoid-wrapper-types.md) - Always use lowercase primitives (`string`, `number`) and never object wrappers (`String`, `Number`).
- [`t-index-signatures-dynamic`](../../rules/t-index-signatures-dynamic.md) - Restrict index signatures strictly to dynamic maps; use explicit shapes for known schemas.
- [`t-build-objects-at-once`](../../rules/t-build-objects-at-once.md) - Build objects all at once with literals or spread rather than mutating `{} as T`.
- [`t-exact-optional`](../../rules/t-exact-optional.md) - Distinguish omitted optional properties from explicit `undefined` values.
- [`t-const-assertions`](../../rules/t-const-assertions.md) - Use `as const` on literal objects, arrays, and tuples to preserve literal types.
- [`t-generics-constraints`](../../rules/t-generics-constraints.md) - Constrain generic type parameters (`T extends Base`) rather than unbounded generics.
- [`t-generics-simplicity`](../../rules/t-generics-simplicity.md) - Avoid generic over-engineering; prefer concrete types where inference suffices.

### 2. API & Type Ergonomics (HIGH)
- [`c-interface-vs-type`](../../rules/c-interface-vs-type.md) - Prefer `interface` for extensible object contracts; prefer `type` for unions/primitives.
- [`c-readonly-immutability`](../../rules/c-readonly-immutability.md) - Mark object properties and arrays as `readonly` to prevent state mutations.
- [`c-robustness-principle`](../../rules/c-robustness-principle.md) - Be liberal in what parameters you accept, and strict in what return types you produce.
- [`c-branded-types`](../../rules/c-branded-types.md) - Use Branded Types (nominal typing) to prevent primitive obsession and argument swapping.
- [`c-return-annotations`](../../rules/c-return-annotations.md) - Always explicitly annotate function return types on exported module boundaries.
- [`c-avoid-enums`](../../rules/c-avoid-enums.md) - Prefer union of string literals or `as const` objects over TypeScript `enum`.
- [`c-custom-type`](../../rules/c-custom-type.md) - Convey domain intent through dedicated domain types and literal unions rather than booleans.
- [`c-naming-conventions`](../../rules/c-naming-conventions.md) - Follow idiomatic TypeScript casing conventions strictly across all identifiers.
- [`c-builder-pattern`](../../rules/c-builder-pattern.md) - Use the Builder pattern with validation for complex or incrementally configured objects.
- [`c-weasel-words`](../../rules/c-weasel-words.md) - Eliminate vague weasel words (`Helper`, `Manager`, `Data`, `Info`, `Util`) from names.
- [`c-dont-leak-internals`](../../rules/c-dont-leak-internals.md) - Encapsulate internal library dependencies and types; export only intentional API surfaces.
- [`c-private-fields-hash`](../../rules/c-private-fields-hash.md) - Use ECMAScript `#field` syntax for genuine runtime privacy and encapsulation.

### 3. Performance, Memory & Bundle (MEDIUM)
- [`perf-map-set`](../../rules/perf-map-set.md) - Use `Map` and `Set` for frequent lookups, insertions, and membership tests over plain objects.
- [`perf-sparse-arrays`](../../rules/perf-sparse-arrays.md) - Avoid sparse arrays and frequent size mutations that degrade V8 array optimizations.
- [`perf-hidden-classes`](../../rules/perf-hidden-classes.md) - Initialize all object properties in constructors or factories in consistent order.
- [`perf-tree-shaking`](../../rules/perf-tree-shaking.md) - Use pure ESM syntax and avoid monolithic barrel files that defeat tree-shaking.
- [`perf-lazy-imports`](../../rules/perf-lazy-imports.md) - Use dynamic imports (`await import(...)`) to load non-critical modules on demand.
- [`perf-type-imports`](../../rules/perf-type-imports.md) - Always use explicit `import type` and `export type` for type-only declarations.
- [`perf-regex-reuse`](../../rules/perf-regex-reuse.md) - Declare and compile regular expressions outside of functions and loops.

### 4. Apps, Resilience & Telemetry (HIGH)
- [`m-app-error`](../../rules/m-app-error.md) - Return strongly typed error unions (`Result<T, E>`) or throw custom typed `Error` subclasses.
- [`m-validate-inputs`](../../rules/m-validate-inputs.md) - Validate external inputs, request bodies, and environment variables at runtime with schemas.
- [`m-log-not-print`](../../rules/m-log-not-print.md) - Use structured telemetry and loggers; never use raw `console.log` in production services.
- [`m-no-floating-promises`](../../rules/m-no-floating-promises.md) - Always `await`, return, or explicitly handle Promises; never allow floating unhandled Promises.
- [`m-lint-override-expect`](../../rules/m-lint-override-expect.md) - Use inline linter suppressions with explicit rationale comments.
- [`m-mockable-io`](../../rules/m-mockable-io.md) - Decouple core domain logic from external I/O using interfaces or dependency injection.
- [`m-doc-contracts`](../../rules/m-doc-contracts.md) - Document public functions with structured JSDoc containing `@param`, `@returns`, and `@throws`.

### 5. Agentic Workflows - Tweag (HIGH)
- [`wf-spec-first`](../../rules/wf-spec-first.md) - Always draft and review a technical specification and task decomposition before writing code.
- [`wf-tdd-loop`](../../rules/wf-tdd-loop.md) - Develop guided by tests (TDD): write automated tests before implementing feature logic.
- [`wf-verification-gates`](../../rules/wf-verification-gates.md) - Never advance an agentic coding task without passing deterministic feedback gates.
- [`wf-writer-reviewer`](../../rules/wf-writer-reviewer.md) - Separate the creative coding persona from the critical compliance reviewer persona.
- [`wf-design-for-ai`](../../rules/wf-design-for-ai.md) - Design TypeScript APIs, types, and modules for AI comprehension.
- [`wf-atomic-steps`](../../rules/wf-atomic-steps.md) - Decompose complex development tasks into small, incremental, verifiable steps.

### 6. Testing & Invariants (HIGH)
- [`test-property-based`](../../rules/test-property-based.md) - Use property-based testing (`fast-check`) for pure functions, codecs, and invariants.
- [`test-assert-error-variants`](../../rules/test-assert-error-variants.md) - Assert specific error classes and discriminated payloads; avoid blind `toThrow()`.
- [`test-deterministic-no-sleep`](../../rules/test-deterministic-no-sleep.md) - Eliminate wall-clock sleeps (`setTimeout`); use virtual timers (`vi.useFakeTimers()`).
- [`test-fakes-over-heavy-mocks`](../../rules/test-fakes-over-heavy-mocks.md) - Favor in-memory fakes and interfaces over complex dynamic mock monkeypatching.
- [`test-behavior-not-internals`](../../rules/test-behavior-not-internals.md) - Test observable module contracts and domain invariants, not private helper functions.
- [`test-snapshot-for-complex-data`](../../rules/test-snapshot-for-complex-data.md) - Use snapshot testing (`toMatchSnapshot()`) for complex ASTs, schemas, and serialized outputs.

### 7. Optional Vue Layer
- [`vue-composition-api`](../../rules/vue-composition-api.md) - Prefer Composition API and `<script setup>` for cohesive logic.
- [`vue-reactivity-boundaries`](../../rules/vue-reactivity-boundaries.md) - Keep refs, proxies, and plain values at explicit boundaries.
- [`vue-component-contracts`](../../rules/vue-component-contracts.md) - Type props and emitted events at component boundaries.
- [`vue-composables`](../../rules/vue-composables.md) - Keep composables cohesive and lifecycle-safe.
- [`vue-pinia-store-boundaries`](../../rules/vue-pinia-store-boundaries.md) - Keep Pinia stores focused on one domain aggregate.
- [`vue-pinia-async-actions`](../../rules/vue-pinia-async-actions.md) - Model async store state and stale responses explicitly.
- [`vue-test-utils-behavior`](../../rules/vue-test-utils-behavior.md) - Test rendered behavior and public component contracts.
- [`vue-test-utils-async`](../../rules/vue-test-utils-async.md) - Synchronize Vue tests without wall-clock sleeps.
- [`vue-computed-watch`](../../rules/vue-computed-watch.md) - Prefer computed values for derivation and watchers for side effects.
- [`vue-reactivity-unwrapping`](../../rules/vue-reactivity-unwrapping.md) - Preserve ref identity across composable boundaries.
- [`vue-provide-inject`](../../rules/vue-provide-inject.md) - Use typed injection keys and explicit provider ownership.
- [`vue-slots-expose`](../../rules/vue-slots-expose.md) - Type intentional slots and exposed component methods.
- [`vue-v-model`](../../rules/vue-v-model.md) - Keep two-way binding contracts typed and normalized.
- [`vue-accessibility`](../../rules/vue-accessibility.md) - Build semantic, keyboard-operable interactions.
- [`vue-security-html`](../../rules/vue-security-html.md) - Sanitize untrusted HTML and dynamic URLs.
- [`vue-performance-rendering`](../../rules/vue-performance-rendering.md) - Keep reactive graphs and list identities stable.
- [`vue-error-boundaries`](../../rules/vue-error-boundaries.md) - Expose typed recovery states for async and render failures.
- [`vue-test-utils-pinia`](../../rules/vue-test-utils-pinia.md) - Install isolated testing Pinia instances.
- [`vue-test-utils-accessibility`](../../rules/vue-test-utils-accessibility.md) - Prefer accessibility-oriented component queries.
- [`vue-composable-testing`](../../rules/vue-composable-testing.md) - Test lifecycle-bound composables with injected fakes.
- [`pinia-store-design`](../../rules/pinia-store-design.md) - Align stores with domain aggregates.
- [`pinia-getters-pure`](../../rules/pinia-getters-pure.md) - Keep getters pure and side-effect free.
- [`pinia-persistence`](../../rules/pinia-persistence.md) - Persist only validated, versioned state subsets.
- [`pinia-dependencies`](../../rules/pinia-dependencies.md) - Inject infrastructure into stores.
- [`pinia-testing`](../../rules/pinia-testing.md) - Isolate stores and test public behavior.
