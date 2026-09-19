# m-validate-inputs

> Validate all external inputs, HTTP request bodies, and environment variables at runtime boundaries using schema validation.

## Why It Matters
TypeScript types only exist at compile time and disappear completely in JavaScript. Assuming external data (from network requests, user inputs, or `process.env`) matches a TypeScript interface without runtime validation leads directly to injection bugs and crash scenarios.

> **Applicability Scope**: All system boundaries: incoming HTTP requests, WebSocket messages, environment variables, IPC payloads, and database reads.

## Bad
```typescript
// Unsafe blind cast assumes API response matches expected structure
async function loadUserData(userId: string): Promise<UserData> {
  const response = await fetch(`/api/users/${userId}`);
  const data = (await response.json()) as UserData; // No runtime validation!
  return data;
}
```

## Good
```typescript
import { z } from "zod";

export const UserDataSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(1),
  email: z.string().email(),
});

export type UserData = z.infer<typeof UserDataSchema>;

export async function loadUserData(userId: string): Promise<UserData> {
  const response = await fetch(`/api/users/${userId}`);
  const raw = await response.json();
  // Safe runtime validation: throws descriptive ZodError if invalid
  return UserDataSchema.parse(raw);
}
```

## See Also
- [t-no-any](t-no-any.md) - Forbid `any` type
- [m-app-error](m-app-error.md) - Typed error handling
