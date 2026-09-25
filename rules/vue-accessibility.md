# vue-accessibility

> Build Vue interactions from semantic elements, keyboard behavior, labels, and explicit focus management.

## Why It Matters
Visual tests can pass while keyboard and assistive technology users cannot operate the component. Accessibility is part of the observable component contract.

## Bad
```vue
<template>
  <div class="button" @click="submit">Submit</div>
</template>
```

## Good
```vue
<template>
  <button type="button" @click="submit">Submit</button>
</template>
```

## See Also
- [`vue-test-utils-accessibility`](vue-test-utils-accessibility.md)
- [`vue-test-utils-behavior`](vue-test-utils-behavior.md)
