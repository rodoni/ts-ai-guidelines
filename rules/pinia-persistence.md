# pinia-persistence

> Persist only an explicit, validated subset of Pinia state and version its serialized shape.

## Why It Matters
Persisting the entire store leaks transient state, tokens, and implementation details. Versioned boundaries allow migrations and reject malformed storage data.

## Bad
```ts
localStorage.setItem("store", JSON.stringify(store.$state));
```

## Good
```ts
interface PersistedCartV1 {
  readonly version: 1;
  readonly itemIds: readonly string[];
}

const payload: PersistedCartV1 = { version: 1, itemIds: items.value.map(({ id }) => id) };
storage.setItem("cart", JSON.stringify(payload));
```

## See Also
- [`m-validate-inputs`](m-validate-inputs.md)
- [`m-mockable-io`](m-mockable-io.md)
- [`t-discriminated-unions`](t-discriminated-unions.md)
