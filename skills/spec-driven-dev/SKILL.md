---
name: spec-driven-dev
description: Scopes and writes a flexible spec-driven development doc set under spec/ — PROJECT (uppercase), then lowercase domain, architecture, ui-ux, data, behaviour, decisions, tests — pulling existing README and docs into the conversation, adapting depth to greenfield vs completing what already exists, and wiring AGENTS.md so agents respect the precedence order. Use when setting up or completing project specs, SDD docs, or a spec/ folder.
---

# Spec-driven development

## Goal

A `spec/` tree the project actually needs — not a full template dumped blank —
scoped with the operator, grounded in whatever README or docs already exist,
and an `AGENTS.md` (or update to it) that tells agents to treat that tree as
authoritative in a fixed precedence order.

## Context

Check first, before asking anything:

- Existing prose: `README`, `docs/`, `DESIGN.md`, `CONTRIBUTING`, ADRs,
  `AGENTS.md` / `CLAUDE.md` / `.cursor/rules`, issue templates, and any
  `spec/` already present. Read them; they answer questions you must not
  re-ask.
- Project shape: empty/near-empty folder, early codebase, or mature product.
  That chooses the mode (see Steps).
- Surfaces that imply which docs earn a file: UI present → ui-ux likely;
  persistence or schemas → data; multiple subsystems or flows → behaviour;
  prior ADRs or contested choices → decisions; automated or manual QA → tests.
- Do not invent a second documentation home. Everything this skill produces
  lives under `spec/`, except the AGENTS.md pointer at the project root.

## Spec inventory

Produce only what the project needs. Filenames and roles:

Only `PROJECT.md` is uppercase — it signals the top-level authority. Every
other path under `spec/` is lowercase (hyphenated where needed).

| Path | Audience | Contents |
| --- | --- | --- |
| `spec/PROJECT.md` | everyone | Main goal, main purpose, main requirements. |
| `spec/domain.md` | project manager | Entities, concepts, rules, invariants. |
| `spec/architecture.md` | tech | Structure, components, boundaries, interfaces, APIs, events, constraints. |
| `spec/ui-ux.md` | designer | Look and feel, themes, anti-patterns, best practices, usability and accessibility. |
| `spec/data.md` | tech | Contracts, models and persistence. |
| `spec/behaviour/` | tech / PM | Folder with detailed behaviour for the project systems (one file per system or flow). |
| `spec/decisions/` | tech / PM | Decision records for changes to the initial spec. |
| `spec/tests.md` | QA | How to test, how to verify acceptance criteria, when to test. |

Not every row is required. Skip ui-ux for a headless library; skip data when
there is no persistence story worth locking; start decisions empty or omit
until a change needs a record. Prefer fewer accurate files over a complete
skeleton of stubs.

## Steps

1. **Mode.** From Context, pick one and say it aloud to the operator:
   - **Scratch** — little or no product docs or code. Stay high level: goals,
     purpose, requirements, coarse domain and architecture. Do not run a
     tedious grilling session; prefer short confirmations and "you decide"
     defaults recorded as assumptions.
   - **Complete** — README, DESIGN, or partial `spec/` already exists. Diff
     what is covered against the inventory; only scope the gaps. Pull existing
     wording into the conversation and propose where it maps into `spec/`
     rather than rewriting from zero.
   - **Refresh** — `spec/` exists but is stale vs the code or README. Reconcile;
     prefer updating the authoritative section over duplicating elsewhere.

2. **Harvest.** Summarise what existing docs already settle (goal, users,
   stack, entities, constraints). Quote paths. Ask only for what remains
   unknown or contested.

3. **Scope with the operator.** Propose which of the inventory files this
   project should get, and which to skip, with one-line reasons. Agree the
   set before writing. One question at a time when choices branch; never dump
   an eight-file form. "You decide" means pick the minimal useful set and
   record it as an assumption.

4. **Fill depth by mode.**
   - Scratch: PROJECT first, then light domain and architecture if useful;
     defer ui-ux/data/behaviour/tests until there is something concrete to say.
   - Complete / Refresh: write gap sections at the fidelity the rest of the
     repo already uses — match tone and specificity, do not inflate.

5. **Write under `spec/`.** Create only the agreed files. For `behaviour/`,
   one markdown file per system or primary flow (`spec/behaviour/<system>.md`).
   For `decisions/`, use short records (`spec/decisions/NNNN-short-title.md`)
   when capturing a change to the initial spec; if none yet, either omit the
   folder or add a one-line `spec/decisions/README.md` explaining when to add
   one — do not invent fake decisions.

6. **Wire agents.** Create or update `AGENTS.md` at the project root so it
   states that this project uses spec-driven development under `spec/`, and
   that agents must respect specs in this order (higher wins on conflict):

   1. PROJECT
   2. domain, architecture
   3. ui-ux, data
   4. behaviour, decisions
   5. tests

   If `AGENTS.md` already has other rules, add a clear **Spec-driven
   development** section rather than replacing the file. Point at the paths
   that exist; do not list skipped files as required.

7. **Close the loop.** Show the operator the tree written and any open
   questions left for a later pass. Do not expand scope into implementation
   unless they ask.

## Constraints

- All generated spec content goes under `spec/`. The only root-level write
  this skill makes is `AGENTS.md` (create or update).
- Adapt to the project: it is not necessary to have all the files.
- Scratch mode stays high level — no multi-hour interviews, no fake precision.
- Prefer extracting and relocating truth from README/docs over inventing
  parallel prose that will drift.
- Do not scaffold application code, install dependencies, or change product
  behaviour as part of this skill.
- Do not invent entities, APIs, or behaviours the operator did not affirm and
  the repo does not evidence; mark unknowns instead.
- Decision records are for changes to the initial spec — not a dump of every
  chat preference.

## Done when

- The agreed subset of `spec/` files exists with real content (no empty
  placeholder sections unless explicitly marked TODO with why).
- `AGENTS.md` documents spec-driven development and the precedence order
  above, naming only files that were actually created (plus how to extend).
- Skipped inventory items were acknowledged to the operator with a reason.
- Existing README/docs were consulted and contradictions either resolved into
  `spec/` or listed as open questions.

## Output

1. **`spec/` tree** — only the agreed files, using the inventory paths.
2. **`AGENTS.md` section** — at minimum equivalent to:

   ```markdown
   ## Spec-driven development

   Authoritative product and engineering intent lives under `spec/`.
   When specs disagree, respect them in this order:

   1. PROJECT
   2. domain, architecture
   3. ui-ux, data
   4. behaviour, decisions
   5. tests

   Implement and review against these docs before inventing behaviour.
   ```

3. **Operator summary** — paths written, paths skipped (and why), and open
   questions for a later pass.
