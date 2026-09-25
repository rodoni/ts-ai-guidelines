# vue-reactivity-unwrapping

> Preserve ref identity across composable boundaries and unwrap reactive values only at deliberate API edges.

## Why It Matters
Destructuring reactive objects or copying `.value` into plain variables silently disconnects consumers from updates. Returning stable refs makes ownership and reactivity explicit.

## Bad
```ts
const state = reactive({ count: 0 });
const { count } = state;
```

## Good
```ts
const state = reactive({ count: 0 });
const { count } = toRefs(state);
```

## See Also
- [`vue-reactivity-boundaries`](vue-reactivity-boundaries.md)
- [`c-readonly-immutability`](c-readonly-immutability.md)
