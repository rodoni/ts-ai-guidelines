# wf-design-for-ai

> Design TypeScript APIs, types, and modules for AI comprehension: explicit types, pure functions, and testable contracts.

## Why It Matters
AI coding assistants excel when code follows explicit idioms, uses clear types, and contains runnable examples. Obscure metaprogramming, complex dynamic monkey-patching, and implicit parameters drastically increase AI hallucinations.

> **Applicability Scope**: Universal across codebases where AI coding agents (Antigravity, Cursor, Claude Code, Copilot) are utilized for development and maintenance.

## Bad
```typescript
// Dynamic reflection and implicit context confuse AI coding models
export function buildProxyHandler(config: any) {
  return new Proxy({}, {
    get(target, prop) {
      // Dynamic black magic makes it impossible for AI to infer types or valid properties
      return config[prop] ?? globalThis[prop as any];
    }
  });
}
```

## Good
```typescript
// Explicit, typed, self-documenting interface that AI models parse flawlessly
export interface ServiceRegistry {
  readonly databaseUrl: string;
  readonly port: number;
}

export function createServiceRegistry(env: Record<string, string | undefined>): ServiceRegistry {
  const databaseUrl = env.DATABASE_URL;
  if (!databaseUrl) {
    throw new Error("Missing DATABASE_URL");
  }
  return {
    databaseUrl,
    port: Number(env.PORT ?? "3000"),
  };
}
```

## See Also
- [c-branded-types](c-branded-types.md) - Nominal types for clarity
- [m-doc-contracts](m-doc-contracts.md) - Document contracts with JSDoc
