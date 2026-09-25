# pinia-getters-pure

> Keep Pinia getters pure and derive values without mutating state or performing I/O.

## Why It Matters
Getters are cached derivations. Side effects inside them create order-dependent rendering and make cache invalidation unpredictable.

## Bad
```ts
getters: {
  total(state) {
    state.items.sort(compareItems);
    return state.items.length;
  },
}
```

## Good
```ts
const total = computed(() => items.value.reduce((sum, item) => sum + item.price, 0));
```

## See Also
- [`vue-computed-watch`](vue-computed-watch.md)
- [`c-readonly-immutability`](c-readonly-immutability.md)
