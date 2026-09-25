# vue-test-utils-behavior

> Test Vue components through rendered behavior and public contracts, not private refs, setup state, or implementation details.

## Why It Matters
Tests coupled to component internals break during harmless template and Composition API refactors. User-visible output, emitted events, and accessible interactions represent the stable contract.

## Bad
```ts
const wrapper = mount(Counter);
expect((wrapper.vm as { count: number }).count).toBe(0);
```

## Good
```ts
import { mount } from "@vue/test-utils";
import { describe, expect, it } from "vitest";
import Counter from "./Counter.vue";

describe("Counter", () => {
  it("increments through the public UI contract", async () => {
    const wrapper = mount(Counter);

    await wrapper.get("button").trigger("click");

    expect(wrapper.get("[role=\"status\"]").text()).toBe("1");
    expect(wrapper.emitted("change")).toEqual([[1]]);
  });
});
```

## See Also
- [`test-behavior-not-internals`](test-behavior-not-internals.md)
- [`test-assert-error-variants`](test-assert-error-variants.md)
