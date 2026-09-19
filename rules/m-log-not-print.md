# m-log-not-print

> Use structured telemetry and logger libraries; never use raw `console.log` or `console.error` in production services.

## Why It Matters
Raw `console.log` statements output unstructured text, lack severity levels (debug/info/warn/error), cannot be filtered or masked in log aggregators (Datadog, CloudWatch), and risk leaking sensitive data (PII or auth tokens).

> **Applicability Scope**: Production microservices, background workers, serverless functions, and shared libraries. Console output is restricted strictly to interactive CLI tools.

## Bad
```typescript
// Unstructured console logging, potential data leak
export function processPayment(orderId: string, creditCard: string): void {
  console.log("Processing order " + orderId + " with card: " + creditCard);
}
```

## Good
```typescript
export interface Logger {
  info(message: string, context?: Record<string, unknown>): void;
  warn(message: string, context?: Record<string, unknown>): void;
  error(message: string, error?: Error, context?: Record<string, unknown>): void;
}

export function processPayment(orderId: string, logger: Logger): void {
  logger.info("Payment transaction initiated", {
    orderId,
    timestamp: new Date().toISOString(),
  });
}
```

## See Also
- [m-mockable-io](m-mockable-io.md) - Injectable dependencies
- [c-weasel-words](c-weasel-words.md) - Meaningful naming
