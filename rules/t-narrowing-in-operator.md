# t-narrowing-in-operator

> Use `typeof`, `instanceof`, and `'prop' in obj` operators for safe structural narrowing without type assertions.

## Why It Matters
Forceful type assertions (`as MyType`) bypass compiler checks and disguise runtime discrepancies. Native narrowing operators let TypeScript refine types safely through natural control flow analysis.

> **Applicability Scope**: Control-flow handling of heterogeneous objects, union types, and error inspection where types have distinct discriminators or property keys.

## Bad
```typescript
interface NetworkError {
  statusCode: number;
  message: string;
}

interface ValidationError {
  fields: Record<string, string>;
  message: string;
}

function handleError(err: NetworkError | ValidationError) {
  // Unsafe casting assumes shape without checking
  const netErr = err as NetworkError;
  if (netErr.statusCode > 400) {
    console.error(`Status: ${netErr.statusCode}`);
  }
}
```

## Good
```typescript
interface NetworkError {
  readonly statusCode: number;
  readonly message: string;
}

interface ValidationError {
  readonly fields: Readonly<Record<string, string>>;
  readonly message: string;
}

function handleError(err: NetworkError | ValidationError): void {
  if ("statusCode" in err) {
    // TypeScript automatically narrows err to NetworkError
    console.error(`Network failed with status: ${err.statusCode}`);
  } else {
    // TypeScript automatically narrows err to ValidationError
    console.error(`Validation failed on: ${Object.keys(err.fields).join(", ")}`);
  }
}
```

## See Also
- [t-discriminated-unions](t-discriminated-unions.md) - Model variants with common tags
- [t-type-predicates](t-type-predicates.md) - Custom type guard functions
