---
name: ts-perf
description: >
  Performance, memory optimization, and bundle size guidelines for TypeScript and JavaScript.
  Covers Map/Set usage, V8 hidden classes, dense arrays, tree-shaking, lazy imports,
  import type erasure, and RegExp reuse.
license: MIT
---

# TypeScript Performance & Memory Skill

Best practices for optimizing execution speed, memory footprint, and frontend bundle size in TypeScript codebases.

## Core Rules

1. **Collections & V8 Hidden Classes**:
   - [`perf-map-set`](../../rules/perf-map-set.md) - Use Map/Set for dynamic lookups
   - [`perf-sparse-arrays`](../../rules/perf-sparse-arrays.md) - Avoid holes and sparse collections
   - [`perf-hidden-classes`](../../rules/perf-hidden-classes.md) - Stable constructor property order
2. **Bundling & Module Pruning**:
   - [`perf-tree-shaking`](../../rules/perf-tree-shaking.md) - Avoid barrel files that defeat tree-shaking
   - [`perf-lazy-imports`](../../rules/perf-lazy-imports.md) - Dynamic imports for heavy non-critical dependencies
   - [`perf-type-imports`](../../rules/perf-type-imports.md) - `import type` for zero-cost compiled output
3. **Runtime Allocation Efficiency**:
   - [`perf-regex-reuse`](../../rules/perf-regex-reuse.md) - Precompile and reuse RegExp instances

## Verification Procedure

1. Verify that type-only imports use `import type { ... }`.
2. Inspect bundle output or bundle analyzer report to verify that unused dependencies are eliminated.
3. Check hot paths to ensure regular expressions are not instantiated inside loops or frequent handlers.
