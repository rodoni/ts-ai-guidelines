# pinia-dependencies

> Inject API, storage, clock, and analytics dependencies into Pinia stores instead of importing infrastructure directly.

## Why It Matters
Direct imports make stores difficult to test and bind domain state to one runtime. Explicit dependencies support deterministic fakes and multiple deployments.

## Bad
```ts
export const useUserStore = defineStore("user", {
  actions: { async load() { this.user = await fetch("/user").then((r) => r.json()); } },
});
```

## Good
```ts
import { defineStore } from "pinia";
import { inject, readonly, ref, type InjectionKey } from "vue";

export interface UserGateway {
  load(): Promise<User>;
}

export const UserGatewayKey: InjectionKey<UserGateway> = Symbol("UserGateway");

export const useUserStore = defineStore("user", () => {
  // Inject dependency with default fallback or configured provider
  const gateway = inject(UserGatewayKey, {
    load: () => fetch("/user").then((r) => r.json()),
  });

  const user = ref<User | null>(null);
  const load = async (): Promise<void> => {
    user.value = await gateway.load();
  };

  return { user: readonly(user), load };
});
```

## See Also
- [`m-mockable-io`](m-mockable-io.md)
- [`test-fakes-over-heavy-mocks`](test-fakes-over-heavy-mocks.md)
