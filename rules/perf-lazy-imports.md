# perf-lazy-imports

> Use dynamic imports (`await import(...)`) to load non-critical or resource-intensive modules on demand.

## Why It Matters
Importing heavy libraries (PDF generators, syntax highlighters, charts) at top-level blocks startup and inflates bundle memory. Use dynamic imports to load resource-heavy dependencies strictly on demand.

## Bad
```typescript
// Heavy library imported at startup even if exportToPdf is never invoked
import { jsPDF } from "jspdf";

export function exportToPdf(data: ReportData): void {
  const doc = new jsPDF();
  // ...
}
```

## Good
```typescript
// Dynamic import ensures heavy dependencies are downloaded and initialized only when requested
export async function exportToPdf(data: ReportData): Promise<void> {
  const { jsPDF } = await import("jspdf");
  const doc = new jsPDF();
  // ...
}
```

## See Also
- [perf-tree-shaking](perf-tree-shaking.md) - Clean module boundaries
- [perf-type-imports](perf-type-imports.md) - Strip type overhead
