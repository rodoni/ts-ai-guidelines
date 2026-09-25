# vue-composition-api

> Use Composition API and `<script setup>` for cohesive component logic, keeping reactive dependencies explicit.

## Why It Matters
Composition API groups behavior by responsibility instead of lifecycle option blocks. Explicit imports and `<script setup>` also improve static analysis, tree-shaking, and type inference.

## Bad
```vue
<script lang="ts">
export default {
  data() {
    return { count: 0 };
  },
  methods: {
    increment() {
      this.count += 1;
    },
  },
};
</script>
```

## Good
```vue
<script setup lang="ts">
import { ref } from "vue";

const count = ref(0);

function increment(): void {
  count.value += 1;
}
</script>
```

## See Also
- [`c-readonly-immutability`](c-readonly-immutability.md)
- [`perf-tree-shaking`](perf-tree-shaking.md)
