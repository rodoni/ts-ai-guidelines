# perf-lazy-imports

> Use dynamic imports (`await import(...)`) to load non-critical or resource-intensive modules on demand.

## Why It Matters
Importing large libraries (such as PDF generators, syntax highlighters, or analytics SDKs) at module top-level blocks the critical startup path and inflates initial memory consumption, even if the user never accesses that feature.

> **Applicability Scope**: Heavy secondary features (e.g. PDF export, rich text editors, charts, analytics), conditional CLI commands, and rarely visited application routes.

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
