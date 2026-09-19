# perf-type-imports

> Always use explicit `import type` and `export type` for type-only declarations.

## Why It Matters
Standard `import` statements can trick bundlers into retaining empty runtime module stubs, trigger circular dependency issues, and prevent isolated transpile tools (such as esbuild or SWC) from cleanly erasing types.

> **Applicability Scope**: Universal across all TypeScript files that import types, interfaces, or type-only aliases.

## Bad
```typescript
// Bundler cannot immediately know if User is a runtime class or a compile-time type
import { User, calculateScore } from "./user.js";

export function process(u: User): number {
  return calculateScore(u);
}
```

## Good
```typescript
// Explicit type import guarantees complete erasure in the compiled output
import type { User } from "./user.js";
import { calculateScore } from "./user.js";

export function process(u: User): number {
  return calculateScore(u);
}
```

## See Also
- [perf-tree-shaking](perf-tree-shaking.md) - Clean module pruning
- [c-interface-vs-type](c-interface-vs-type.md) - Structuring types
