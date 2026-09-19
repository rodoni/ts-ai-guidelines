# m-no-floating-promises

> Always `await`, return, or explicitly handle Promises; never allow unhandled floating Promises.

## Why It Matters
Calling an asynchronous function returning a Promise without awaiting or attaching a `.catch()` causes silent failures if an error occurs. In Node.js, unhandled rejections can terminate the process or leave transactions hanging in inconsistent states.

> **Applicability Scope**: Universal across all asynchronous codebases and async function invocations.

## Bad
```typescript
async function saveAuditLog(event: string): Promise<void> {
  // ...
}

function handleUserAction(action: string): void {
  // Floating promise: if saveAuditLog rejects, the failure is completely silent!
  saveAuditLog(action);
}
```

## Good
```typescript
async function saveAuditLog(event: string): Promise<void> {
  // ...
}

// Option 1: Await inside an async context
async function handleUserAction(action: string): Promise<void> {
  await saveAuditLog(action);
}

// Option 2: Explicit fire-and-forget with error handler
function handleUserActionSync(action: string, logger: { error: (msg: string, e: unknown) => void }): void {
  void saveAuditLog(action).catch((err) => {
    logger.error("Failed to write audit log asynchronously", err);
  });
}
```

## See Also
- [m-app-error](m-app-error.md) - Typed error handling
- [m-log-not-print](m-log-not-print.md) - Structured telemetry
