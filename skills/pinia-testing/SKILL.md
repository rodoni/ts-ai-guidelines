---
name: pinia-testing
description: >
  Optional Pinia testing guidelines for isolated stores, realistic component providers,
  deterministic actions, and behavior-focused state assertions.
license: MIT
metadata:
  version: "1.0.0"
  requires: [ts-testing, vue-testing, pinia-guidelines]
---

# Pinia Testing

Optional testing rules for Pinia stores and Vue components that consume them. Use fresh Pinia instances, injected fakes, and public state contracts.

## Rule Index

- [`pinia-testing`](../../rules/pinia-testing.md) - Isolate stores and assert actions and getters.
- [`vue-test-utils-pinia`](../../rules/vue-test-utils-pinia.md) - Install testing Pinia per component test.
- [`vue-composable-testing`](../../rules/vue-composable-testing.md) - Test lifecycle-bound composables with fakes.

## Required Core Skills

- [`ts-testing`](../ts-testing/SKILL.md)
- [`ts-agentic-workflow`](../ts-agentic-workflow/SKILL.md)
- [`vue-testing`](../vue-testing/SKILL.md)
- [`pinia-guidelines`](../pinia-guidelines/SKILL.md)
