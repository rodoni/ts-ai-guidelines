# TypeScript AI Guidelines & Agentic Tools

Conjunto modular de **Agentes de IA**, **SKILLS** e **Regras Atômicas** otimizados para desenvolvimento agêntico em TypeScript com **foco em baixíssimo consumo de contexto** (*Zero Token Waste*).

---

## 💎 Filosofia: Curadoria de Alto Impacto (*Curated Core*)

Tanto o [TypeScript Official Handbook](https://www.typescriptlang.org/docs/handbook/intro.html), quanto as [W3Schools & Community Best Practices](https://www.w3schools.com/typescript/typescript_best_practices.php) e o [Tweag Agentic Coding Handbook](https://tweag.github.io/agentic-coding-handbook/) contêm centenas de páginas e diretrizes dispersas.

Diferente de abordagens ingênuas que despejam livros inteiros na janela de contexto das LLMs — desperdiçando dezenas de milhares de tokens e gerando alucinações —, este ecossistema destila **as 40 regras mais críticas e fundamentais**:
1. **Solidez e Rigor do Sistema de Tipos**: Zero tolerância para `any`, `strict: true` inegociável, modelagem com uniões discriminadas e verificação exaustiva com `never`.
2. **Ergonomia e Imutabilidade de APIs**: Branded Types contra obsessão por primitivos, `readonly` por padrão, interfaces para contratos abertos e eliminação de `enum` numéricos em favor de literais `as const`.
3. **Performance de Runtime e Bundle**: Preservação de hidden classes do V8, coleções densas, `Map`/`Set` otimizados, eliminação de barrel files monolíticos e imports dinâmicos (`await import(...)`).
4. **Resiliência e Observabilidade Corporativa**: Validação em tempo de execução nas bordas (Zod/Valibot), telemetria estruturada sem `console.log` em produção e prevenção estrita de *floating promises*.
5. **Metodologia Agêntica Tweag**: Abordagem *Spec-First*, desenvolvimento guiado por testes (*TDD Loop*), portões determinísticos de verificação contínua (*Verification Gates*) e separação cognitiva de papéis (*Writer vs. Reviewer*).

> ⚡ **Zero Token Waste**: Cada regra é atômica (30 a 60 linhas), auto-contida e carregada **sob demanda** pelos agentes especializados.

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

### 📊 Matriz de Mapeamento: Agentes ➔ Skills ➔ Regras

| Agente | Skill Primária | Skills Secundárias | Regras Atômicas Enforced (`rules/*.md`) |
|---|---|---|---|
| **`ts-lead`** | [`ts-guidelines`](skills/ts-guidelines/SKILL.md) *(Master Hub)* | Todas as 5 skills temáticas | `wf-spec-first`, `wf-atomic-steps`, `wf-verification-gates`, `t-strict-mode` |
| **`ts-type-architect`** | [`ts-types`](skills/ts-types/SKILL.md) *(Tipagem Avançada)* | `ts-api`, `ts-perf` | `t-strict-mode`, `t-no-any`, `t-discriminated-unions`, `t-exhaustiveness-check`, `t-type-predicates`, `t-narrowing-in-operator`, `t-exact-optional`, `t-const-assertions`, `t-generics-constraints`, `t-generics-simplicity`, `c-interface-vs-type`, `c-readonly-immutability`, `c-branded-types`, `c-return-annotations`, `c-avoid-enums`, `c-custom-type` |
| **`ts-perf-optimizer`** | [`ts-perf`](skills/ts-perf/SKILL.md) *(Performance & Bundle)* | `ts-api`, `ts-types` | `perf-map-set`, `perf-sparse-arrays`, `perf-hidden-classes`, `perf-tree-shaking`, `perf-lazy-imports`, `perf-type-imports`, `perf-regex-reuse` |
| **`ts-safety-auditor`** | [`ts-resilience-app`](skills/ts-resilience-app/SKILL.md) *(Segurança & Bordas)* | `ts-types`, `ts-api` | `m-app-error`, `m-validate-inputs`, `m-log-not-print`, `m-no-floating-promises`, `m-lint-override-expect`, `m-mockable-io`, `m-doc-contracts` |
| **`ts-reviewer`** | [`ts-agentic-workflow`](skills/ts-agentic-workflow/SKILL.md) *(Compliance & Gates)* | `ts-types`, `ts-api`, `ts-resilience-app`, `ts-perf` | Todas as 40 regras atômicas auditadas sob protocolo multi-pass com *Zero Omission Policy*. |

---

## 📦 SKILLS Modulares (`skills/`)

As diretrizes são organizadas em skills temáticas carregadas sob demanda:

1. **[`ts-guidelines`](skills/ts-guidelines/SKILL.md)**: Hub mestre com tabela de prioridades e índices para todas as regras.
2. **[`ts-types`](skills/ts-types/SKILL.md)**: Sistema de tipos estrito, narrowing, discriminated unions e constraints.
3. **[`ts-api`](skills/ts-api/SKILL.md)**: Ergonomia de APIs públicas, imutabilidade com `readonly`, branded types e builders.
4. **[`ts-perf`](skills/ts-perf/SKILL.md)**: Otimizações V8, estruturas Map/Set, tree-shaking e import type.
5. **[`ts-resilience-app`](skills/ts-resilience-app/SKILL.md)**: Resiliência, validação com Zod, telemetria estruturada e Promises.
6. **[`ts-agentic-workflow`](skills/ts-agentic-workflow/SKILL.md)**: Metodologia Tweag (Spec-First, TDD Loop, Verification Gates e Writer/Reviewer).

---

## ⚡ Regras Atômicas de Baixo Contexto (`rules/`)

Cada regra em [`rules/`](rules/) possui entre 30 e 60 linhas e segue a estrutura padronizada:
- **Imperativo de 1 linha**: Orientação técnica imediata.
- **Why It Matters**: Explicação concisa do mecanismo e impacto técnico no compilador ou runtime.
- **Applicability Scope**: Definição explícita do escopo (universal, limites de borda, hot paths, APIs públicas).
- **Bad**: Snippet curto em TypeScript demonstrando o antipadrão.
- **Good**: Snippet corrigido, defensivo, idiomático e com zero desperdício de recursos.
- **See Also**: Links correlatos para outras regras do ecossistema.

### 📋 Catálogo Completo das 40 Regras Atômicas

| Categoria | Regra | Origem | Diretriz Atômica |
|---|---|---|---|
| **Sistema de Tipos & Rigor** | [`t-strict-mode`](rules/t-strict-mode.md) | TS Handbook | Always enable `strict: true` and all additional strict family compiler flags in `tsconfig.json`. |
| **Sistema de Tipos & Rigor** | [`t-no-any`](rules/t-no-any.md) | TS Handbook & W3Schools | Never use the `any` type; use `unknown` for unchecked values and narrow before usage. |
| **Sistema de Tipos & Rigor** | [`t-discriminated-unions`](rules/t-discriminated-unions.md) | TS Handbook | Model polymorphic domains and state machines using discriminated unions with a common literal tag property. |
| **Sistema de Tipos & Rigor** | [`t-exhaustiveness-check`](rules/t-exhaustiveness-check.md) | TS Handbook | Enforce compile-time exhaustiveness checking on union branches using the `never` type and an `assertNever` helper. |
| **Sistema de Tipos & Rigor** | [`t-type-predicates`](rules/t-type-predicates.md) | TS Handbook | Implement custom type predicates (`value is Type`) with rigorous runtime checks instead of blind type assertions. |
| **Sistema de Tipos & Rigor** | [`t-narrowing-in-operator`](rules/t-narrowing-in-operator.md) | TS Handbook | Use `typeof`, `instanceof`, and `'prop' in obj` operators for safe structural narrowing without type assertions. |
| **Sistema de Tipos & Rigor** | [`t-exact-optional`](rules/t-exact-optional.md) | TS Handbook | Distinguish between omitted optional properties and explicit `undefined` values using `exactOptionalPropertyTypes`. |
| **Sistema de Tipos & Rigor** | [`t-const-assertions`](rules/t-const-assertions.md) | TS Handbook | Use `as const` on literal objects, arrays, and tuples to preserve literal types and enforce deep immutability. |
| **Sistema de Tipos & Rigor** | [`t-generics-constraints`](rules/t-generics-constraints.md) | TS Handbook | Constrain generic type parameters (`T extends Base`) rather than using unbounded generics. |
| **Sistema de Tipos & Rigor** | [`t-generics-simplicity`](rules/t-generics-simplicity.md) | TS Handbook | Avoid generic over-engineering; prefer concrete types or minimal type parameters where type inference suffices. |
| **API & Ergonomia** | [`c-interface-vs-type`](rules/c-interface-vs-type.md) | TS Handbook & W3Schools | Prefer `interface` for extensible object contracts and public APIs; prefer `type` for unions, intersections, primitives, and tuples. |
| **API & Ergonomia** | [`c-readonly-immutability`](rules/c-readonly-immutability.md) | TS Handbook & W3Schools | Mark object properties and arrays as `readonly` to prevent accidental state mutations and side effects. |
| **API & Ergonomia** | [`c-branded-types`](rules/c-branded-types.md) | TS Handbook (Advanced) | Use Branded Types (nominal typing) to prevent primitive obsession and accidental argument swapping. |
| **API & Ergonomia** | [`c-return-annotations`](rules/c-return-annotations.md) | TS Handbook & Tweag | Always explicitly annotate function return types on exported module boundaries and public APIs. |
| **API & Ergonomia** | [`c-avoid-enums`](rules/c-avoid-enums.md) | TS Best Practices | Prefer union of string literals or `as const` objects over TypeScript numeric and string `enum`. |
| **API & Ergonomia** | [`c-custom-type`](rules/c-custom-type.md) | TS Best Practices | Convey domain intent through dedicated domain types and literal unions rather than ambiguous boolean flags. |
| **API & Ergonomia** | [`c-naming-conventions`](rules/c-naming-conventions.md) | W3Schools & Style Guides | Follow idiomatic TypeScript casing conventions strictly across all identifiers. |
| **API & Ergonomia** | [`c-builder-pattern`](rules/c-builder-pattern.md) | Best Practices | Use the Builder pattern with validation for complex or incrementally configured domain objects. |
| **API & Ergonomia** | [`c-weasel-words`](rules/c-weasel-words.md) | Clean Code & Tweag | Eliminate vague weasel words (`Helper`, `Manager`, `Data`, `Info`, `Util`) from type, class, and module names. |
| **API & Ergonomia** | [`c-dont-leak-internals`](rules/c-dont-leak-internals.md) | Best Practices | Encapsulate internal library dependencies and types; export only intentional public API surfaces. |
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
| **Resiliência & Telemetria** | [`m-doc-contracts`](rules/m-doc-contracts.md) | TS Handbook & Tweag | Document public module functions with structured JSDoc containing `@param`, `@returns`, `@throws`, and runnable `@example`. |
| **Metodologia Tweag** | [`wf-spec-first`](rules/wf-spec-first.md) | Tweag Handbook | Always draft and review a technical specification and task decomposition before writing code. |
| **Metodologia Tweag** | [`wf-tdd-loop`](rules/wf-tdd-loop.md) | Tweag Handbook | Develop guided by tests (TDD): write or define automated tests before implementing feature logic. |
| **Metodologia Tweag** | [`wf-verification-gates`](rules/wf-verification-gates.md) | Tweag Handbook | Never advance an agentic coding task without passing deterministic feedback gates (`tsc --noEmit`, ESLint, tests). |
| **Metodologia Tweag** | [`wf-writer-reviewer`](rules/wf-writer-reviewer.md) | Tweag Handbook | Separate the creative coding persona from the critical compliance reviewer persona to eliminate confirmation bias. |
| **Metodologia Tweag** | [`wf-design-for-ai`](rules/wf-design-for-ai.md) | Tweag Handbook | Design TypeScript APIs, types, and modules for AI comprehension: explicit types, pure functions, and testable contracts. |
| **Metodologia Tweag** | [`wf-atomic-steps`](rules/wf-atomic-steps.md) | Tweag Handbook | Decompose complex development tasks into small, incremental, and independently verifiable steps. |

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

# Remove arquivos de diretrizes de forma limpa (ex: antigravity ou all)
./sync.sh clean antigravity /caminho/para/seu-projeto-ts
```

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para detalhes.
