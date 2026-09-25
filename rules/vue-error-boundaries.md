# vue-error-boundaries

> Handle component and async errors at explicit Vue boundaries and expose a typed recovery state.

## Why It Matters
Unhandled render and setup failures can blank a view or disappear into global logs. Local error boundaries provide recoverable UI and preserve observability.

## Bad
```ts
async function load(): Promise<void> {
  data.value = await fetchData();
}
```

## Good
```ts
const state = ref<RequestState<Data>>({ status: "idle" });

async function load(): Promise<void> {
  state.value = { status: "loading" };
  try {
    state.value = { status: "success", data: await fetchData() };
  } catch (error: unknown) {
    state.value = { status: "error", error: normalizeError(error) };
  }
}
```

## See Also
- [`t-discriminated-unions`](t-discriminated-unions.md)
- [`m-app-error`](m-app-error.md)
