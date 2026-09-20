# t-mapped-types-sync

> Use mapped types (`[K in keyof T]`) to enforce compile-time synchronization between domain properties and consumer logic like UI tables, validators, or serializers.

## Why It Matters
When new fields are added to domain types, downstream consumers (such as display formatters, validation checklists, or change-detectors) often fail to handle the new fields. Mapped types turn omissions into immediate compiler errors.

## Bad
```typescript
interface ScatterProps {
  readonly xs: number[];
  readonly ys: number[];
  readonly xRange: [number, number];
  readonly yRange: [number, number];
  readonly color: string;
}

// Adding a new field to ScatterProps leaves this function silently desynchronized
function shouldUpdate(oldProps: ScatterProps, newProps: ScatterProps): boolean {
  return (
    oldProps.xs !== newProps.xs ||
    oldProps.ys !== newProps.ys ||
    oldProps.xRange !== newProps.xRange ||
    oldProps.yRange !== newProps.yRange ||
    oldProps.color !== newProps.color
  );
}
```

## Good
```typescript
interface ScatterProps {
  readonly xs: number[];
  readonly ys: number[];
  readonly xRange: [number, number];
  readonly yRange: [number, number];
  readonly color: string;
}

// Mapped type forces compile error if any property is added to ScatterProps but omitted here
const REQUIRES_UPDATE: { readonly [K in keyof ScatterProps]: boolean } = {
  xs: true,
  ys: true,
  xRange: true,
  yRange: true,
  color: true,
};

export function shouldUpdate(oldProps: ScatterProps, newProps: ScatterProps): boolean {
  for (const k in REQUIRES_UPDATE) {
    const key = k as keyof ScatterProps;
    if (oldProps[key] !== newProps[key] && REQUIRES_UPDATE[key]) return true;
  }
  return false;
}
```

## See Also
- [t-exhaustiveness-check](t-exhaustiveness-check.md) - Enforce total coverage across unions
- [t-const-assertions](t-const-assertions.md) - Preserve literal types with `as const`
