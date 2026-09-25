# vue-pinia-store-boundaries

> Keep each Pinia store focused on one domain aggregate and expose actions instead of leaking mutation details.

## Why It Matters
God stores create hidden coupling, oversized reactive graphs, and difficult test setup. Domain-focused stores establish ownership and keep state transitions discoverable.

## Bad
```ts
export const useAppStore = defineStore("app", {
  state: () => ({ user: null, cart: [], modal: null, settings: {} }),
});
```

## Good
```ts
import { defineStore } from "pinia";
import { readonly, ref } from "vue";

interface CartItem {
  readonly id: string;
  readonly quantity: number;
}

export const useCartStore = defineStore("cart", () => {
  const items = ref<readonly CartItem[]>([]);

  function addItem(item: CartItem): void {
    items.value = [...items.value, item];
  }

  return { items: readonly(items), addItem };
});
```

## See Also
- [`c-custom-type`](c-custom-type.md)
- [`t-valid-states-only`](t-valid-states-only.md)
- [`c-readonly-immutability`](c-readonly-immutability.md)
