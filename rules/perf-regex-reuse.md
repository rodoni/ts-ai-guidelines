# perf-regex-reuse

> Declare and compile regular expressions outside of functions and loops to prevent repeated compilation overhead.

## Why It Matters
Creating a `RegExp` literal inside a frequently called function recompiles the pattern on every invocation, causing unnecessary memory allocation and GC pressure. However, regular expressions with the global (`/g`) or sticky (`/y`) flags maintain mutable internal state (`lastIndex`). Only stateless regular expressions (without `/g` or `/y`) should be cached globally at module scope without manual resets.

## Bad
```typescript
function isValidEmail(email: string): boolean {
  // Recompiles regular expression on every single call
  const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  return emailRegex.test(email);
}

// TRAP: Stateful global regex shared at module level causes alternating test() results
const HAS_DIGIT_GLOBAL = /\d+/g;
function hasDigits(input: string): boolean {
  return HAS_DIGIT_GLOBAL.test(input); // Mutates lastIndex, yielding erratic alternating booleans!
}
```

## Good
```typescript
// Compiled once at module load time (stateless without /g or /y flags)
const EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

export function isValidEmail(email: string): boolean {
  return EMAIL_REGEX.test(email);
}

// If global extraction is required, isolate or reset lastIndex explicitly
const TOKEN_PATTERN = /[A-Z0-9]+/g;

export function extractTokens(text: string): readonly string[] {
  TOKEN_PATTERN.lastIndex = 0; // Reset mutable state before re-running
  return text.match(TOKEN_PATTERN) ?? [];
}
```

## See Also
- [c-naming-conventions](c-naming-conventions.md) - Uppercase for module constants
- [perf-map-set](perf-map-set.md) - Efficient lookup structures
