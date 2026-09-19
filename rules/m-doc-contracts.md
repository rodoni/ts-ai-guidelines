# m-doc-contracts

> Document public module functions with structured JSDoc containing `@param`, `@returns`, `@throws`, and runnable `@example`.

## Why It Matters
Clear contract documentation provides essential context to developers and AI coding agents, preventing incorrect call sequences, missed error cases, and hallucinated function capabilities.

> **Applicability Scope**: Exported public APIs, shared libraries, core domain services, and functions with non-obvious failure modes or parameter constraints.

## Bad
```typescript
// Undocumented function: callers do not know failure conditions or expected parameter formats
export function calculateDiscount(price: number, code: string): number {
  if (price < 0) throw new RangeError("Invalid price");
  return price * 0.9;
}
```

## Good
```typescript
/**
 * Computes the discounted total for a given item price and promo voucher.
 *
 * @param price - Non-negative unit price in base currency units.
 * @param code - Voucher code (must match uppercase alphanumeric format).
 * @returns The final discounted price rounded to 2 decimal places.
 * @throws {RangeError} If `price` is negative.
 * @throws {IllegalArgumentError} If `code` is empty or invalid.
 *
 * @example
 * ```typescript
 * const total = calculateDiscount(100, "SUMMER20");
 * console.log(total); // 80
 * ```
 */
export function calculateDiscount(price: number, code: string): number {
  if (price < 0) {
    throw new RangeError("Price must be greater than or equal to zero");
  }
  return Number((price * 0.9).toFixed(2));
}
```

## See Also
- [c-return-annotations](c-return-annotations.md) - Explicit return types
- [wf-design-for-ai](wf-design-for-ai.md) - Design code for AI comprehension
