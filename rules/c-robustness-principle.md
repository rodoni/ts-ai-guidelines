# c-robustness-principle

> Be liberal in what input parameters you accept, and strict in what return types you produce (Postel's Law).

## Why It Matters
Accepting flexible inputs (e.g. single items or arrays, iterables, or loose union formats) makes public APIs ergonomic for callers. Conversely, returning ambiguous unions or loose shapes forces every caller to write tedious narrowing logic. Functions should always return canonical, strictly typed structures.

## Bad
```typescript
// Strict on input (requires caller to allocate array), but loose on output
function formatTags(tags: string[]): string | string[] {
  if (tags.length === 1) return tags[0];
  return tags; // Forces callers to check `typeof result === 'string'` constantly
}
```

## Good
```typescript
// Liberal in input: accepts a single string or an array/iterable
export function normalizeTags(
  tags: string | readonly string[]
): readonly string[] {
  // Strict in output: always returns a canonical, immutable array
  return typeof tags === "string" ? [tags] : tags;
}

// Callers enjoy zero branching overhead
const result = normalizeTags("typescript");
console.log(result.length); // Guaranteed array access
```

## See Also
- [c-return-annotations](c-return-annotations.md) - Explicit return types on public boundaries
- [c-readonly-immutability](c-readonly-immutability.md) - Mark return arrays readonly
