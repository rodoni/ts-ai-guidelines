# vue-test-utils-async

> Synchronize Vue Test Utils assertions with Vue's scheduler and mocked time instead of using wall-clock delays.

## Why It Matters
Vue batches DOM updates and asynchronous effects. Arbitrary sleeps make tests slow and flaky. In Vue Test Utils, `trigger()` already returns a Promise that awaits Vue's `nextTick()`. When components initiate asynchronous background work (like API calls or store actions), `await flushPromises()` drains the microtask queue deterministically without cargo-culting redundant calls.

## Bad
```ts
await wrapper.get("button").trigger("click");
// Fragile wall-clock delay guessing when Vue finishes updating
await new Promise((resolve) => setTimeout(resolve, 50));
expect(wrapper.text()).toContain("Saved");
```

## Good
```ts
import { flushPromises, mount } from "@vue/test-utils";
import { expect, it } from "vitest";
import SaveButton from "./SaveButton.vue";

it("renders the saved state after the async boundary", async () => {
  const wrapper = mount(SaveButton, {
    props: { save: async () => Promise.resolve() },
  });

  // trigger() awaits nextTick internally; flushPromises resolves pending background microtasks
  await wrapper.get("button").trigger("click");
  await flushPromises();

  expect(wrapper.text()).toContain("Saved");
});
```

## See Also
- [`test-deterministic-no-sleep`](test-deterministic-no-sleep.md)
- [`m-mockable-io`](m-mockable-io.md)
