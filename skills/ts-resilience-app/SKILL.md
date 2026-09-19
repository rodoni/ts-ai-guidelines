---
name: ts-resilience-app
description: >
  Enterprise resilience, runtime safety, and observability guidelines for TypeScript applications.
  Covers typed errors/Result patterns, schema input validation (Zod/Valibot), structured telemetry,
  preventing floating promises, mockable I/O, and JSDoc contracts.
license: MIT
---

# TypeScript Resilience & Applications Skill

Techniques for robust error handling, runtime boundary verification, structured telemetry, and testable application architecture.

## Core Rules

1. **Error Handling & Promises**:
   - [`m-app-error`](../../rules/m-app-error.md) - Typed errors or Result pattern
   - [`m-no-floating-promises`](../../rules/m-no-floating-promises.md) - Await or catch all Promises
2. **Boundary Validation & Observability**:
   - [`m-validate-inputs`](../../rules/m-validate-inputs.md) - Schema validation with Zod/Valibot at boundaries
   - [`m-log-not-print`](../../rules/m-log-not-print.md) - Structured logger instead of console.log
   - [`m-lint-override-expect`](../../rules/m-lint-override-expect.md) - Explicit inline linter overrides
3. **Architecture & Contracts**:
   - [`m-mockable-io`](../../rules/m-mockable-io.md) - Dependency injection for I/O operations
   - [`m-doc-contracts`](../../rules/m-doc-contracts.md) - JSDoc `@param`, `@returns`, `@throws`, `@example`

## Verification Procedure

1. Run ESLint rule `@typescript-eslint/no-floating-promises` to catch unhandled async operations.
2. Verify that all external HTTP, database, and env inputs pass through a validation schema.
3. Check that no `console.log` statements exist in core services or libraries.
