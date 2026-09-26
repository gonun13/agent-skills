---
name: refactor-oop
description: Regroups a codebase into a layered OOP file structure — domain (entities, interfaces, abstracts, traits), services, and infrastructure (modules, components, repositories) — by moving and splitting existing code, without changing behaviour or public contracts. Use when asked to organise a project into OOP layers, clean/layered architecture folders, or to group code into modules, components, services, and interfaces.
---

# Refactor to OOP layers

## Goal

The same program, regrouped so every file sits in the layer its responsibility
belongs to — domain, service, or infrastructure — with each move proven
behaviour-preserving by the project's own checks.

## Context

Check first:

- Language, framework, and their conventions. A framework that fixes its own
  layout (Rails, Laravel, Django, Next.js, Spring, Angular, ...) wins: fit the
  layers inside it, never fight it.
- What the project has already decided: `spec/`, ADRs, `AGENTS.md`,
  `CLAUDE.md`, `README`, `docs/`. A structure chosen and written down is an
  answer, not a finding.
- The build, test, and lint commands, plus anything that resolves paths
  outside the import graph: autoloaders (`composer.json` PSR-4), path aliases
  (`tsconfig.json`, bundler config), package `__init__.py`/`mod.rs`/`index`
  files, DI container config, routes, CI, and Dockerfiles.

## The target layers

Only create a folder once something real goes in it.

| Layer | Holds | Depends on |
| --- | --- | --- |
| **Domain** | Entities/models, value objects, and the rules that belong to them. `interfaces/` for contracts, `abstracts/` for shared base classes, `traits/` for reusable behaviour mixed into several entities (e.g. `Timestampable`). | Nothing outside the domain. |
| **Services** | Domain services — rules spanning several entities (e.g. `TransferMoneyService`). Application services — one use case each: fetch, call the domain, save. | Domain only, and infrastructure only through domain interfaces. |
| **Infrastructure** | Repositories that implement domain interfaces, and adapters for databases, HTTP, queues, files, and third-party APIs. | Domain, services, and external libraries. |
| **Components** | Reusable UI elements or standalone utilities with no business rules. | Whatever they wrap, never a feature module. |
| **Modules** | A feature (`auth`, `billing`) grouped as one folder, with its own domain/services/infrastructure inside when big enough to earn them. | Other modules only through their public entry point. |

Translate the words to the language rather than forcing them: interface =
`interface` / `Protocol` or `ABC` / Go interface / Rust trait / TS `type`;
trait = PHP `trait` / Python mixin / TS mixin or composed function / Rust
default trait method. Where the language has no such construct, don't invent
one.

**Layer-first or module-first.** Small codebase with one feature area →
layer-first (`src/domain`, `src/services`, `src/infrastructure`,
`src/components`). Several feature areas → module-first
(`src/modules/<feature>/{domain,services,infrastructure}`), with truly shared
code in `src/shared/` or the framework's equivalent. Pick one and state it.

## Steps

1. **Baseline.** Run the build, test, and lint commands once and record the
   result, so you know which failures you inherited.
2. **Map.** Classify every source file by what it does, not by its name: domain
   logic, orchestration, I/O, UI, utility, or mixed. Mixed files are the split
   candidates.
3. **Propose the tree.** Show the target layout as a tree with a
   `old path → new path` list, and flag each split. In a read-only session,
   stop here — that list is the output.
4. **Move first, change nothing.** Relocate files that already have a single
   responsibility, one layer at a time, updating imports, namespaces,
   autoloaders, aliases, and config in the same step. Use `git mv` so history
   follows. Rerun the checks after each layer.
5. **Split what is mixed.** Where one file does two layers' work, pull the
   domain rule out of the I/O (or the UI), keeping the original public names
   importable if anything outside the repo might use them.
6. **Extract contracts only at a boundary.** Add an interface when domain or
   service code calls infrastructure directly — the repository pattern — so
   the dependency points inward. Add an abstract or trait only when two or more
   classes already duplicate the code it would hold.
7. **Validate.** Rerun build, test, and lint; the result must match step 1.

## Constraints

- Behaviour-preserving only. Same inputs, same outputs, same public API, same
  routes, same schema, same config keys. A behaviour change is a bug, not a
  refactor.
- No deep spec changes: don't rewrite `spec/` or ADRs to fit the new layout —
  only correct paths they cite, and propose anything more.
- No overengineering. No interface with one implementation unless it inverts a
  dependency on infrastructure; no base class for a single child; no factory,
  DI container, event bus, or new dependency the project didn't already have;
  no empty folders or placeholder files.
- Keep the project's naming, casing, and file-per-class conventions.
- Don't touch generated code, vendored code, migrations, or `.env` files.
- Past what the steps allow — e.g. a module that needs its data model redesigned
  to separate cleanly — propose instead of doing it.

## Done when

Every source file sits in one layer (or is listed as deliberately left); no
domain file imports infrastructure or a framework; build, test, and lint match
the baseline; and no public API, route, schema, or config key changed.

## Output

Open with one line: the language/framework, layer-first or module-first, and
the scope.

Then:

- **Tree** — the resulting layout.
- **Moves** — `old path → new path`, grouped by layer.
- **Splits and contracts** — each new file, interface, abstract, or trait, as
  `path:line`, and why it earned its place.
- **Checks** — the commands run, before and after.
- **Left alone** — files that didn't fit cleanly, and what would settle them.
