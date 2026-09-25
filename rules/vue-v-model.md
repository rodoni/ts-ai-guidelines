# vue-v-model

> Treat `v-model` as a typed value-and-update contract and validate model transitions at the component boundary.

## Why It Matters
Ad hoc model events create inconsistent naming and payloads. `defineModel` or explicit `modelValue` contracts keep two-way binding predictable.

## Bad
```vue
<script setup lang="ts">
const emit = defineEmits<{ input: [value: unknown] }>();
</script>
```

## Good
```vue
<script setup lang="ts">
const model = defineModel<string>({ required: true });

function normalize(value: string): void {
  model.value = value.trim();
}
</script>
```

## See Also
- [`vue-component-contracts`](vue-component-contracts.md)
- [`t-no-any`](t-no-any.md)
