# wf-spec-first

> Always draft and review a technical specification and task decomposition before writing code.

## Why It Matters
Jumping straight into code generation ("vibe coding") without an agreed specification causes AI agents to make unverified architectural assumptions, invent conflicting APIs, and produce incomplete implementations requiring costly rewrites.

> **Applicability Scope**: Any non-trivial feature, refactoring, architecture change, or multi-step agentic pair programming task.

## Bad
```typescript
// Prompt: "Create a rate limiter middleware for our API right now"
// Agent immediately writes 200 lines of uncoordinated code without agreeing on:
// - Storage engine (Redis vs memory)
// - Sliding window vs token bucket algorithm
// - Response headers (X-RateLimit-*)
// - Unit test strategy
```

## Good
```markdown
<!-- Plan First: Specifying Architecture & Invariants -->
### Rate Limiter Specification
1. **Algorithm**: Token Bucket with 100 requests per minute burst limit.
2. **Storage**: Generic `RateLimitStore` interface; memory-backed for dev, Redis for prod.
3. **HTTP Contract**: Emits `429 Too Many Requests` with standard `Retry-After` header.
4. **Verification Gates**:
   - Unit tests covering token replenishment.
   - Concurrency tests for race conditions.
   - Strict TypeScript compile check (`tsc --noEmit`).
```

## See Also
- [wf-tdd-loop](wf-tdd-loop.md) - Test-driven development loop
- [wf-verification-gates](wf-verification-gates.md) - Deterministic verification gates
