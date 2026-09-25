# vue-slots-expose

> Type slots and exposed component methods only when they form an intentional public component contract.

## Why It Matters
Implicit slots and broad `defineExpose` calls couple parents to implementation details. Small explicit contracts preserve refactoring freedom.

## Bad
```vue
<script setup lang="ts">
defineExpose({});
</script>
```

## Good
```vue
<script setup lang="ts">
const slots = defineSlots<{
  default(props: { readonly title: string }): unknown;
}>();

function focus(): void {
  // Focus the component's input.
}

defineExpose({ focus });
</script>
```

## See Also
- [`vue-component-contracts`](vue-component-contracts.md)
- [`c-dont-leak-internals`](c-dont-leak-internals.md)
