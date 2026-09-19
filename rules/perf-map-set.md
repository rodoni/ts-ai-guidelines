# perf-map-set

> Use `Map` and `Set` for frequent key-value lookups, insertions, and membership tests instead of plain objects.

## Why It Matters
Plain objects coerce non-string keys, inherit prototype properties, trigger hidden-class transitions on dynamic property additions, and have slower bulk addition/deletion characteristics than `Map` and `Set` in modern JavaScript engines.

> **Applicability Scope**: Hot paths, in-memory caches, collections with frequent key insertions/deletions, and lookup tables with non-string keys or dynamic user-supplied keys.

## Bad
```typescript
// Plain object used as dictionary with prototype collision risks
const userCache: Record<string, User> = {};

function hasUser(id: string): boolean {
  // Vulnerable to Object.prototype properties like "toString"
  return Boolean(userCache[id]);
}
```

## Good
```typescript
// Map is optimized for frequent key-value operations and avoids prototype pollution
const userCache = new Map<string, User>();

function hasUser(id: string): boolean {
  return userCache.has(id);
}

function recordActiveUser(id: string): void {
  const activeIds = new Set<string>();
  activeIds.add(id);
}
```

## See Also
- [perf-hidden-classes](perf-hidden-classes.md) - Preserve V8 hidden classes
- [perf-sparse-arrays](perf-sparse-arrays.md) - Array performance guidelines
