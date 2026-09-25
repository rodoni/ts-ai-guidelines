# vue-security-html

> Treat `v-html` and dynamic URLs as untrusted input and sanitize them before rendering.

## Why It Matters
Vue escapes normal interpolations, but raw HTML and unsafe URL schemes can reintroduce XSS. Sanitization belongs at the boundary where untrusted content enters the view.

## Bad
```vue
<template>
  <article v-html="content" />
</template>
```

## Good
```ts
const safeContent = computed(() => sanitizeHtml(untrustedContent.value));
```

```vue
<template>
  <article v-html="safeContent" />
</template>
```

## See Also
- [`m-validate-inputs`](m-validate-inputs.md)
- [`m-app-error`](m-app-error.md)
