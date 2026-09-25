---
name: vue-testing
description: >
  Optional Vue Test Utils testing guidelines for behavior-focused component tests,
  Pinia integration, deterministic async updates, and accessible contracts.
license: MIT
metadata:
  version: "1.0.0"
  requires: [ts-testing, vue-guidelines]
---

# Vue Testing

Optional testing rules for Vue 3 components, composables, and Pinia stores. Use Vitest and Vue Test Utils at the integration boundary while reusing the TypeScript testing contracts underneath.

## Rule Index

- [`vue-test-utils-behavior`](../../rules/vue-test-utils-behavior.md) - Assert rendered behavior, events, and public contracts.
- [`vue-test-utils-async`](../../rules/vue-test-utils-async.md) - Synchronize with Vue's scheduler without wall-clock sleeps.
- [`vue-test-utils-pinia`](../../rules/vue-test-utils-pinia.md) - Install isolated testing Pinia instances.
- [`vue-test-utils-accessibility`](../../rules/vue-test-utils-accessibility.md) - Prefer accessibility-oriented component queries.
- [`vue-composable-testing`](../../rules/vue-composable-testing.md) - Test lifecycle-bound composables with injected fakes.

## Required Core Skills

- [`ts-testing`](../ts-testing/SKILL.md)
- [`ts-agentic-workflow`](../ts-agentic-workflow/SKILL.md)
- [`ts-types`](../ts-types/SKILL.md)
- [`vue-guidelines`](../vue-guidelines/SKILL.md)
