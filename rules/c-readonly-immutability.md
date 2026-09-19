# c-readonly-immutability

> Mark object properties and arrays as `readonly` to prevent accidental state mutations and side effects.

## Why It Matters
JavaScript passes objects and arrays by reference. Unintended mutations at call sites or inside helper functions introduce subtle bugs, race conditions, and break memoization or state containers (like Redux or React hooks).

## Bad
```typescript
interface UserSettings {
  theme: string;
  tags: string[];
}

function sanitizeTags(settings: UserSettings): void {
  // Directly mutates caller's array!
  settings.tags.sort();
}
```

## Good
```typescript
interface UserSettings {
  readonly theme: string;
  readonly tags: readonly string[];
}

function sanitizeTags(settings: UserSettings): readonly string[] {
  // Returns a new immutable sorted copy without mutating the original
  return [...settings.tags].sort();
}
```

## See Also
- [t-const-assertions](t-const-assertions.md) - Deep immutability via `as const`
- [c-interface-vs-type](c-interface-vs-type.md) - Defining structured interfaces
