# vue-composable-testing

> Test composables through a mounted lifecycle host and injected fakes rather than relying on a component's private setup state.

## Why It Matters
Composables often depend on lifecycle hooks and browser APIs. A minimal host verifies setup and cleanup while keeping I/O deterministic.

## Bad
```ts
const result = useWindowSize();
expect(result.value.width).toBe(1024);
```

## Good
```ts
const { result, unmount } = mountComposable(() => useWindowSize(fakeWindow));

expect(result.value.width).toBe(1024);
unmount();
expect(fakeWindow.listeners).toHaveLength(0);
```

## See Also
- [`vue-composables`](vue-composables.md)
- [`m-mockable-io`](m-mockable-io.md)
