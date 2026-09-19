# c-naming-conventions

> Follow idiomatic TypeScript casing conventions strictly across all identifiers.

## Why It Matters
Inconsistent naming conventions across modules impair readability, create confusion between types and values, and complicate static analysis and IDE refactoring tools.

## Bad
```typescript
// Non-standard naming: lower case interface, snake_case function, screaming type
interface user_data {
  User_Name: string;
}

type HTTP_RESPONSE = {
  status: number;
};

function Get_user_by_id(Id: string) {
  // ...
}
```

## Good
```typescript
// PascalCase for types, interfaces, classes, and components
export interface UserData {
  readonly userName: string;
}

export type HttpResponse = {
  readonly status: number;
};

// camelCase for functions, methods, and variables
export function getUserById(id: string): void {
  // ...
}

// UPPER_SNAKE_CASE strictly for immutable global constants
export const DEFAULT_TIMEOUT_MS = 5000;
```

## See Also
- [c-weasel-words](c-weasel-words.md) - Eliminate vague names
- [c-interface-vs-type](c-interface-vs-type.md) - Structuring types and interfaces
