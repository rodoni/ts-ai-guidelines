# t-exhaustiveness-check

> Enforce compile-time exhaustiveness checking on union branches using the `never` type and an `assertNever` helper.

## Why It Matters
When new variants are added to a union, omitting a handler in a switch or conditional statement silently leads to unhandled runtime behavior unless the compiler rejects the missing case.

> **Applicability Scope**: Universal across all switch and conditional branches that consume discriminated unions or enum-like literal sets.

## Bad
```typescript
type NotificationChannel = "email" | "sms" | "push";

function sendNotification(channel: NotificationChannel, message: string): void {
  switch (channel) {
    case "email":
      sendEmail(message);
      break;
    case "sms":
      sendSms(message);
      break;
    // Adding "push" to NotificationChannel silently falls through without compiler error!
  }
}
```

## Good
```typescript
type NotificationChannel = "email" | "sms" | "push";

export function assertNever(value: never, message = `Unhandled variant: ${JSON.stringify(value)}`): never {
  throw new Error(message);
}

function sendNotification(channel: NotificationChannel, message: string): void {
  switch (channel) {
    case "email":
      sendEmail(message);
      break;
    case "sms":
      sendSms(message);
      break;
    case "push":
      sendPush(message);
      break;
    default:
      // TypeScript fails compilation if any variant is left unhandled!
      assertNever(channel);
  }
}
```

## See Also
- [t-discriminated-unions](t-discriminated-unions.md) - Model states as tagged unions
- [m-app-error](m-app-error.md) - Robust error handling patterns
