# vue-pinia-async-actions

> Model Pinia asynchronous actions with explicit loading, success, and error states and handle stale responses.

## Why It Matters
An unstructured `loading` flag permits impossible combinations such as stale data alongside a new error. Discriminated state also makes UI rendering exhaustive and prevents older requests from overwriting newer results.

## Bad
```ts
const loading = ref(false);
const error = ref<Error | null>(null);
const users = ref<User[]>([]);

async function loadUsers(): Promise<void> {
  loading.value = true;
  users.value = await fetchUsers();
  loading.value = false;
}
```

## Good
```ts
import { defineStore } from "pinia";
import type { StoreDefinition } from "pinia";
import { ref } from "vue";

interface User {
  readonly id: string;
}

interface UserReader {
  fetchUsers(): Promise<readonly User[]>;
}

type UsersState =
  | { readonly status: "idle" }
  | { readonly status: "loading" }
  | { readonly status: "success"; readonly users: readonly User[] }
  | { readonly status: "error"; readonly error: Error };

export function createUsersStore(reader: UserReader): StoreDefinition {
  return defineStore("users", () => {
    const state = ref<UsersState>({ status: "idle" });
    let requestVersion = 0;

    async function loadUsers(): Promise<void> {
      const version = ++requestVersion;
      state.value = { status: "loading" };
      try {
        const users = await reader.fetchUsers();
        if (version === requestVersion) state.value = { status: "success", users };
      } catch (error: unknown) {
        if (version === requestVersion) {
          const normalizedError = error instanceof Error
            ? error
            : new Error("User loading failed");
          state.value = { status: "error", error: normalizedError };
        }
      }
    }

    return { state, loadUsers };
  });
}
```

## See Also
- [`t-discriminated-unions`](t-discriminated-unions.md)
- [`t-exhaustiveness-check`](t-exhaustiveness-check.md)
- [`m-no-floating-promises`](m-no-floating-promises.md)
