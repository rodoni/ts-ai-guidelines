# perf-tree-shaking

> Use pure ECMAScript Module (ESM) syntax and avoid monolithic barrel files (`index.ts`) that defeat tree-shaking.

## Why It Matters
Giant barrel files re-exporting everything from a library prevent modern bundlers from discarding unused code. Critical for frontend bundles and published npm packages to minimize download and startup overhead.

## Bad
```typescript
// Monolithic barrel file re-exports heavy dependencies together
// index.ts:
export * from "./heavy-chart-generator.js";
export * from "./simple-string-utils.js";

// App consumer importing one utility pulls the entire chart generator into the bundle!
import { simpleStringUtils } from "./index.js";
```

## Good
```typescript
// Direct deep path imports allow bundlers to eliminate unused code
import { simpleStringUtils } from "./utils/simple-string-utils.js";

// Or export specific cohesive entry points with sideEffects: false in package.json
```

## See Also
- [perf-lazy-imports](perf-lazy-imports.md) - Dynamic imports for heavy code
- [perf-type-imports](perf-type-imports.md) - Eliminate unused runtime types
