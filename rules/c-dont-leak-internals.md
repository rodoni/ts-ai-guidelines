# c-dont-leak-internals

> Encapsulate internal library dependencies and types; export only intentional public API surfaces.

## Why It Matters
Exposing third-party types (e.g., from an ORM, an internal client library, or an unstable dependency) in your public API signatures binds your consumers to those foreign implementations and makes updating dependencies a major breaking change.

> **Applicability Scope**: Public libraries, shared workspace packages, domain services, and modular application layers intended for consumption by other teams or modules.

## Bad
```typescript
import { AxiosResponse } from "axios";

// Leaking internal third-party Axios type in public service signature
export async function getCustomer(id: string): Promise<AxiosResponse> {
  // ...
}
```

## Good
```typescript
import axios from "axios";

export interface Customer {
  readonly id: string;
  readonly name: string;
}

// Pure domain contract: internal Axios dependency is completely encapsulated
export async function getCustomer(id: string): Promise<Customer> {
  const response = await axios.get<Customer>(`/api/customers/${id}`);
  return response.data;
}
```

## See Also
- [c-interface-vs-type](c-interface-vs-type.md) - Define clean domain contracts
- [c-return-annotations](c-return-annotations.md) - Explicit return type annotations
