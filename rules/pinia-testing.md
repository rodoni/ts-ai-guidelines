# pinia-testing

> Create a fresh Pinia instance and assert store behavior through public actions, getters, and state contracts.

## Why It Matters
Shared Pinia instances leak state between tests, while assertions against private implementation details resist safe refactoring. Isolated stores make failures deterministic.

## Bad
```ts
const store = useCartStore();
store.items.push(item);
expect(store.items).toHaveLength(1);
```

## Good
```ts
setActivePinia(createPinia());
const store = useCartStore();

store.addItem(item);

expect(store.items).toEqual([item]);
expect(store.total).toBe(item.price);
```

## See Also
- [`vue-test-utils-pinia`](vue-test-utils-pinia.md)
- [`test-behavior-not-internals`](test-behavior-not-internals.md)
- [`test-fakes-over-heavy-mocks`](test-fakes-over-heavy-mocks.md)
