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
const REQUIRES_UPDATE: {
  readonly [K in keyof ScatterProps]: (oldProps: ScatterProps, newProps: ScatterProps) => boolean;
} = {
  xs: (oldProps, newProps) => oldProps.xs !== newProps.xs,
  ys: (oldProps, newProps) => oldProps.ys !== newProps.ys,
  xRange: (oldProps, newProps) => oldProps.xRange !== newProps.xRange,
  yRange: (oldProps, newProps) => oldProps.yRange !== newProps.yRange,
  color: (oldProps, newProps) => oldProps.color !== newProps.color,
};

export function shouldUpdate(oldProps: ScatterProps, newProps: ScatterProps): boolean {
  return Object.values(REQUIRES_UPDATE).some((hasChanged) => hasChanged(oldProps, newProps));
}
```

## See Also
- [t-exhaustiveness-check](t-exhaustiveness-check.md) - Enforce total coverage across unions
- [t-const-assertions](t-const-assertions.md) - Preserve literal types with `as const`
