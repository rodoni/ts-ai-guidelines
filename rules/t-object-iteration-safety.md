# t-object-iteration-safety

> Acknowledge structural typing in object iteration; use `Object.entries` with narrowing or typed iteration helpers instead of unsafe `Object.keys(obj) as (keyof T)[]`.

## Why It Matters
Because TypeScript uses structural typing, objects may carry additional runtime properties not declared in their static interfaces. Therefore, `Object.keys` intentionally returns `string[]` rather than `(keyof T)[]`. Forcing assertions on keys leads to runtime bugs when iterating over subtype instances.

## Bad
```typescript
interface Point {
  readonly x: number;
  readonly y: number;
}

// Unsafe assertion: obj may have extra properties (e.g. z: "hello") at runtime
function printCoordinates(p: Point) {
  for (const k of Object.keys(p) as (keyof Point)[]) {
    const val = p[k]; // Assumes number, but runtime object may contain other types!
    console.log(val.toFixed(2));
  }
}
```

## Good
```typescript
interface Point {
  readonly x: number;
  readonly y: number;
}

// Explicit property access or safe Object.entries iteration
export function formatCoordinates(p: Point): string {
  return `(${p.x.toFixed(2)}, ${p.y.toFixed(2)})`;
}

export function sumNumericEntries(record: Record<string, number>): number {
  let total = 0;
  for (const [, val] of Object.entries(record)) {
    total += val;
  }
  return total;
}
```

## See Also
- [t-declaration-over-assertion](t-declaration-over-assertion.md) - Avoid unsafe type assertions
- [t-narrowing-in-operator](t-narrowing-in-operator.md) - Safe property narrowing with `in`
