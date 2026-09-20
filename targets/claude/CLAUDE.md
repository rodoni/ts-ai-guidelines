# TypeScript AI Guidelines Integration (Claude Code)

This project adopts the TypeScript AI Guidelines with a Curated Core of 57 atomic rules, specialized subagents, and modular skills.

## Core Mandates
1. **Strict Type Soundness**: Always enforce `strict: true` and zero `any` policy (`t-strict-mode`, `t-no-any`).
2. **Spec-First & Verification Gates**: Always plan with specifications and verify code using `npx tsc --noEmit` and tests (`wf-spec-first`, `wf-verification-gates`).
3. **Immutability & Safety**: Default to `readonly` data structures and runtime schema validation (`c-readonly-immutability`, `m-validate-inputs`).
4. **Exhaustive Review**: Code reviews follow the Zero Omission Policy using `ts-reviewer`.

## Guidelines Resources
- Rules catalog: `.claude/rules/*.md`
- Skills catalog: `.claude/skills/*/SKILL.md`
- Specialized agents: `.claude/agents/*.md`
