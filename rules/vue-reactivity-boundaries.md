# vue-reactivity-boundaries

> Keep reactive state at explicit boundaries and unwrap it only where the public contract requires a plain value.

## Why It Matters
Accidental mixing of refs, reactive proxies, and plain objects creates unclear ownership and stale reads. Small reactive boundaries make components and composables easier to test and reason about.

## Bad
```ts
const state = reactive({ count: 0 });

export function getCount(): number {
  return state.count;
}

export function replaceState(next: { count: number }): void {
  Object.assign(state, next);
}
```

## Good
```ts
import { computed, readonly, ref } from "vue";
import type { ComputedRef, Ref } from "vue";

export function useCount(): {
  readonly count: Readonly<Ref<number>>;
  readonly countValue: Readonly<ComputedRef<number>>;
  readonly setCount: (next: number) => void;
} {
  const count = ref(0);
  const countValue = computed(() => count.value);

  function setCount(next: number): void {
    count.value = next;
  }

  return { count: readonly(count), countValue, setCount };
}
```

## See Also
- [`t-valid-states-only`](t-valid-states-only.md)
- [`c-readonly-immutability`](c-readonly-immutability.md)
