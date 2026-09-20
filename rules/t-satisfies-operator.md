# t-satisfies-operator

> Use the `satisfies` operator to validate that an expression conforms to a type contract without widening inferred literal types.

## Why It Matters
Type annotations on object literals (`const config: Schema = ...`) force the compiler to widen values (e.g. literals become `string` or `number`), destroying autocompletion and exact tuple inference. Omitting annotations sacrifices validation. The `satisfies` operator solves both: it validates the contract while preserving exact literal types.

## Bad
```typescript
type ThemeColor = "primary" | "secondary" | "accent";

// Widens all property values to general string, losing exact hex literals
const palette: Record<ThemeColor, string> = {
  primary: "#0070f3",
  secondary: "#ff4081",
  accent: "#7928ca",
};

// No autocomplete or type error for exact hex codes
palette.primary.toLowerCase();
```

## Good
```typescript
type ThemeColor = "primary" | "secondary" | "accent";

// Validates keys and values against Record contract, while preserving exact literal types
export const palette = {
  primary: "#0070f3",
  secondary: "#ff4081",
  accent: "#7928ca",
} satisfies Record<ThemeColor, string>;

// palette.primary is typed as exact literal "#0070f3" rather than wide string
export type PrimaryColor = typeof palette.primary; // "#0070f3"
```

## See Also
- [t-const-assertions](t-const-assertions.md) - Enforce deep literal immutability
- [t-declaration-over-assertion](t-declaration-over-assertion.md) - Prefer declarations to assertions
