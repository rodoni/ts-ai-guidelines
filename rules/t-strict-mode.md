# t-strict-mode

> Always enable `strict: true` and all additional strict family compiler flags in `tsconfig.json`.

## Why It Matters
Permissive TypeScript settings allow implicit `any`, nullable dereferencing, and unverified index accesses, destroying the compiler's safety guarantees and causing runtime exceptions in production.

> **Applicability Scope**: Universal across all TypeScript projects, packages, and workspace configurations without exception.

## Bad
```json
// Permissive tsconfig.json misses critical bugs at compile time
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "strict": false
  }
}
```

## Good
```json
// Strict compiler configuration catches nullability, index, and parameter bugs
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

## See Also
- [t-no-any](t-no-any.md) - Forbid `any` type usage
- [t-exact-optional](t-exact-optional.md) - Exact optional property semantics
