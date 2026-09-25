# vue-test-utils-accessibility

> Query Vue components through accessible roles, labels, and names before reaching for CSS selectors.

## Why It Matters
Accessibility-oriented queries verify the same contract used by assistive technology and reduce coupling to template structure.

## Bad
```ts
expect(wrapper.find(".submit-button").exists()).toBe(true);
```

## Good
```ts
expect(wrapper.get('button[aria-label="Submit order"]').isVisible()).toBe(true);
```

## See Also
- [`vue-accessibility`](vue-accessibility.md)
- [`vue-test-utils-behavior`](vue-test-utils-behavior.md)
