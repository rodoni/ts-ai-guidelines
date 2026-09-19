# c-builder-pattern

> Use the Builder pattern with validation for complex or incrementally configured domain objects.

## Why It Matters
Constructors with extensive parameter lists or optional property bags often permit incomplete or invalid combinations of options. A type-safe fluent Builder ensures that objects are validated before being materialized.

> **Applicability Scope**: Complex configuration objects, multi-step resource initializers, query builders, and test data factories with more than 3-4 optional parameters.

## Bad
```typescript
// Constructor with 6 optional arguments leads to null padding and mistakes
class HttpClient {
  constructor(
    baseUrl: string,
    timeout?: number,
    retries?: number,
    headers?: Record<string, string>,
    proxy?: string,
    authHeader?: string
  ) {
    // ...
  }
}
```

## Good
```typescript
export interface ClientConfig {
  readonly baseUrl: string;
  readonly timeoutMs: number;
  readonly retries: number;
  readonly headers: Readonly<Record<string, string>>;
}

export class HttpClientBuilder {
  private timeoutMs = 30000;
  private retries = 3;
  private headers: Record<string, string> = {};

  constructor(private readonly baseUrl: string) {
    if (!baseUrl.startsWith("http://") && !baseUrl.startsWith("https://")) {
      throw new Error("Invalid baseUrl");
    }
  }

  withTimeout(ms: number): this {
    this.timeoutMs = ms;
    return this;
  }

  withHeader(key: string, value: string): this {
    this.headers[key] = value;
    return this;
  }

  build(): ClientConfig {
    return {
      baseUrl: this.baseUrl,
      timeoutMs: this.timeoutMs,
      retries: this.retries,
      headers: Object.freeze({ ...this.headers }),
    };
  }
}
```

## See Also
- [c-custom-type](c-custom-type.md) - Domain-specific options
- [c-readonly-immutability](c-readonly-immutability.md) - Freezing configuration objects
