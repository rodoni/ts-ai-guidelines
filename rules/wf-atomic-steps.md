# wf-atomic-steps

> Decompose complex development tasks into small, incremental, and independently verifiable steps.

## Why It Matters
Attempting to generate an entire multi-file system in a single massive prompt exhausts context limits, introduces compounding errors across files, and makes debugging failures nearly impossible.

## Bad
```markdown
<!-- Monolithic Prompt: -->
"Build the entire authentication system: database models, JWT token handling, password hashing, login routes, middleware, email verification, and tests all at once."
(Result: Half-implemented files, missing imports, hallucinated helper methods).
```

## Good
```markdown
<!-- Step-by-step Atomic Execution: -->
1. **Step 1: Domain Types & Interfaces** -> Create `User`, `Credentials`, `AuthSession` interfaces -> Run `tsc --noEmit`.
2. **Step 2: Password Hasher Module** -> Write unit test -> Implement Argon2/Bcrypt wrapper -> Run tests.
3. **Step 3: JWT Token Service** -> Write unit test -> Implement token creation/verification -> Run tests.
4. **Step 4: Route Handlers & Integration** -> Assemble endpoints -> Run full verification suite.
```

## See Also
- [wf-spec-first](wf-spec-first.md) - Spec-first planning
- [wf-verification-gates](wf-verification-gates.md) - Continuous verification gates
