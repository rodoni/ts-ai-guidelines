# TypeScript AI Guidelines & Agentic Tools

Conjunto modular de **Agentes de IA**, **SKILLS** e **Regras Atômicas** otimizados para desenvolvimento agêntico em TypeScript com **foco em baixíssimo consumo de contexto** (*Zero Token Waste*).

---

## 💎 Filosofia: Curadoria de Alto Impacto (*Curated Core*)

O [TypeScript Official Handbook](https://www.typescriptlang.org/docs/handbook/intro.html) (Microsoft) e o aclamado [Effective TypeScript: 62 Specific Ways to Improve Your TypeScript](https://effectivetypescript.com) (Dan Vanderkam, O'Reilly) contêm centenas de páginas, regras descritivas e sutilezas de compilação. Para orquestração agêntica, o [Tweag Agentic Coding Handbook](https://tweag.github.io/agentic-coding-handbook/workflows/) define os fluxos de trabalho centrais (*Core Workflows*).

Diferente de abordagens ingênuas que despejam documentações inteiras na janela de contexto das LLMs — desperdiçando dezenas de milhares de tokens e gerando alucinações —, este ecossistema destila **63 regras TypeScript essenciais**, com **25 regras Vue 3 e Pinia opcionais** carregadas sob demanda:
1. **Solidez e Rigor do Sistema de Tipos**: Zero tolerância para `any`, `strict: true` inegociável, modelagem com uniões discriminadas, declarações e `satisfies` em vez de asserções cegas (`as T`), eliminação do antipadrão `{}`/`Function`, sincronização com Mapped Types, gramáticas com Template Literals e estados válidos exclusivos (*make illegal states unrepresentable*).
2. **Ergonomia e Imutabilidade de APIs**: Lei de Postel (*liberal na entrada, estrito na saída*), Branded Types contra obsessão por primitivos, `readonly` por padrão, interfaces para contratos abertos, eliminação de `enum` numéricos e campos privados reais (`#campo`) do ECMAScript.
3. **Performance de Runtime e Bundle**: Preservação de hidden classes do V8, estabilidade de tipos de variáveis, coleções densas, `Map`/`Set` otimizados, eliminação de barrel files monolíticos e imports dinâmicos (`await import(...)`).
4. **Resiliência e Observabilidade Corporativa**: Validação em tempo de execução nas bordas (Zod/Valibot), telemetria estruturada sem `console.log` em produção e prevenção estrita de *floating promises*.
5. **Metodologia Agêntica Tweag (Core Workflows)**: Abordagem *Spec-First*, desenvolvimento guiado por testes (*TDD Loop*), portões determinísticos de verificação contínua (*Verification Gates*) e separação cognitiva de papéis (*Writer vs. Reviewer*).
6. **Engenharia de Testes de Alta Confiança**: Testes baseados em propriedades (`fast-check`), fakes leves em memória, eliminação de timers wall-clock (`vi.useFakeTimers()`), asserções estritas de erro e testes de snapshot estruturado.

> ⚡ **Zero Token Waste**: Cada regra é atômica (30 a 60 linhas), auto-contida e carregada **sob demanda** pelos agentes especializados.

### Referências Oficiais Vue e Pinia

A camada opcional Vue/Pinia é baseada nas documentações oficiais e nas APIs públicas abaixo:

- [Vue.js Guide](https://vuejs.org/guide/): Composition API, reatividade, componentes, composables e lifecycle.
- [Vue.js TypeScript with Composition API](https://vuejs.org/guide/typescript/composition-api.html): contratos tipados para componentes e composables.
- [Vue.js Computed Properties](https://vuejs.org/guide/essentials/computed.html): derivação reativa e getters sem efeitos colaterais.
- [Vue.js Watchers](https://vuejs.org/guide/essentials/watchers.html): efeitos, cleanup, cancelamento e sincronização.
- [Vue.js Component v-model](https://vuejs.org/guide/components/v-model.html): `defineModel`, props e eventos de atualização.
- [Vue.js Provide / Inject](https://vuejs.org/guide/components/provide-inject.html): dependências entre componentes e injection keys.
- [Vue.js Slots](https://vuejs.org/guide/components/slots.html): slots nomeados, scoped slots e contratos de composição.
- [Vue.js Accessibility](https://vuejs.org/guide/best-practices/accessibility.html): semântica, teclado e foco.
- [Vue.js Security](https://vuejs.org/guide/best-practices/security.html): templates confiáveis, `v-html` e conteúdo não confiável.
- [Vue.js Performance](https://vuejs.org/guide/best-practices/performance.html): reatividade e otimização de renderização.
- [Pinia Core Concepts](https://pinia.vuejs.org/core-concepts/): stores, state, getters, actions e plugins.
- [Pinia Testing Cookbook](https://pinia.vuejs.org/cookbook/testing.html): `createPinia`, `setActivePinia` e `createTestingPinia`.
- [Vue Test Utils Guide](https://test-utils.vuejs.org/guide/): montagem e testes comportamentais de componentes Vue.
- [Vue Test Utils API](https://test-utils.vuejs.org/api/): APIs de montagem, wrappers e lifecycle de testes.

---

## 🎯 Compatibilidade Multi-Ambiente

Projetado para funcionar de forma nativa e sem fricção em múltiplos ambientes:
- **Google Antigravity** (`.agents/skills/`, `.agents/rules/`, `.agents/agents/` e `.agents/AGENTS.md`)
- **OpenCode / OpenCodeInterpreter** (`.opencode/rules/`, `.opencode/skills/`, `.opencode/agents/` e `.opencode/AGENTS.md`)
- **Kilo Code** (`.kilo/` e `kilo.jsonc`)
- **Cursor** (`.cursor/rules/*.mdc`, `.cursor/skills/` e `.cursor/agents/`)
- **Claude Code** (`.claude/` e `CLAUDE.md`)
- **GitHub Copilot** (`.github/copilot-instructions.md`)

> 🛡️ **Instalação Não-Invasiva**: Nenhuma configuração destrutiva sobrescreve arquivos existentes na raiz do projeto. Todo o ecossistema é confinado nas pastas das respectivas ferramentas.

---

## 🧠 Agentes Especializados (`agents/`)

Em vez de sobrecarregar um único prompt genérico com dezenas de milhares de tokens, o trabalho é dividido entre agentes com escopos precisos:

| Agente | Arquivo | Responsabilidade |
|---|---|---|
| **`ts-lead`** | [`agents/ts-lead.md`](agents/ts-lead.md) | Orquestração, planejamento modular Spec-First e triagem de tarefas. |
| **`ts-type-architect`** | [`agents/ts-type-architect.md`](agents/ts-type-architect.md) | Design de tipos avançados, discriminated unions, generic constraints e zero `any`. |
| **`ts-perf-optimizer`** | [`agents/ts-perf-optimizer.md`](agents/ts-perf-optimizer.md) | Otimização de runtime, V8 hidden classes, tree-shaking, lazy imports e bundle size. |
| **`ts-safety-auditor`** | [`agents/ts-safety-auditor.md`](agents/ts-safety-auditor.md) | Validação em runtime (Zod/Valibot), tipagem defensiva, contratos JSDoc e segurança. |
| **`ts-reviewer`** | [`agents/ts-reviewer.md`](agents/ts-reviewer.md) | Revisão exaustiva de código com *Zero Omission Policy*, multi-pass audit e relatórios de portões. |
| **`ts-test-engineer`** | [`agents/ts-test-engineer.md`](agents/ts-test-engineer.md) | Engenharia de testes determinísticos, property-based (`fast-check`), fakes em memória e TDD. |
| **`vue-architect`** | [`agents/vue-architect.md`](agents/vue-architect.md) | Arquitetura Vue 3, Composition API, composables, contratos de componentes e Pinia. |
| **`vue-test-engineer`** | [`agents/vue-test-engineer.md`](agents/vue-test-engineer.md) | Testes de componentes, composables e stores com Vitest e Vue Test Utils. |
| **`pinia-architect`** | [`agents/pinia-architect.md`](agents/pinia-architect.md) | Arquitetura de stores Pinia, persistência, dependências e estados assíncronos. |
| **`pinia-test-engineer`** | [`agents/pinia-test-engineer.md`](agents/pinia-test-engineer.md) | Testes isolados de stores e integração Pinia com componentes Vue. |

### 📊 Matriz de Mapeamento: Agentes ➔ Skills ➔ Regras

| Agente | Skill Primária | Skills Secundárias | Regras Atômicas Enforced (`rules/*.md`) |
|---|---|---|---|
| **`ts-lead`** | [`ts-guidelines`](skills/ts-guidelines/SKILL.md) *(Master Hub)* | Todas as 6 skills temáticas | `wf-spec-first`, `wf-atomic-steps`, `wf-verification-gates`, `t-strict-mode` |
| **`ts-type-architect`** | [`ts-types`](skills/ts-types/SKILL.md) *(Tipagem Avançada)* | `ts-api`, `ts-perf` | `t-strict-mode`, `t-no-any`, `t-declaration-over-assertion`, `t-satisfies-operator`, `t-no-empty-object-type`, `t-avoid-redundant-annotations`, `t-variable-type-stability`, `t-discriminated-unions`, `t-valid-states-only`, `t-exhaustiveness-check`, `t-type-predicates`, `t-narrowing-in-operator`, `t-mapped-types-sync`, `t-template-literal-types`, `t-encapsulate-assertions`, `t-object-iteration-safety`, `t-separate-types-spaces`, `t-conditional-types-over-overloads`, `t-avoid-wrapper-types`, `t-index-signatures-dynamic`, `t-build-objects-at-once`, `t-exact-optional`, `t-const-assertions`, `t-generics-constraints`, `t-generics-simplicity`, `c-interface-vs-type`, `c-readonly-immutability`, `c-branded-types`, `c-return-annotations`, `c-avoid-enums`, `c-custom-type` |
| **`ts-perf-optimizer`** | [`ts-perf`](skills/ts-perf/SKILL.md) *(Performance & Bundle)* | `ts-api`, `ts-types` | `perf-map-set`, `perf-sparse-arrays`, `perf-hidden-classes`, `perf-tree-shaking`, `perf-lazy-imports`, `perf-type-imports`, `perf-regex-reuse` |
| **`ts-safety-auditor`** | [`ts-resilience-app`](skills/ts-resilience-app/SKILL.md) *(Segurança & Bordas)* | `ts-types`, `ts-api` | `m-app-error`, `m-validate-inputs`, `m-log-not-print`, `m-no-floating-promises`, `m-lint-override-expect`, `m-mockable-io`, `m-doc-contracts` |
| **`ts-reviewer`** | [`ts-agentic-workflow`](skills/ts-agentic-workflow/SKILL.md) *(Compliance & Gates)* | `ts-types`, `ts-api`, `ts-resilience-app`, `ts-perf`, `ts-testing` | As 63 regras core auditadas sob protocolo multi-pass com *Zero Omission Policy*. |
| **`ts-test-engineer`** | [`ts-testing`](skills/ts-testing/SKILL.md) *(Testes & Invariantes)* | [`ts-agentic-workflow`](skills/ts-agentic-workflow/SKILL.md), `ts-resilience-app`, `ts-types` | `test-property-based`, `test-assert-error-variants`, `test-deterministic-no-sleep`, `test-fakes-over-heavy-mocks`, `test-behavior-not-internals`, `test-snapshot-for-complex-data`, `wf-tdd-loop`, `wf-verification-gates`, `m-mockable-io` |
| **`vue-architect`** | [`vue-guidelines`](skills/vue-guidelines/SKILL.md) *(Vue 3 & Composition API)* | `ts-guidelines`, `ts-types`, `ts-api`, `ts-resilience-app` | `vue-composition-api`, `vue-reactivity-boundaries`, `vue-component-contracts`, `vue-composables`, `vue-pinia-store-boundaries`, `vue-pinia-async-actions` |
| **`vue-test-engineer`** | [`vue-testing`](skills/vue-testing/SKILL.md) *(Vue Test Utils)* | `ts-testing`, `vue-guidelines`, `ts-agentic-workflow` | `vue-test-utils-behavior`, `vue-test-utils-async`, `test-behavior-not-internals`, `test-deterministic-no-sleep`, `m-mockable-io` |
| **`pinia-architect`** | [`pinia-guidelines`](skills/pinia-guidelines/SKILL.md) *(Pinia & Estado)* | `vue-guidelines`, `ts-types`, `ts-resilience-app` | `pinia-store-design`, `pinia-getters-pure`, `pinia-persistence`, `pinia-dependencies`, `vue-pinia-async-actions` |
| **`pinia-test-engineer`** | [`pinia-testing`](skills/pinia-testing/SKILL.md) *(Testes Pinia)* | `vue-testing`, `ts-testing`, `pinia-guidelines` | `pinia-testing`, `vue-test-utils-pinia`, `vue-composable-testing`, `test-behavior-not-internals`, `m-mockable-io` |

---

## 📦 SKILLS Modulares (`skills/`)

As diretrizes são organizadas em skills temáticas carregadas sob demanda:

1. **[`ts-guidelines`](skills/ts-guidelines/SKILL.md)**: Hub mestre com tabela de prioridades e índices para todas as regras.
2. **[`ts-types`](skills/ts-types/SKILL.md)**: Sistema de tipos estrito, narrowing, discriminated unions, mapped types, satisfies e constraints.
3. **[`ts-api`](skills/ts-api/SKILL.md)**: Ergonomia de APIs públicas, imutabilidade com `readonly`, branded types, Postel's law, private fields e builders.
4. **[`ts-perf`](skills/ts-perf/SKILL.md)**: Otimizações V8, estruturas Map/Set, tree-shaking e import type.
5. **[`ts-resilience-app`](skills/ts-resilience-app/SKILL.md)**: Resiliência, validação com Zod, telemetria estruturada e Promises.
6. **[`ts-agentic-workflow`](skills/ts-agentic-workflow/SKILL.md)**: Metodologia Tweag Core Workflows (Spec-First, TDD Loop, Verification Gates e Writer/Reviewer).
7. **[`ts-testing`](skills/ts-testing/SKILL.md)**: Engenharia de testes determinísticos, property-based (`fast-check`), in-memory fakes e asserções estritas de erro.

### Camada Opcional Vue 3

A camada Vue é carregada sob demanda sobre o núcleo TypeScript. Ela não altera as regras base e concentra apenas contratos e práticas específicas de Vue, Pinia e Vue Test Utils:

1. **[`vue-guidelines`](skills/vue-guidelines/SKILL.md)**: Composition API, reatividade, componentes, composables, acessibilidade, segurança e performance.
2. **[`vue-testing`](skills/vue-testing/SKILL.md)**: Testes comportamentais de componentes, acessibilidade, composables e sincronização assíncrona.
3. **[`pinia-guidelines`](skills/pinia-guidelines/SKILL.md)**: Stores focados, getters puros, persistência validada e dependências injetáveis.
4. **[`pinia-testing`](skills/pinia-testing/SKILL.md)**: Testes isolados de stores e integração com componentes Vue.

---

## ⚡ Regras Atômicas de Baixo Contexto (`rules/`)

As regras em [`rules/`](rules/) são mantidas concisas, normalmente entre 30 e 60 linhas, e seguem a estrutura padronizada:
- **Imperativo de 1 linha**: Orientação técnica imediata.
- **Why It Matters**: 1 a 2 sentenças objetivas explicando o mecanismo e impacto arquitetural.
- **Bad**: Snippet curto em TypeScript demonstrando o antipadrão.
- **Good**: Snippet corrigido, defensivo, idiomático e com zero desperdício de recursos.
- **See Also**: Links correlatos para outras regras do ecossistema.

### 📋 Catálogo Completo das 63 Regras TypeScript Core

| Categoria | Regra | Origem | Diretriz Atômica |
|---|---|---|---|
| **Sistema de Tipos & Rigor** | [`t-strict-mode`](rules/t-strict-mode.md) | TS Handbook & Effective TS | Always enable `strict: true` and all additional strict family compiler flags in `tsconfig.json`. |
| **Sistema de Tipos & Rigor** | [`t-no-any`](rules/t-no-any.md) | TS Handbook & Effective TS | Never use the `any` type; use `unknown` for unchecked values and narrow before usage. |
| **Sistema de Tipos & Rigor** | [`t-declaration-over-assertion`](rules/t-declaration-over-assertion.md) | Effective TS (Item 9) | Prefer type declarations (`const x: Type = ...`) over type assertions (`const x = ... as Type`). |
| **Sistema de Tipos & Rigor** | [`t-satisfies-operator`](rules/t-satisfies-operator.md) | TS Handbook & Modern TS | Use `satisfies` to validate contracts without widening inferred literal types. |
| **Sistema de Tipos & Rigor** | [`t-no-empty-object-type`](rules/t-no-empty-object-type.md) | TS Handbook & Effective TS | Avoid `{}` and `Function` types; use `Record<string, never>`, `object`, or typed callables. |
| **Sistema de Tipos & Rigor** | [`t-avoid-redundant-annotations`](rules/t-avoid-redundant-annotations.md) | Effective TS (Item 19) | Avoid cluttering code with inferable local types; annotate function signatures and module boundaries. |
| **Sistema de Tipos & Rigor** | [`t-variable-type-stability`](rules/t-variable-type-stability.md) | Effective TS (Item 20) | Use distinct variables for different types; never reassign a variable to a conflicting type. |
| **Sistema de Tipos & Rigor** | [`t-discriminated-unions`](rules/t-discriminated-unions.md) | TS Handbook & Effective TS | Model polymorphic domains and state machines using discriminated unions with a common literal tag property. |
| **Sistema de Tipos & Rigor** | [`t-valid-states-only`](rules/t-valid-states-only.md) | Effective TS (Itens 28 & 31) | Design types such that illegal states are unrepresentable; push null and undefined to outer perimeters. |
| **Sistema de Tipos & Rigor** | [`t-exhaustiveness-check`](rules/t-exhaustiveness-check.md) | TS Handbook & Effective TS | Enforce compile-time exhaustiveness checking on union branches using the `never` type and an `assertNever` helper. |
| **Sistema de Tipos & Rigor** | [`t-type-predicates`](rules/t-type-predicates.md) | TS Handbook & Effective TS | Implement custom type predicates (`value is Type`) with rigorous runtime checks instead of blind type assertions. |
| **Sistema de Tipos & Rigor** | [`t-narrowing-in-operator`](rules/t-narrowing-in-operator.md) | TS Handbook & Effective TS | Use `typeof`, `instanceof`, and `'prop' in obj` operators for safe structural narrowing without type assertions. |
| **Sistema de Tipos & Rigor** | [`t-mapped-types-sync`](rules/t-mapped-types-sync.md) | Effective TS (Item 18) | Use mapped types (`[K in keyof T]`) to enforce compile-time synchronization between domain properties and consumers. |
| **Sistema de Tipos & Rigor** | [`t-template-literal-types`](rules/t-template-literal-types.md) | TS Handbook | Use template literal types (`${Entity}:${Action}`) to enforce structured string patterns at compile time. |
| **Sistema de Tipos & Rigor** | [`t-encapsulate-assertions`](rules/t-encapsulate-assertions.md) | Effective TS (Item 40) | Encapsulate unavoidable type assertions inside well-typed utility functions with safe public signatures. |
| **Sistema de Tipos & Rigor** | [`t-object-iteration-safety`](rules/t-object-iteration-safety.md) | TS Handbook & Effective TS | Acknowledge structural typing in object iteration; use `Object.entries` or safe helpers instead of `Object.keys as (keyof T)[]`. |
| **Sistema de Tipos & Rigor** | [`t-separate-types-spaces`](rules/t-separate-types-spaces.md) | Effective TS (Item 8) | Keep the distinction between type space and value space explicit to eliminate syntactic ambiguity. |
| **Sistema de Tipos & Rigor** | [`t-conditional-types-over-overloads`](rules/t-conditional-types-over-overloads.md) | TS Handbook & Effective TS | Prefer conditional types (`T extends A ? B : C`) over repetitive function overloads. |
| **Sistema de Tipos & Rigor** | [`t-avoid-wrapper-types`](rules/t-avoid-wrapper-types.md) | TS Handbook & Effective TS | Always use lowercase primitive types (`string`, `number`) and never uppercase object wrapper types (`String`, `Number`). |
| **Sistema de Tipos & Rigor** | [`t-index-signatures-dynamic`](rules/t-index-signatures-dynamic.md) | Effective TS (Itens 15 & 16) | Restrict index signatures strictly to dynamic runtime key maps; use explicit interfaces for known schemas. |
| **Sistema de Tipos & Rigor** | [`t-build-objects-at-once`](rules/t-build-objects-at-once.md) | Effective TS (Item 23) | Build objects all at once using object literals or spread rather than mutating properties incrementally on `{}`. |
| **Sistema de Tipos & Rigor** | [`t-exact-optional`](rules/t-exact-optional.md) | TS Handbook | Distinguish between omitted optional properties and explicit `undefined` values using `exactOptionalPropertyTypes`. |
| **Sistema de Tipos & Rigor** | [`t-const-assertions`](rules/t-const-assertions.md) | TS Handbook & Effective TS | Use `as const` on literal objects, arrays, and tuples to preserve literal types and enforce deep immutability. |
| **Sistema de Tipos & Rigor** | [`t-generics-constraints`](rules/t-generics-constraints.md) | TS Handbook & Effective TS | Constrain generic type parameters (`T extends Base`) rather than using unbounded generics. |
| **Sistema de Tipos & Rigor** | [`t-generics-simplicity`](rules/t-generics-simplicity.md) | TS Handbook & Effective TS | Avoid generic over-engineering; prefer concrete types or minimal type parameters where type inference suffices. |
| **API & Ergonomia** | [`c-interface-vs-type`](rules/c-interface-vs-type.md) | TS Handbook & Effective TS | Prefer `interface` for extensible object contracts and public APIs; prefer `type` for unions, intersections, primitives, and tuples. |
| **API & Ergonomia** | [`c-readonly-immutability`](rules/c-readonly-immutability.md) | TS Handbook & Effective TS | Mark object properties and arrays as `readonly` to prevent accidental state mutations and side effects. |
| **API & Ergonomia** | [`c-robustness-principle`](rules/c-robustness-principle.md) | Effective TS (Item 29) | Be liberal in what input parameters you accept, and strict in what return types you produce (Postel's Law). |
| **API & Ergonomia** | [`c-branded-types`](rules/c-branded-types.md) | Effective TS (Item 37) | Use Branded Types (nominal typing) to prevent primitive obsession and accidental argument swapping. |
| **API & Ergonomia** | [`c-return-annotations`](rules/c-return-annotations.md) | TS Handbook & Effective TS | Always explicitly annotate function return types on exported module boundaries and public APIs. |
| **API & Ergonomia** | [`c-avoid-enums`](rules/c-avoid-enums.md) | Effective TS & TS Idioms | Prefer union of string literals or `as const` objects over TypeScript numeric and string `enum`. |
| **API & Ergonomia** | [`c-custom-type`](rules/c-custom-type.md) | Effective TS (Item 33) | Convey domain intent through dedicated domain types and literal unions rather than ambiguous boolean flags. |
| **API & Ergonomia** | [`c-naming-conventions`](rules/c-naming-conventions.md) | Effective TS & Community | Follow idiomatic TypeScript casing conventions strictly across all identifiers. |
| **API & Ergonomia** | [`c-builder-pattern`](rules/c-builder-pattern.md) | TS Best Practices | Use the Builder pattern with validation for complex or incrementally configured domain objects. |
| **API & Ergonomia** | [`c-weasel-words`](rules/c-weasel-words.md) | Clean Code & Tweag | Eliminate vague weasel words (`Helper`, `Manager`, `Data`, `Info`, `Util`) from type, class, and module names. |
| **API & Ergonomia** | [`c-dont-leak-internals`](rules/c-dont-leak-internals.md) | Effective TS (Item 47) | Encapsulate internal library dependencies and types; export only intentional public API surfaces. |
| **API & Ergonomia** | [`c-private-fields-hash`](rules/c-private-fields-hash.md) | Effective TS & ECMAScript | Use ECMAScript `#field` syntax for genuine runtime privacy and encapsulation. |
| **Performance & Memória** | [`perf-map-set`](rules/perf-map-set.md) | V8 & Runtime | Use `Map` and `Set` for frequent key-value lookups, insertions, and membership tests instead of plain objects. |
| **Performance & Memória** | [`perf-sparse-arrays`](rules/perf-sparse-arrays.md) | V8 Optimization | Avoid sparse arrays and frequent size mutations that degrade V8 array optimizations to dictionary mode. |
| **Performance & Memória** | [`perf-hidden-classes`](rules/perf-hidden-classes.md) | V8 Optimization | Initialize all object properties in constructors or factory functions in a consistent order to preserve hidden classes. |
| **Performance & Memória** | [`perf-tree-shaking`](rules/perf-tree-shaking.md) | Bundling Practices | Use pure ECMAScript Module (ESM) syntax and avoid monolithic barrel files (`index.ts`) that defeat tree-shaking. |
| **Performance & Memória** | [`perf-lazy-imports`](rules/perf-lazy-imports.md) | Bundling Practices | Use dynamic imports (`await import(...)`) to load non-critical or resource-intensive modules on demand. |
| **Performance & Memória** | [`perf-type-imports`](rules/perf-type-imports.md) | TS Compiler | Always use explicit `import type` and `export type` for type-only declarations. |
| **Performance & Memória** | [`perf-regex-reuse`](rules/perf-regex-reuse.md) | Runtime Performance | Declare and compile regular expressions outside of functions and loops to prevent repeated compilation overhead. |
| **Resiliência & Telemetria** | [`m-app-error`](rules/m-app-error.md) | Best Practices | Return strongly typed error unions (`Result<T, E>`) or throw custom typed `Error` subclasses; never throw plain strings or objects. |
| **Resiliência & Telemetria** | [`m-validate-inputs`](rules/m-validate-inputs.md) | Best Practices & Tweag | Validate all external inputs, HTTP request bodies, and environment variables at runtime boundaries using schema validation. |
| **Resiliência & Telemetria** | [`m-log-not-print`](rules/m-log-not-print.md) | Enterprise Telemetry | Use structured telemetry and logger libraries; never use raw `console.log` or `console.error` in production services. |
| **Resiliência & Telemetria** | [`m-no-floating-promises`](rules/m-no-floating-promises.md) | Async Best Practices | Always `await`, return, or explicitly handle Promises; never allow unhandled floating Promises. |
| **Resiliência & Telemetria** | [`m-lint-override-expect`](rules/m-lint-override-expect.md) | Lint Hygiene | Use inline linter suppressions with explicit rationale comments; never disable lints globally or without justification. |
| **Resiliência & Telemetria** | [`m-mockable-io`](rules/m-mockable-io.md) | Tweag Handbook | Decouple core domain logic from external I/O (network, filesystem, system clock) using interfaces or dependency injection. |
| **Resiliência & Telemetria** | [`m-doc-contracts`](rules/m-doc-contracts.md) | TS Handbook & Effective TS | Document public module functions with structured JSDoc containing `@param`, `@returns`, `@throws`, and runnable `@example`. |
| **Metodologia Tweag** | [`wf-spec-first`](rules/wf-spec-first.md) | Tweag Core Workflows | Always draft and review a technical specification and task decomposition before writing code. |
| **Metodologia Tweag** | [`wf-tdd-loop`](rules/wf-tdd-loop.md) | Tweag Core Workflows | Develop guided by tests (TDD): write or define automated tests before implementing feature logic. |
| **Metodologia Tweag** | [`wf-verification-gates`](rules/wf-verification-gates.md) | Tweag Core Workflows | Never advance an agentic coding task without passing deterministic feedback gates (`tsc --noEmit`, ESLint, tests). |
| **Metodologia Tweag** | [`wf-writer-reviewer`](rules/wf-writer-reviewer.md) | Tweag Core Workflows | Separate the creative coding persona from the critical compliance reviewer persona to eliminate confirmation bias. |
| **Metodologia Tweag** | [`wf-design-for-ai`](rules/wf-design-for-ai.md) | Tweag Core Workflows | Design TypeScript APIs, types, and modules for AI comprehension: explicit types, pure functions, and testable contracts. |
| **Metodologia Tweag** | [`wf-atomic-steps`](rules/wf-atomic-steps.md) | Tweag Core Workflows | Decompose complex development tasks into small, incremental, and independently verifiable steps. |
| **Engenharia de Testes** | [`test-property-based`](rules/test-property-based.md) | Fast-Check & Proptest Standards | Use property-based testing (`fast-check`) for pure functions, parsers, codecs, and domain invariants. |
| **Engenharia de Testes** | [`test-assert-error-variants`](rules/test-assert-error-variants.md) | Effective Testing | Assert specific error classes and discriminated payloads; avoid blind `toThrow()`. |
| **Engenharia de Testes** | [`test-deterministic-no-sleep`](rules/test-deterministic-no-sleep.md) | Deterministic Testing | Eliminate wall-clock sleeps (`setTimeout`); use virtual timers (`vi.useFakeTimers()`). |
| **Engenharia de Testes** | [`test-fakes-over-heavy-mocks`](rules/test-fakes-over-heavy-mocks.md) | Test Double Patterns | Prefer simple in-memory fakes and interfaces over complex dynamic mock monkeypatching. |
| **Engenharia de Testes** | [`test-behavior-not-internals`](rules/test-behavior-not-internals.md) | Refactoring Safety | Test observable module contracts and invariants, not ephemeral private helper functions. |
| **Engenharia de Testes** | [`test-snapshot-for-complex-data`](rules/test-snapshot-for-complex-data.md) | Snapshot Verification | Use snapshot testing (`toMatchSnapshot()`) for complex ASTs, schemas, and serialized outputs. |

### 📋 Catálogo Opcional das 25 Regras Vue 3 e Pinia

Estas regras são carregadas sob demanda e não alteram o núcleo TypeScript.

| Categoria | Regra | Origem | Diretriz Atômica |
|---|---|---|---|
| **Vue Core** | [`vue-composition-api`](rules/vue-composition-api.md) | Vue.js Guide | Use Composition API e `<script setup>` para lógica coesa. |
| **Vue Core** | [`vue-reactivity-boundaries`](rules/vue-reactivity-boundaries.md) | Vue Reactivity API | Mantenha ownership e unwrapping reativo explícitos. |
| **Vue Core** | [`vue-component-contracts`](rules/vue-component-contracts.md) | Vue TypeScript Guide | Tipifique props e eventos emitidos nas fronteiras. |
| **Vue Core** | [`vue-composables`](rules/vue-composables.md) | Vue Composables Guide | Mantenha um capability coeso por composable e cleanup local. |
| **Vue Core** | [`vue-computed-watch`](rules/vue-computed-watch.md) | Vue Computed & Watchers | Use computed para derivação e watchers para efeitos. |
| **Vue Core** | [`vue-reactivity-unwrapping`](rules/vue-reactivity-unwrapping.md) | Vue Reactivity API | Preserve identidade de refs entre boundaries. |
| **Vue Core** | [`vue-provide-inject`](rules/vue-provide-inject.md) | Vue Provide / Inject | Use injection keys tipadas e providers explícitos. |
| **Vue Core** | [`vue-slots-expose`](rules/vue-slots-expose.md) | Vue Slots & SFC API | Tipifique slots e métodos expostos intencionais. |
| **Vue Core** | [`vue-v-model`](rules/vue-v-model.md) | Vue Component v-model | Trate two-way binding como contrato tipado. |
| **Vue Quality** | [`vue-accessibility`](rules/vue-accessibility.md) | Vue Accessibility Guide | Construa interações semânticas e operáveis por teclado. |
| **Vue Quality** | [`vue-security-html`](rules/vue-security-html.md) | Vue Security Guide | Sanitize HTML e URLs não confiáveis antes de renderizar. |
| **Vue Quality** | [`vue-performance-rendering`](rules/vue-performance-rendering.md) | Vue Performance Guide | Mantenha grafos reativos e chaves de lista estáveis. |
| **Vue Quality** | [`vue-error-boundaries`](rules/vue-error-boundaries.md) | Vue Error Handling API | Exponha estados tipados de recuperação para falhas. |
| **Vue Testing** | [`vue-test-utils-behavior`](rules/vue-test-utils-behavior.md) | Vue Test Utils | Teste comportamento renderizado e contratos públicos. |
| **Vue Testing** | [`vue-test-utils-async`](rules/vue-test-utils-async.md) | Vue Test Utils & Vue Scheduler | Sincronize testes sem sleeps de wall-clock. |
| **Vue Testing** | [`vue-test-utils-pinia`](rules/vue-test-utils-pinia.md) | Pinia Testing Cookbook | Instale testing Pinia isolado por teste de componente. |
| **Vue Testing** | [`vue-test-utils-accessibility`](rules/vue-test-utils-accessibility.md) | Vue Accessibility & Test Utils | Prefira queries orientadas por acessibilidade. |
| **Vue Testing** | [`vue-composable-testing`](rules/vue-composable-testing.md) | Vue Composables & Test Utils | Teste lifecycle-bound composables com fakes injetados. |
| **Pinia** | [`vue-pinia-store-boundaries`](rules/vue-pinia-store-boundaries.md) | Pinia Core Concepts | Mantenha stores focados em um aggregate de domínio. |
| **Pinia** | [`vue-pinia-async-actions`](rules/vue-pinia-async-actions.md) | Pinia Actions & Vue Reactivity | Modele loading, success, error e respostas obsoletas. |
| **Pinia** | [`pinia-store-design`](rules/pinia-store-design.md) | Pinia Defining a Store | Separe estado global de estado local de UI. |
| **Pinia** | [`pinia-getters-pure`](rules/pinia-getters-pure.md) | Pinia Getters & Vue Computed | Mantenha getters puros e sem I/O. |
| **Pinia** | [`pinia-persistence`](rules/pinia-persistence.md) | Pinia State & Plugins | Persista somente subconjuntos validados e versionados. |
| **Pinia** | [`pinia-dependencies`](rules/pinia-dependencies.md) | Pinia Actions & Core I/O Rules | Injete gateways, storage, relógio e telemetry. |
| **Pinia Testing** | [`pinia-testing`](rules/pinia-testing.md) | Pinia Testing Cookbook | Isole stores e teste actions, getters e contratos públicos. |

---

## 🚀 Como Instalar e Sincronizar (`sync.sh`)

O instalador universal agnóstico prepara o ambiente desejado em seu projeto:

### 1. Ambientes Suportados
```bash
./sync.sh antigravity /caminho/para/seu-projeto-ts   # Google Antigravity
./sync.sh opencode    /caminho/para/seu-projeto-ts   # OpenCode
./sync.sh kilocode    /caminho/para/seu-projeto-ts   # Kilo Code
./sync.sh cursor      /caminho/para/seu-projeto-ts   # Cursor (.cursor/rules/*.mdc)
./sync.sh claude      /caminho/para/seu-projeto-ts   # Claude Code (CLAUDE.md)
./sync.sh copilot     /caminho/para/seu-projeto-ts   # GitHub Copilot
./sync.sh all         /caminho/para/seu-projeto-ts   # Todos os ambientes
```

### 2. Comandos Utilitários (Zero Token Waste CLI)
```bash
# Busca regras por palavra-chave ou conceito
./sync.sh find union

# Exibe o conteúdo completo de uma regra específica
./sync.sh query t-discriminated-unions

# Lista todas as regras disponíveis com seus imperativos
./sync.sh list

# Executa o suite de testes de integridade e verificação
./sync.sh verify

# Remove somente arquivos gerados, preservando conteúdo existente (ex: antigravity ou all)
./sync.sh clean antigravity /caminho/para/seu-projeto-ts
```

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para detalhes.
