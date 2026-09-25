# vue-test-utils-async

> Synchronize Vue Test Utils assertions with Vue's scheduler and mocked time instead of using wall-clock delays.

## Why It Matters
Vue batches DOM updates and asynchronous effects. Arbitrary sleeps make tests slow and flaky, while `nextTick`, `flushPromises`, and fake timers express the actual synchronization boundary.

## Bad
```ts
await wrapper.get("button").trigger("click");
await new Promise((resolve) => setTimeout(resolve, 50));
expect(wrapper.text()).toContain("Saved");
```

## Good
```ts
import { flushPromises, mount } from "@vue/test-utils";
import { nextTick } from "vue";
import { expect, it } from "vitest";
import SaveButton from "./SaveButton.vue";

it("renders the saved state after the async boundary", async () => {
  const wrapper = mount(SaveButton, {
    props: { save: async () => undefined },
  });

  await wrapper.get("button").trigger("click");
  await flushPromises();
  await nextTick();

  expect(wrapper.text()).toContain("Saved");
});
```

## See Also
- [`test-deterministic-no-sleep`](test-deterministic-no-sleep.md)
- [`m-mockable-io`](m-mockable-io.md)
