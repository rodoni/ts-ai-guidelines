---
name: ts-agentic-workflow
description: >
  Agentic coding workflows derived from the Tweag Agentic Coding Handbook.
  Covers Spec-First design, Test-Driven Development loops, deterministic verification gates,
  the Writer/Reviewer pattern, designing for AI comprehension, and atomic step decomposition.
license: MIT
---

# TypeScript Agentic Workflow Skill (Tweag Methodology)

Best practices for working effectively, predictably, and responsibly with AI coding agents in TypeScript projects.

## Core Rules

1. **Planning & Specification**:
   - [`wf-spec-first`](../../rules/wf-spec-first.md) - Plan before coding; establish data models and contracts
   - [`wf-atomic-steps`](../../rules/wf-atomic-steps.md) - Decompose complex tasks into verifiable increments
2. **Deterministic Feedback Loop**:
   - [`wf-tdd-loop`](../../rules/wf-tdd-loop.md) - Write tests before or alongside implementation
   - [`wf-verification-gates`](../../rules/wf-verification-gates.md) - Run `tsc --noEmit`, linters, and tests between steps
3. **Cognitive Separation & AI Design**:
   - [`wf-writer-reviewer`](../../rules/wf-writer-reviewer.md) - Separate authoring agent from reviewing agent
   - [`wf-design-for-ai`](../../rules/wf-design-for-ai.md) - Write explicit, self-documenting code that AI handles reliably

## Standard Agentic Execution Cycle

```
[1. Spec-First Plan] ➔ [2. TDD Test Specification] ➔ [3. Atomic Implementation]
        ▲                                                      │
        │                                                      ▼
[6. Writer/Reviewer Audit] ◄── [5. Verification Gates] ◄── [4. Typecheck & Lint]
```

## Verification Procedure

1. Before starting code generation, verify that a clear specification document exists.
2. After editing TypeScript files, execute `npx tsc --noEmit` synchronously.
3. Delegate the final review to `ts-reviewer` to run the multi-pass compliance audit.
