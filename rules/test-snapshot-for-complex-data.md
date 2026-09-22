# test-snapshot-for-complex-data

> Use snapshot testing (`toMatchSnapshot()`) for complex nested ASTs, schemas, and serialized outputs.

## Why It Matters
Manually handcrafting dozens of assertions across deep hierarchical structures (such as parser ASTs, generated SQL queries, compiler diagnostic trees, or large JSON payloads) creates noisy tests and immense maintenance burden. Snapshot testing records the complete serialized data structure, turning unintended mutations into clear, reviewable git diffs.

## Bad
```typescript
import { it, expect } from "vitest";
import { parseSqlQuery } from "./parser.js";

it("parses complex SQL query", () => {
  const ast = parseSqlQuery("SELECT id, name FROM users WHERE active = true");

  // BAD: Tedious, error-prone manual assertions over deep nested properties
  expect(ast.projections).toHaveLength(2);
  expect(ast.projections[0].column).toBe("id");
  expect(ast.projections[1].column).toBe("name");
  expect(ast.whereClause.condition.left).toBe("active");
  // 30+ more brittle field assertions...
});
```

## Good
```typescript
import { it, expect } from "vitest";
import { parseSqlQuery } from "./parser.js";

it("parses complex SQL query into expected AST snapshot", () => {
  const ast = parseSqlQuery("SELECT id, name FROM users WHERE active = true");

  // GOOD: Concise, deterministic structural snapshot captured in reviewable format
  expect(ast).toMatchSnapshot();
});
```

## See Also
- [test-behavior-not-internals](test-behavior-not-internals.md) - Focus on public contracts
- [wf-verification-gates](wf-verification-gates.md) - Deterministic regression gates
