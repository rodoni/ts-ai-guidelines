---
name: vue-guidelines
description: >
  Optional Vue 3 engineering guidelines for Composition API, typed component contracts,
  composables, Pinia boundaries, and predictable reactive state.
license: MIT
metadata:
  version: "1.0.0"
  requires: [ts-guidelines]
---

# Vue Guidelines

Optional Vue 3 rules layered on top of the TypeScript core. Load this skill for Vue components; keep the framework-agnostic TypeScript rules enabled as the base contract.

## Rule Index

- [`vue-composition-api`](../../rules/vue-composition-api.md) - Prefer Composition API and `<script setup>`.
- [`vue-reactivity-boundaries`](../../rules/vue-reactivity-boundaries.md) - Keep refs, proxies, and plain values at explicit boundaries.
- [`vue-component-contracts`](../../rules/vue-component-contracts.md) - Type props and emitted events.
- [`vue-composables`](../../rules/vue-composables.md) - Keep composables cohesive and lifecycle-safe.
- [`vue-pinia-store-boundaries`](../../rules/vue-pinia-store-boundaries.md) - Keep stores focused on one domain aggregate.
- [`vue-pinia-async-actions`](../../rules/vue-pinia-async-actions.md) - Model async store state and stale responses explicitly.
- [`vue-computed-watch`](../../rules/vue-computed-watch.md) - Prefer computed values for derivation and watchers for side effects.
- [`vue-reactivity-unwrapping`](../../rules/vue-reactivity-unwrapping.md) - Preserve ref identity across composable boundaries.
- [`vue-provide-inject`](../../rules/vue-provide-inject.md) - Use typed injection keys and explicit provider ownership.
- [`vue-slots-expose`](../../rules/vue-slots-expose.md) - Type intentional slots and exposed component methods.
- [`vue-v-model`](../../rules/vue-v-model.md) - Keep two-way binding contracts typed and normalized.
- [`vue-accessibility`](../../rules/vue-accessibility.md) - Build semantic, keyboard-operable interactions.
- [`vue-security-html`](../../rules/vue-security-html.md) - Sanitize untrusted HTML and dynamic URLs.
- [`vue-performance-rendering`](../../rules/vue-performance-rendering.md) - Keep reactive graphs and list identities stable.
- [`vue-error-boundaries`](../../rules/vue-error-boundaries.md) - Expose typed recovery states for async and render failures.

## Required Core Skills

- [`ts-guidelines`](../ts-guidelines/SKILL.md)
- [`ts-types`](../ts-types/SKILL.md)
- [`ts-api`](../ts-api/SKILL.md)
- [`ts-resilience-app`](../ts-resilience-app/SKILL.md)
