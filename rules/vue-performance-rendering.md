# vue-performance-rendering

> Keep reactive graphs and rendered lists minimal, stable, and keyed by durable domain identifiers.

## Why It Matters
Deep reactive objects and unstable list keys trigger needless tracking and DOM work. Stable identities let Vue reuse component instances safely.

## Bad
```vue
<template>
  <Row v-for="(item, index) in items" :key="index" :item="item" />
</template>
```

## Good
```vue
<template>
  <Row v-for="item in items" :key="item.id" :item="item" />
</template>
```

## See Also
- [`perf-map-set`](perf-map-set.md)
- [`perf-lazy-imports`](perf-lazy-imports.md)
