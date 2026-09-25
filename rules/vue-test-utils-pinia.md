# vue-test-utils-pinia

> Install a fresh testing Pinia per component test and configure action behavior intentionally.

## Why It Matters
Components using stores need realistic providers without sharing state across tests. Explicit testing Pinia configuration prevents accidental network calls and hidden action coupling.

## Bad
```ts
mount(CartView);
```

## Good
```ts
const wrapper = mount(CartView, {
  global: {
    plugins: [createTestingPinia({ stubActions: false })],
  },
});
```

## See Also
- [`pinia-testing`](pinia-testing.md)
- [`vue-test-utils-behavior`](vue-test-utils-behavior.md)
