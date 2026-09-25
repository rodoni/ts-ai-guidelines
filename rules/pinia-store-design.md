# pinia-store-design

> Align each Pinia store with one domain aggregate and keep local UI state outside global stores.

## Why It Matters
Screen-sized stores accumulate unrelated state and make every component depend on a global graph. Aggregate boundaries clarify ownership, persistence, and test setup.

## Bad
```ts
export const useAppStore = defineStore("app", {
  state: () => ({ user: null, cart: [], dialog: null, theme: "light" }),
});
```

## Good
```ts
export const useCartStore = defineStore("cart", () => {
  const items = ref<readonly CartItem[]>([]);
  const add = (item: CartItem): void => { items.value = [...items.value, item]; };
  return { items: readonly(items), add };
});
```

## See Also
- [`vue-pinia-store-boundaries`](vue-pinia-store-boundaries.md)
- [`t-valid-states-only`](t-valid-states-only.md)
