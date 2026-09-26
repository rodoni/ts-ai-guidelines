# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.0] - 2026-09-25

### Fixed
- **Rules Technical Audit**: Corrected 8 technical and conceptual inaccuracies across atomic rules when compared against authoritative sources (*Official TypeScript Handbook*, *Effective TypeScript*, *V8 Engine*, *Vue 3*, *Pinia*, and *Vue Test Utils*):
  - `t-avoid-wrapper-types`: Corrected assignment compatibility (primitives are assignable to wrappers, wrappers cannot be assigned to primitives) and documented runtime wrapper traps (`new Boolean(false)` being truthy, `typeof new String()` returning `"object"`).
  - `t-encapsulate-assertions`: Refactored example to properly encapsulate unavoidable internal assertions (`as T`) inside reusable generic functions (`createCache<T>`, `memoize`) per *Effective TypeScript* (Item 40).
  - `t-variable-type-stability`: Removed inaccurate reference attributing primitive local variable mutations to V8 hidden classes (which apply to object shapes), clarifying focus on compiler narrowing stability.
  - `c-avoid-enums`: Updated bad example and rationale to emphasize structural typing breakdown with string enums, runtime IIFEs, and tree-shaking impairments.
  - `t-no-any`: Replaced brittle assertion chains with structural runtime narrowing and custom type guards (`isRecord`).
  - `pinia-dependencies`: Replaced store factory recreation with Vue `inject(UserGatewayKey)` pattern to avoid Pinia store singleton cache collisions.
  - `perf-regex-reuse`: Documented mutable `lastIndex` pitfalls on regular expressions with global (`/g`) or sticky (`/y`) flags when cached globally.
  - `vue-test-utils-async`: Eliminated redundant `nextTick()` after `flushPromises()`, clarifying that `trigger()` already awaits `nextTick()`.

## [1.2.0] - 2026-09-24

### Added
- **Vue 3 & Pinia Guidelines**: Introduced 25 optional atomic rules covering Composition API, reactivity boundaries, component contracts, composables, accessibility, security, rendering performance, and Pinia store boundaries.
- **Specialized Agents**: Added 4 new agent personas: `vue-architect`, `vue-test-engineer`, `pinia-architect`, and `pinia-test-engineer`.
- **Skills Expansion**: Added 4 new modular skills: `vue-guidelines`, `vue-testing`, `pinia-guidelines`, and `pinia-testing`.

### Fixed
- **Kilo Code Integration**: Updated Kilo Code target configuration to correctly load project rules as instructions in `kilo.jsonc`.

## [1.1.0] - 2026-09-21

### Added
- **Testing Engineering Suite**: Added `ts-test-engineer` specialized agent and `ts-testing` modular skill.
- **Testing Atomic Rules**: Added 6 testing rules: `test-property-based`, `test-assert-error-variants`, `test-deterministic-no-sleep`, `test-fakes-over-heavy-mocks`, `test-behavior-not-internals`, and `test-snapshot-for-complex-data`.
- Expanded catalog to 63 atomic rules with comprehensive testing matrix.

## [1.0.0] - 2026-09-20

### Added
- Expanded rule catalog to 57 atomic rules, including `t-satisfies-operator`, `t-no-empty-object-type`, `t-avoid-redundant-annotations`, `t-variable-type-stability`, `c-robustness-principle` (Postel's Law), `t-template-literal-types`, and `t-encapsulate-assertions`.
- Adopted *Effective TypeScript* (Dan Vanderkam) and *TypeScript Official Handbook* as primary authorities.
- Added 10 core type system rules covering type declarations, state modeling, mapped types, private fields, and iteration safety.
- Formulated Tweag Agentic Coding workflow methodology (Spec-First, TDD loop, Verification Gates, Writer/Reviewer pattern).

### Changed
- Streamlined rule documentation structure by integrating applicability context directly into "Why It Matters" sections.

### Fixed
- Consistency alignment across examples and verification suite link checkers.

## [0.1.0] - 2026-09-19

### Added
- Initial release of TypeScript AI Guidelines & Agentic Tools ecosystem.
- 40 atomic rules across type systems, API ergonomics, performance, and resilience.
- 5 specialized subagents: `ts-lead`, `ts-type-architect`, `ts-perf-optimizer`, `ts-safety-auditor`, `ts-reviewer`.
- Multi-target deployment script (`sync.sh`) supporting Antigravity, OpenCode, Kilo Code, Cursor, Claude Code, and GitHub Copilot.
- Automated verification test suite (`scripts/verify.py`).
