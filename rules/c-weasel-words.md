# c-weasel-words

> Eliminate vague weasel words (`Helper`, `Manager`, `Data`, `Info`, `Util`) from type, class, and module names.

## Why It Matters
Names containing weasel words act as "junk drawers" that accumulate disparate responsibilities, violate the Single Responsibility Principle, and make modules difficult for developers and AI agents to comprehend.

> **Applicability Scope**: Universal across naming of classes, interfaces, modules, directories, and function identifiers.

## Bad
```typescript
// Vague names that mask actual responsibilities
class UserManager {
  handleData(info: unknown) {
    // ...
  }
}

class StringHelper {
  // 50 unrelated string operations in one class
}
```

## Good
```typescript
// Precise, focused domain responsibilities
export class UserAuthenticationService {
  authenticateUser(credentials: UserCredentials): Promise<AuthSession> {
    // ...
  }
}

export class UserProfileRepository {
  findProfileById(id: UserId): Promise<UserProfile | null> {
    // ...
  }
}

// Standalone cohesive module functions instead of monolithic helper classes
export function slugifyText(text: string): string {
  // ...
}
```

## See Also
- [c-naming-conventions](c-naming-conventions.md) - Standard identifier conventions
- [wf-design-for-ai](wf-design-for-ai.md) - Design code for AI comprehension
