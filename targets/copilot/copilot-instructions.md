# GitHub Copilot TypeScript Guidelines

Follow these core TypeScript development and review mandates:

## 1. Type Soundness & Compiler Rigor
- Enforce `strict: true` in `tsconfig.json`. Never use the `any` type (`t-strict-mode`, `t-no-any`).
- Model state variants using discriminated unions and assert exhaustiveness with `never` (`t-discriminated-unions`, `t-exhaustiveness-check`).
- Use structural narrowing (`in`, `typeof`, `instanceof`) and type predicates (`t-type-predicates`, `t-narrowing-in-operator`).

## 2. API Ergonomics & Contracts
- Mark properties and collections `readonly` to prevent side effects (`c-readonly-immutability`).
- Use Branded Types to prevent ID swapping and primitive obsession (`c-branded-types`).
- Explicitly annotate return types on all exported module functions (`c-return-annotations`).
- Prefer string literal unions or `as const` maps over TypeScript `enum` (`c-avoid-enums`).

## 3. Resilience & Runtime Safety
- Validate all network inputs, params, and env vars at runtime boundaries with schemas (`m-validate-inputs`).
- Always await or catch Promises; no unhandled floating Promises (`m-no-floating-promises`).
- Throw typed custom `Error` classes or return `Result<T, E>` unions; never throw plain strings (`m-app-error`).
- Use structured telemetry loggers; never use raw `console.log` in production (`m-log-not-print`).

## 4. Agentic Workflow (Tweag)
- Plan with specifications before writing code (`wf-spec-first`).
- Execute deterministic verification gates (`npx tsc --noEmit`, linters, tests) between editing steps (`wf-verification-gates`).

## 5. Optional Vue 3 Layer
- When working with Vue, load `vue-guidelines` and `vue-testing` in addition to the TypeScript core.
- Use typed Composition API contracts, cohesive composables, focused Pinia stores, and behavior-focused Vue Test Utils tests (`vue-component-contracts`, `vue-composables`, `vue-pinia-store-boundaries`, `vue-test-utils-behavior`).
- When application state crosses component boundaries, also load `pinia-guidelines` and `pinia-testing`; isolate stores and inject infrastructure dependencies (`pinia-store-design`, `pinia-dependencies`, `pinia-testing`).
