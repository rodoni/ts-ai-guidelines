# wf-verification-gates

> Never advance an agentic coding task without passing deterministic feedback gates (`tsc --noEmit`, ESLint, tests).

## Why It Matters
AI agents can easily generate hallucinated methods, broken imports, or subtle syntax errors that sound plausible in chat. Without running deterministic CLI commands between iterations, errors compound and corrupt the entire project.

> **Applicability Scope**: Mandatory verification step between every code generation phase before concluding agent turns or submitting code.

## Bad
```bash
# Agent claims task is done without verifying:
# "I have created the module and updated all files. Everything should work properly!"
# Reality: Syntax error on line 42, broken import on line 3.
```

## Good
```bash
# Deterministic verification gate execution before declaring completion:
npx tsc --noEmit           # Gate 1: Type check must exit with 0 errors
npx eslint . --max-warnings=0 # Gate 2: Lint rules strictly satisfied
npm test                   # Gate 3: Unit and integration tests passing 100%
```

## See Also
- [t-strict-mode](t-strict-mode.md) - Strict compiler checks
- [wf-tdd-loop](wf-tdd-loop.md) - Test-driven development
