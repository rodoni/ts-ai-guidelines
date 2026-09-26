# c-avoid-enums

> Prefer union of string literals or `as const` objects over TypeScript numeric and string `enum`.

## Why It Matters
TypeScript `enum` generates runtime JavaScript code (an IIFE building a lookup object), defeats tree-shaking, and breaks structural typing: string enums cannot be satisfied by identical string literals without explicitly importing the enum symbol. Unions of string literals combined with `as const` objects provide complete compile-time safety and zero JavaScript runtime bloat.

## Bad
```typescript
// Generates bloated runtime IIFE, breaks structural typing, and impairs tree-shaking
enum LogLevel {
  Debug = "debug",
  Info = "info",
  Warn = "warn",
  Error = "error",
}

function log(level: LogLevel, msg: string) {
  // ...
}

// Friction: Exact string literal is rejected unless explicitly imported as LogLevel.Info
// log("info", "Fails compilation despite having the exact string value!");
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
