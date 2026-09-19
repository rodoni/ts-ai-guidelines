# t-discriminated-unions

> Model polymorphic domains and state machines using discriminated unions with a common literal tag property.

## Why It Matters
Optional property bags (`{ status: string, data?: T, error?: Error }`) allow invalid states (e.g., status is "loading" but error is populated). Discriminated unions make impossible states unrepresentable in the type system.

> **Applicability Scope**: Universal when modeling states, events, domain operations, API responses, and polymorphic entities with mutually exclusive variants.

## Bad
```typescript
// Ambiguous state allows invalid combinations (data present during failure)
interface AsyncState<T> {
  status: "idle" | "loading" | "success" | "error";
  data?: T;
  error?: Error;
}

function render(state: AsyncState<string>) {
  if (state.status === "success") {
    // data is still string | undefined!
    console.log(state.data?.toUpperCase());
  }
}
```

## Good
```typescript
// Explicit variant shapes guarantee correct payload association
type AsyncState<T> =
  | { readonly status: "idle" }
  | { readonly status: "loading" }
  | { readonly status: "success"; readonly data: T }
  | { readonly status: "error"; readonly error: Error };

function render(state: AsyncState<string>) {
  switch (state.status) {
    case "success":
      // TypeScript automatically narrows state to { status: "success", data: string }
      console.log(state.data.toUpperCase());
      break;
    case "error":
      console.error(state.error.message);
      break;
    default:
      break;
  }
}
```

## See Also
- [t-exhaustiveness-check](t-exhaustiveness-check.md) - Enforce compile-time exhaustiveness
- [c-custom-type](c-custom-type.md) - Use custom domain types over booleans
