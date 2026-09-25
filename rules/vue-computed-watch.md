# vue-computed-watch

> Prefer computed derivations for values and reserve watchers for explicit side effects at integration boundaries.

## Why It Matters
Watchers are imperative and can multiply asynchronous effects or create feedback loops. Computed values remain declarative, cached, and easier to verify.

## Bad
```ts
const total = ref(0);
const price = ref(10);
const quantity = ref(2);

watch([price, quantity], () => {
  total.value = price.value * quantity.value;
});
```

## Good
```ts
const price = ref(10);
const quantity = ref(2);
const total = computed(() => price.value * quantity.value);
```

## See Also
- [`vue-reactivity-boundaries`](vue-reactivity-boundaries.md)
- [`m-mockable-io`](m-mockable-io.md)
