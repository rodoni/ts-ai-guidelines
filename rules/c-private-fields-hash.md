# c-private-fields-hash

> Use ECMAScript `#field` syntax for genuine runtime privacy and encapsulation, reserving the `private` TypeScript keyword strictly for soft compile-time visibility.

## Why It Matters
TypeScript's `private` keyword is purely a compile-time assertion that is stripped during compilation, leaving properties fully visible and mutable at runtime via bracket access (`obj["secret"]`) or `Object.keys()`. ECMAScript private fields (`#secret`) enforce hard isolation at the JavaScript runtime engine level.

## Bad
```typescript
class ApiClient {
  // Purely compile-time: easily accessed via (client as any).apiKey or serialization
  private apiKey: string;

  constructor(key: string) {
    this.apiKey = key;
  }
}

const client = new ApiClient("super-secret-key");
console.log((client as Record<string, unknown>)["apiKey"]); // Leaked at runtime!
```

## Good
```typescript
export class ApiClient {
  // Hard runtime encapsulation guaranteed by the JavaScript V8 engine
  readonly #apiKey: string;

  constructor(apiKey: string) {
    if (!apiKey) throw new Error("apiKey is required");
    this.#apiKey = apiKey;
  }

  public getMaskedKey(): string {
    return `${this.#apiKey.slice(0, 4)}...`;
  }
}
```

## See Also
- [c-dont-leak-internals](c-dont-leak-internals.md) - Encapsulate internal implementation details
- [perf-hidden-classes](perf-hidden-classes.md) - Preserve class shape stability
