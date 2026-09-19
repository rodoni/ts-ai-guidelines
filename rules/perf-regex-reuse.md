# perf-regex-reuse

> Declare and compile regular expressions outside of functions and loops to prevent repeated compilation overhead.

## Why It Matters
Creating a `RegExp` literal or constructor inside a frequently called function recompiles the pattern on every execution, generating unnecessary memory allocations and garbage collection pressure in tight loops.

> **Applicability Scope**: Request validators, string parsers, sanitizers, and any function executed inside loops or handling high request volume.

## Bad
```typescript
function isValidEmail(email: string): boolean {
  // Recompiles regular expression on every single call
  const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  return emailRegex.test(email);
}
```

## Good
```typescript
// Compiled once at module load time
const EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

export function isValidEmail(email: string): boolean {
  return EMAIL_REGEX.test(email);
}
```

## See Also
- [c-naming-conventions](c-naming-conventions.md) - Uppercase for module constants
- [perf-map-set](perf-map-set.md) - Efficient lookup structures
