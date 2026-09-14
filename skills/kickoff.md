---
name: kickoff
description: Interviews the operator about a brand-new project in an empty or near-empty folder — name, goal, users, happy path, MVP scope, constraints, stack, high-level architecture — checks the web for current best practice on anything left open, and writes it up as a design doc with genuinely contested decisions left as open questions. Use before any code exists, when starting a project from scratch.
---

# Kickoff

## Goal

A `DESIGN.md` at the project root that a competent engineer could start building
from: what it is, who it's for, the one flow that must work, what's in and out
of the MVP, the stack and architecture with rationale, and an explicit list of
what's still undecided.

## Context

Check first:

- The folder itself. List it. A stray `README`, notes file, `.git` remote,
  half-written manifest, or ticket export can answer several questions before
  you ask them — read those before interviewing.
- Whether this is actually the right skill. If the folder already has a real
  codebase (more than scaffolding, a manifest with real dependencies, meaningful
  commit history), stop and point to `repo-recon` or `stack-advise` instead —
  this skill is for before code exists, not for auditing what's there.
- Today's date and that your stack knowledge has a cutoff. Framework defaults,
  hosting options, and "the current recommended way" to do something shift
  every few months; treat your own memory as a starting hypothesis to check,
  not the answer.

## Steps

1. Interview the operator in loose, grouped batches — not one long form, and
   not one question at a time either. "You decide" is always a valid answer to
   any question; treat it as permission to make the call yourself and record it
   as an assumption, not as a blocker.
   - **What & why** — project name, one-line pitch, the problem it solves,
     who it's for, what success looks like.
   - **Scope** — the single happy-path flow that must work end to end; what's
     in the MVP; explicit non-goals (what it deliberately will not do, at least
     at first).
   - **Constraints** — platform/runtime target, deployment or hosting
     preference, team size and skill level, timeline, budget, and anything
     mandated or forbidden (compliance, an existing company stack, a client
     requirement).
   - **Stack & scale** — preferred languages/frameworks if the operator has
     one; expected scale (prototype, internal tool, public production
     service); integrations or external dependencies (auth, payments, third
     -party APIs); how sensitive the data is.
2. For anything left open, weakly held, or answered "you decide," search the
   web for what's currently recommended for a project of this shape and scale
   — don't rely on memorized defaults, since they go stale. Note what you
   actually found, not just a conclusion.
3. Sketch an architecture proportionate to the stated scale: components,
   how they talk, where state lives, what's client vs server vs background.
   A weekend tool gets a paragraph and maybe one diagram; a stated production
   service gets more, but still no more than the operator's constraints
   justify.
4. Rough out the data model at the level of entities and relations — names and
   how they connect, not column types or a full schema.
5. For each meaningfully contested decision (framework A vs B, monolith vs a
   split, one library vs another, SQL vs NoSQL) where reasonable engineers
   would differ and the cost of being wrong is still low this early, present
   it as an option with a one- or two-line tradeoff rather than silently
   picking one. This is what goes into Open Questions.
6. Write `DESIGN.md` at the project root using the structure under Output.

## Constraints

- This produces a document, not a project. Do not scaffold files, run a
  generator, `git init`, or install dependencies — that's follow-up work the
  operator asks for separately, once the doc is agreed.
- Don't ask everything at once, and don't block on an answer — a shrug or "you
  decide" moves you forward with a recorded assumption instead.
- Decisions that are expensive to reverse later (primary language, hosting/data
  residency, monolith vs multi-service, anything compliance-driven) are worth
  a real answer from the operator; decisions that are cheap to reverse or pure
  taste get a sensible default, recorded as an assumption, not a question.
- Ground every stack or architecture recommendation in a web check done now.
  Say what you searched and what you found, briefly — enough for the operator
  to judge whether to trust it.
- Match ambition to what was actually described. No microservices, message
  queues, or Kubernetes for a weekend script; don't hand a stated production
  system with real users a design that ignores auth, backups, or multi-tenant
  concerns.
- Never silently resolve a genuinely open, low-cost-to-defer decision. Leaving
  it open and letting the operator experiment is the correct output here, not
  a gap.

## Done when

`DESIGN.md` exists at the project root, every section below has content — from
an operator answer, a sourced recommendation, or a marked assumption — and no
code or scaffolding has been created.

## Output

`DESIGN.md`, in this order:

- **Overview** — name, one-line pitch, problem, who it's for, what success
  looks like.
- **Non-goals** — what this deliberately will not do, at least at first.
- **Happy path** — the one primary flow, start to finish, in plain language.
- **MVP scope** — in vs later, as two short lists.
- **Architecture** — components, how they talk, where state lives; a short
  ASCII or prose diagram if it earns its place.
- **Data model** — entities and how they relate, at a glance.
- **Stack** — each major choice with a one-line rationale; note where it came
  from a web check and what the check found.
- **Non-functional requirements** — anything on scale, security/privacy,
  compliance, offline support, i18n that the operator named or that the
  stated scale implies.
- **Assumptions** — defaults you picked when the operator said "you decide,"
  each in one line.
- **Open questions** — contested decisions left for the operator, each with
  the options and their tradeoff in one or two lines.
