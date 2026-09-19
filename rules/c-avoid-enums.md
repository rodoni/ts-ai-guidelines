# c-avoid-enums

> Prefer union of string literals or `as const` objects over TypeScript numeric and string `enum`.

## Why It Matters
TypeScript `enum` generates runtime JavaScript code (often with bidirectional mapping objects for numeric enums), causes quirks across module bundlers, and complicates tree-shaking. Union of string literals and `as const` objects provide complete type safety without runtime overhead.

> **Applicability Scope**: Universal across modern TypeScript libraries, applications, and frontend bundles seeking optimal tree-shaking and zero runtime compilation overhead.

## Bad
```typescript
// Generates bloated IIFE in JS output, numeric enums allow arbitrary numbers
enum LogLevel {
  Debug,
  Info,
  Warn,
  Error,
}

function log(level: LogLevel, msg: string) {
  // ...
}

log(999, "Invalid level allowed by numeric enum!"); // No compile error in standard TS!
```

## Good
```typescript
// Zero runtime JS overhead, strict type checking, clean autocompletion
export const LogLevel = {
  Debug: "debug",
  Info: "info",
  Warn: "warn",
  Error: "error",
} as const;

export type LogLevel = (typeof LogLevel)[keyof typeof LogLevel]; // "debug" | "info" | "warn" | "error"

function log(level: LogLevel, msg: string): void {
  // ...
}

log(LogLevel.Info, "Server started"); // Clean, idiomatic, and safe
log("info", "Works with direct literals too");
```

## See Also
- [t-const-assertions](t-const-assertions.md) - Enforce literals with `as const`
- [c-custom-type](c-custom-type.md) - Express domain values with dedicated types
