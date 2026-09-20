# t-valid-states-only

> Design types such that illegal states are unrepresentable; push `null` and `undefined` to the outer perimeter rather than sprinkling optionals across every field.

## Why It Matters
When object schemas use multiple optional properties to represent state, impossible combinations (e.g. `isLoading: true` simultaneously with `error` or missing `data`) cause bugs and redundant defensive branching. Modeling explicit state unions guarantees that valid data and its metadata always co-exist.

## Bad
```typescript
// Permits impossible states: isLoading=true alongside error, or neither data nor error
interface RequestState<T> {
  readonly isLoading: boolean;
  readonly error?: Error;
  readonly data?: T;
}

function render(state: RequestState<string>) {
  if (state.isLoading) return "Loading...";
  // Unsafe: state.data might still be undefined here even if error is undefined!
  return state.data!.toUpperCase();
}
```

## Good
```typescript
// Discriminated union: each state is self-contained and impossible states cannot compile
export type RequestState<T> =
  | { readonly status: "idle" }
  | { readonly status: "loading" }
  | { readonly status: "success"; readonly data: T }
  | { readonly status: "error"; readonly error: Error };

export function render(state: RequestState<string>): string {
  switch (state.status) {
    case "idle": return "Ready";
    case "loading": return "Loading...";
    case "error": return `Error: ${state.error.message}`;
    case "success": return state.data.toUpperCase(); // Exhaustively verified & type-safe
  }
}
```

## See Also
- [t-discriminated-unions](t-discriminated-unions.md) - Model polymorphic states with tag literals
- [t-exhaustiveness-check](t-exhaustiveness-check.md) - Ensure all union variants are handled
