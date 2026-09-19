# perf-sparse-arrays

> Avoid sparse arrays and frequent size mutations that degrade V8 array optimizations to dictionary mode.

## Why It Matters
Modern JavaScript engines store dense arrays as contiguous memory buffers (FAST_ELEMENTS). Assigning elements to distant indices (e.g. `arr[1000] = x` on an empty array) forces the engine into slow hash-table dictionary mode (DICTIONARY_ELEMENTS), drastically increasing memory and CPU latency.

> **Applicability Scope**: Performance-critical loops, numerical computations, buffers, graphics/audio processing, and high-volume data transformation pipelines.

## Bad
```typescript
// Creates holes (sparse array), degrading engine optimization
const buffer: number[] = [];
buffer[5000] = 42; // Deoptimizes array into dictionary mode
```

## Good
```typescript
// Allocate dense arrays with known capacity using Array.from or fill
const capacity = 5000;
const buffer = new Array<number>(capacity).fill(0);

// Or build dense collections iteratively
const items: number[] = [];
for (let i = 0; i < capacity; i++) {
  items.push(i);
}
```

## See Also
- [perf-map-set](perf-map-set.md) - Use Map/Set for sparse indices
- [perf-hidden-classes](perf-hidden-classes.md) - Object shape predictability
