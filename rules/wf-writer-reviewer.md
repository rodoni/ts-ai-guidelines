# wf-writer-reviewer

> Separate the creative coding persona from the critical compliance reviewer persona to eliminate confirmation bias.

## Why It Matters
When the same agent session generates code and immediately reviews its own work, confirmation bias causes it to overlook subtle edge cases, missed contracts, or rule violations that it just authored.

> **Applicability Scope**: Code audits, pull request reviews, compliance checking, and complex multi-agent collaborative workflows.

## Bad
```markdown
<!-- Single session doing self-review -->
Agent: "I have reviewed my own code. It looks clean, well-typed, and adheres to all best practices."
(Missed: unhandled Promise rejection, lack of branded type, missing exhaustive switch).
```

## Good
```markdown
<!-- Writer/Reviewer Pattern -->
1. **Writer Agent (`ts-type-architect` / `ts-coder`)**: Implements code based on the spec and verifies passing tests.
2. **Reviewer Agent (`ts-reviewer`)**: Fresh session loaded strictly with the review checklist, Zero Omissions Policy, and no vested interest in the draft. It catalogs all violations with remediation diffs.
```

## See Also
- [wf-spec-first](wf-spec-first.md) - Spec-first development
- [wf-verification-gates](wf-verification-gates.md) - Gate-driven verification
