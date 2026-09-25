# vue-component-contracts

> Define component inputs and events with typed `defineProps` and `defineEmits` contracts.

## Why It Matters
Untyped prop bags and stringly-typed events move component failures to runtime. Explicit contracts preserve autocomplete, validate parent-child boundaries, and make refactoring safe.

## Bad
```vue
<script setup lang="ts">
const props = defineProps<{ value?: unknown }>();
const emit = defineEmits(["change"]);

emit("change", props.value);
</script>
```

## Good
```vue
<script setup lang="ts">
interface Props {
  readonly modelValue: string;
}

const props = defineProps<Props>();
const emit = defineEmits<{
  change: [value: string];
}>();

emit("change", props.modelValue.trim());
</script>
```

## See Also
- [`c-interface-vs-type`](c-interface-vs-type.md)
- [`t-no-any`](t-no-any.md)
- [`t-template-literal-types`](t-template-literal-types.md)
