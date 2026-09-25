# vue-composables

> Design composables around one cohesive capability with explicit inputs, outputs, and lifecycle ownership.

## Why It Matters
Large composables become hidden global state containers and leak effects across components. A narrow contract makes reuse, cleanup, and isolated testing predictable.

## Bad
```ts
export function useApp(): Record<string, unknown> {
  // Fetches data, mutates stores, registers listeners, and controls dialogs.
  return {};
}
```

## Good
```ts
import type { Ref } from "vue";
import { onMounted, onUnmounted, ref } from "vue";

export interface WindowSizeState {
  readonly width: number;
  readonly height: number;
}

interface WindowLike {
  readonly innerWidth: number;
  readonly innerHeight: number;
  addEventListener(type: "resize", listener: () => void): void;
  removeEventListener(type: "resize", listener: () => void): void;
}

export function useWindowSize(
  windowRef: WindowLike | null = typeof window === "undefined" ? null : window,
): Readonly<Ref<WindowSizeState>> {
  const size = ref<WindowSizeState>({
    width: windowRef?.innerWidth ?? 0,
    height: windowRef?.innerHeight ?? 0,
  });
  const onResize = (): void => {
    if (windowRef) {
      size.value = { width: windowRef.innerWidth, height: windowRef.innerHeight };
    }
  };

  onMounted(() => windowRef?.addEventListener("resize", onResize));
  onUnmounted(() => windowRef?.removeEventListener("resize", onResize));
  return size;
}
```

## See Also
- [`m-mockable-io`](m-mockable-io.md)
- [`c-return-annotations`](c-return-annotations.md)
- [`c-weasel-words`](c-weasel-words.md)
