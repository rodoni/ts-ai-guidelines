# vue-provide-inject

> Use typed injection keys and explicit provider ownership for cross-tree dependencies.

## Why It Matters
String injection keys hide dependencies and allow collisions. Typed keys document the contract and make missing providers visible during design and testing.

## Bad
```ts
provide("api", apiClient);
const api = inject("api") as ApiClient;
```

## Good
```ts
const API_KEY: InjectionKey<ApiClient> = Symbol("api");
provide(API_KEY, apiClient);
const api = inject(API_KEY);
if (!api) throw new Error("ApiClient provider is missing");
```

## See Also
- [`t-encapsulate-assertions`](t-encapsulate-assertions.md)
- [`m-app-error`](m-app-error.md)
