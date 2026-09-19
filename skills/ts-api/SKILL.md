---
name: ts-api
description: >
  API design, naming conventions, and type ergonomics for TypeScript libraries and services.
  Covers interfaces vs types, readonly immutability, branded types, return annotations,
  eliminating enums, builder pattern, and encapsulation.
license: MIT
---

# TypeScript API & Ergonomics Skill

Procedures and patterns for designing clean, type-safe, self-documenting APIs and contracts.

## Core Rules

1. **Contracts & Extensibility**: Prefer `interface` for extensible object contracts; `type` for unions and tuples.
   - [`c-interface-vs-type`](../../rules/c-interface-vs-type.md)
   - [`c-readonly-immutability`](../../rules/c-readonly-immutability.md)
2. **Nominal Typing & Domain Expressiveness**: Prevent primitive obsession.
   - [`c-branded-types`](../../rules/c-branded-types.md)
   - [`c-custom-type`](../../rules/c-custom-type.md)
3. **Public Boundary Rigor**: Explicit return annotations and clear naming.
   - [`c-return-annotations`](../../rules/c-return-annotations.md)
   - [`c-naming-conventions`](../../rules/c-naming-conventions.md)
   - [`c-weasel-words`](../../rules/c-weasel-words.md)
4. **Encapsulation & Construction**: Clean builders and zero foreign type leakage.
   - [`c-avoid-enums`](../../rules/c-avoid-enums.md)
   - [`c-builder-pattern`](../../rules/c-builder-pattern.md)
   - [`c-dont-leak-internals`](../../rules/c-dont-leak-internals.md)

## Verification Procedure

1. Verify that all exported functions have explicit return type annotations.
2. Check that all interface and type properties are marked `readonly`.
3. Check that no boolean flags are passed directly to functions; enforce option bags or domain literal unions.
