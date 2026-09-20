# t-declaration-over-assertion

> Prefer type declarations (`const x: Type = ...`) over type assertions (`const x = ... as Type`) to ensure compile-time verification of value shapes.

## Why It Matters
Type assertions (`as Type`) silence the TypeScript compiler, bypassing excess property checks and allowing missing or mistyped properties to slip into runtime. Type declarations force the compiler to verify that the value genuinely satisfies the interface contract.

## Bad
```typescript
interface UserProfile {
  readonly id: string;
  readonly name: string;
  readonly email: string;
}

// Bypasses compiler validation: compiles even though email is completely missing!
const user = {
  id: "u123",
  name: "Alice",
} as UserProfile;

console.log(user.email.toLowerCase()); // Runtime TypeError: Cannot read properties of undefined
```

## Good
```typescript
interface UserProfile {
  readonly id: string;
  readonly name: string;
  readonly email: string;
}

// Compiler verifies shape immediately at the declaration site
const user: UserProfile = {
  id: "u123",
  name: "Alice",
  email: "alice@example.com",
};
```

## See Also
- [t-no-any](t-no-any.md) - Eliminate unsafe type escapes
- [t-const-assertions](t-const-assertions.md) - Use `as const` for literal inference
