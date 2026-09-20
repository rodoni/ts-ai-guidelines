# t-index-signatures-dynamic

> Restrict index signatures (`Record<string, V>` or `[key: string]: V`) strictly to dynamic runtime key maps; use explicit interfaces or `Record<SpecificKeys, V>` for known schemas.

## Why It Matters
Using loose string index signatures for structured objects disables excess property checking, permits any arbitrary typo as a property name, and returns `V` even when the key does not exist on the object (causing undefined property access errors).

## Bad
```typescript
// Overly broad: allows typos and assumes every possible string key exists
interface UserSettings {
  [key: string]: string | number;
}

const settings: UserSettings = {
  theme: "dark",
  fontSize: 14,
  theeme: "light", // Silently permitted typo!
};

console.log(settings["nonExistent"].toString()); // Runtime TypeError!
```

## Good
```typescript
// Explicit interface for fixed schema with complete autocompletion
export interface UserSettings {
  readonly theme: "light" | "dark" | "system";
  readonly fontSize: number;
}

// Or constrained Record for dynamic keys bounded by a known domain union
export type FeatureFlag = "betaSearch" | "analyticsV2" | "darkMode";
export type FeatureConfig = Record<FeatureFlag, boolean>;

export const defaultFeatures: FeatureConfig = {
  betaSearch: false,
  analyticsV2: true,
  darkMode: true,
};
```

## See Also
- [c-interface-vs-type](c-interface-vs-type.md) - Choose interface for explicit object shapes
- [t-exact-optional](t-exact-optional.md) - Handle optional properties strictly
