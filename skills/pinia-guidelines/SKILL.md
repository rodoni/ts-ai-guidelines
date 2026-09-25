---
name: pinia-guidelines
description: >
  Optional Pinia engineering guidelines for focused stores, pure getters, explicit dependencies,
  validated persistence, and predictable asynchronous state.
license: MIT
metadata:
  version: "1.0.0"
  requires: [ts-guidelines, vue-guidelines]
---

# Pinia Guidelines

Optional Pinia rules layered on top of the TypeScript and Vue core skills. Load this skill when application state crosses component boundaries.

## Rule Index

- [`pinia-store-design`](../../rules/pinia-store-design.md) - Align stores with domain aggregates.
- [`pinia-getters-pure`](../../rules/pinia-getters-pure.md) - Keep getters pure and side-effect free.
- [`pinia-persistence`](../../rules/pinia-persistence.md) - Persist only validated, versioned state subsets.
- [`pinia-dependencies`](../../rules/pinia-dependencies.md) - Inject infrastructure into stores.
- [`pinia-testing`](../../rules/pinia-testing.md) - Isolate stores and test public behavior.

## Required Core Skills

- [`ts-guidelines`](../ts-guidelines/SKILL.md)
- [`ts-types`](../ts-types/SKILL.md)
- [`ts-resilience-app`](../ts-resilience-app/SKILL.md)
- [`vue-guidelines`](../vue-guidelines/SKILL.md)
