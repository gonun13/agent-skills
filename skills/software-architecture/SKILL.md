---
name: software-architecture
description: Measures a codebase against twelve architecture principles and either refactors toward them, documents where it falls short, or runs one principle's pass that you pick. Use when asked to refactor toward better structure, review or document a system's architecture, or check whether something is well shaped.
---

# Software architecture

## Goal

The codebase measurably closer to the twelve principles below, or a ranked
account of where it is not — every claim tied to a principle file and a
`path:line`, and every change proven behaviour-preserving by the project's own
checks.

## Context

**Find the principle files first.** Each one carries the principle, why it
holds, what it looks like in practice, how to tell it is being violated, and a
`## Pass` section giving what to look for, what a safe fix is, and where to
stop. Nothing is loaded for you. Try, in order:

1. `principles/` beside this `SKILL.md`.
2. `../agent-skills/skills/software-architecture/principles/` — this repo is
   normally cloned beside the projects it is run against.
3. Any `software-architecture-principles/` already vendored inside the project.

If none resolve, say so once and work from the index below alone. That is the
degraded mode: still useful, but cite the index rather than inventing detail,
and never invent a thirteenth principle.

**The index.** One file per principle, numbered in reading order. The numbering
is not a ranking — a real decision usually turns on two or three at once.

| File | Principle | Reach for it when |
| --- | --- | --- |
| `01-separation-of-concerns.md` | One concern, one place. | A small change opens files in four layers. |
| `02-single-responsibility.md` | One reason to change per component. | Something has grown an "and", or has no clear owner. |
| `03-encapsulation-through-contracts.md` | What is public is a promise. | Callers depend on internals, or something cannot be renamed. |
| `04-dependency-inversion.md` | Business rules must not import frameworks. | An upgrade breaks domain logic, or the ORM entities *are* the model. |
| `05-explicit-dependencies.md` | Declared and passed in, never reached for. | A test needs a global patched, or a deploy fails on a missing setting. |
| `06-loose-coupling-high-cohesion.md` | The two questions at every boundary. | Deciding whether to split something, or why a split is not helping. |
| `07-bounded-contexts-and-clear-ownership.md` | One meaning per term, one owner per area. | A word means different things to different people. |
| `08-data-ownership-and-data-contracts.md` | One writer per dataset. | Shared databases, schema migrations, and who may delete. |
| `09-design-for-failure.md` | Timeouts, retries, idempotency. | Anything with a network in it, or a slow dependency. |
| `10-observability-is-architecture.md` | Correlation and structured events, designed in. | Asking how this will be diagnosed in production. |
| `11-prefer-simplicity.md` | Complexity has to be earned. | Before adding a service, a cache, an abstraction, or an option. |
| `12-record-decisions-and-guardrails.md` | Write the reason down, then make it checkable. | A decision is worth not having again. |

## Steps

1. **Pick the mode** and state it in one line before touching anything:
   - The operator named a mode, or named a principle by number or title → obey
     that.
   - Otherwise, writes are permitted → **refactor**.
   - Otherwise, the session is read-only → **document**.
   - Otherwise → **ask**: list the twelve with their numbers, take a selection
     (`all`, or e.g. `04 09`), and ask refactor-or-document once. Ask once,
     then commit. This is a selection, not an interview.

2. **Survey.** In every mode. Say what the scope is — the whole tree, a
   directory, or a change (`git diff`, a branch) — before reading. Then:
   - Read what the project has already decided: `spec/`, ADRs, `AGENTS.md`,
     `CLAUDE.md`, `README`, `docs/`. A departure that was chosen deliberately
     and written down is an answer, not a finding.
   - Learn the build, test and lint commands and run them once, so you know
     which failures you inherited.

3. **Read the principle files in scope** — all twelve, or only the ones
   selected — before judging anything. Every finding cites the file it came
   from.

4. **Refactor.** One principle at a time, in index order, smallest safe change
   first, inside that file's `Safe fix` and never past its `Stop at`. Take the
   cheap gains: a file the work is already touching is the cheapest chance that
   file has of coming closer to these. Re-run the project's checks after each
   principle and confirm the result matches step 2 — a behaviour change is a
   bug, not a refactor. Anything past `Stop at` is written up as a proposal
   instead of done.

5. **Document.** The same survey with no edits: rank the gaps by what leaving
   them costs, each with `path:line`, the principle file, the symptom from that
   file's "How to tell it is being violated", and the size of the fix. Then
   offer to write it — `spec/decisions/NNNN-<short-title>.md` if that tree
   exists, otherwise `docs/architecture-review.md` — and write it only if the
   operator says yes.

6. **Ask** runs step 4 or 5 narrowed to the chosen principles, and says which
   principles were not examined.

7. **Name the conflicts.** Where two principles pulled opposite ways, say which
   one gave way and why. Two principles disagreeing is the normal case, not a
   contradiction to report; that sentence is the reasoning, and it is the part
   a reader months from now needs.

## Constraints

- Never trade behaviour for shape. Every refactor is behaviour-preserving, and
  the project's own checks are what prove it.
- Do not widen the change you were asked for. Past a `Stop at`, propose — say
  what you would do and why, and let whoever is deciding decide.
- Shape only. These principles settle nothing about language, library, naming,
  formatting, test framework, deployment target or process.
- A recorded decision that departs from a principle has answered the question.
  What these outrank is a preference nobody wrote down.
- In document mode, write no file until the operator says yes to it.
- No new dependencies, services, caches, or abstractions.
  `11-prefer-simplicity.md` applies to this skill's own output.

## Done when

The mode and scope were stated; every principle in scope was either applied or
explicitly deferred with a reason; the project's build, test and lint commands
give the same result they gave in step 2; and nothing was changed past a
`Stop at`.

## Output

Open with one line: the mode, the scope, and which principles were examined.

Then one section per principle that produced something, in index order:

- **Refactor** — what changed, as `path:line`, and why it was safe.
- **Document** — the gap, as `path:line`, the symptom, and the size of the fix.

Close with:

- **Left alone** — what sat past a `Stop at`, or was blocked, and what would
  settle it.
- **Conflicts** — where two principles pulled opposite ways, which gave way,
  and why.
- **Not examined** — principles out of scope, in ask mode.