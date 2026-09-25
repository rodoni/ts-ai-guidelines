# Antigravity TypeScript Guidelines Integration

This file configures the specialized TypeScript Agentic ecosystem for Google Antigravity.

## Registered Subagents (`.agents/agents/`)
- **`ts-lead`**: Orchestration and architecture planner.
- **`ts-type-architect`**: Strict type soundness, discriminated unions, and generics.
- **`ts-perf-optimizer`**: V8 hidden classes, tree-shaking, and memory optimization.
- **`ts-safety-auditor`**: Schema validation (Zod/Valibot), defensive errors, and security.
- **`ts-reviewer`**: Exhaustive compliance, zero omission policy, and contract review.
- **`ts-test-engineer`**: High-confidence deterministic testing, fast-check, and TDD loop.
- **`vue-architect`**: Vue 3 Composition API, component contracts, composables, and Pinia boundaries.
- **`vue-test-engineer`**: Vue Test Utils, component behavior, Pinia tests, and deterministic async testing.
- **`pinia-architect`**: Pinia store boundaries, persistence, dependencies, and async state.
- **`pinia-test-engineer`**: Isolated Pinia store tests and Vue component integration.

## Available Skills (`.agents/skills/`)
The skills are located under `.agents/skills/`:
- `ts-guidelines`: Master rule index
- `ts-types`: Soundness & type systems
- `ts-api`: API ergonomics & naming
- `ts-perf`: Performance & bundle layout
- `ts-resilience-app`: Error handling, validation & telemetry
- `ts-agentic-workflow`: Tweag methodology (Spec-First, TDD, Verification Gates)
- `ts-testing`: Testing standards, deterministic execution & invariants
- `vue-guidelines`: Optional Vue 3 architecture and Pinia boundaries
- `vue-testing`: Optional Vue Test Utils and component testing standards
- `pinia-guidelines`: Optional Pinia architecture and state management rules
- `pinia-testing`: Optional Pinia store and component integration testing standards
