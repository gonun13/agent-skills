---
name: stack-advise
description: Reviews a project's whole stack — languages, tooling, tests, CI, observability, conventions — and recommends the specific tools, libraries, and practices that would make it more professional, ranked by payoff against effort. Use when a project has grown past its tooling or before opening it to more contributors.
---

# Stack advise

## Goal

A short, ranked list of changes to how this project is built, checked, shipped,
and observed, each justified by something missing or weak in this repo and
proportionate to its size and stage — not a tour of what is fashionable.

## Context

Check first:

- What the project is, who uses it, and how mature it is: README, manifest,
  version, release history, contributor count, issue tracker. A weekend tool
  and a service other teams depend on deserve different recommendations.
- The stack as it stands: languages and versions, frameworks, package manager,
  build tool, test runner, and the lockfile.
- What is already in place, so you do not recommend it: linter and formatter
  configs, type-checking settings, pre-commit hooks, `.editorconfig`, CI
  workflows, release automation, dependency-update bots, coverage tooling,
  logging and metrics libraries, error reporting, health endpoints,
  `CONTRIBUTING`, `SECURITY.md`, `LICENSE`, `CHANGELOG`, ADRs, `AGENTS.md`.
- How the project's ecosystem does things. Recommend the tools its language
  community has settled on, not the ones you know from another.
- Signs of pain in the history: `git log` for repeated "fix lint", "fix CI",
  "bump version" commits, reverted releases, or long-lived flaky tests. Each
  is evidence for a specific recommendation.

## Steps

1. Write down what the project already does well before looking for gaps.
   Judge every recommendation against the stage and size you established; the
   question is what this project needs next, not what a large one has.
2. Quality of implementation: linting, formatting, static typing or type
   checking, test runner and structure, coverage reporting, mutation or
   property testing where the domain warrants it, and whether checks run
   locally before they run in CI (pre-commit, git hooks, a single `make check`
   or equivalent).
3. Consistency: one package manager, a committed lockfile, pinned tool
   versions (`.tool-versions`, `.nvmrc`, `rust-toolchain`, ...), a reproducible
   development environment (devcontainer, Nix, Docker) if setup is more than
   one command, and whether CI runs the same commands a developer does.
4. Delivery: CI that runs tests on every change, branch protection
   expectations, automated releases and version bumps, a changelog,
   dependency-update automation (Dependabot, Renovate), and a documented
   release process.
5. Observability, where the project runs as a service or long-lived process:
   structured logging with levels and correlation IDs, metrics, tracing, error
   reporting, health and readiness endpoints, and whether failures are
   distinguishable from a log line. Skip this section for a library or a
   one-shot CLI and say so.
6. Security posture: secret scanning, dependency vulnerability scanning, SAST
   in CI, a `SECURITY.md`, signed or provenance-attested releases where the
   ecosystem supports them, and least-privilege CI permissions.
7. Standards and contribution: `LICENSE`, `CONTRIBUTING`, a code of conduct
   where the project is open, issue and PR templates, commit conventions, ADRs
   for decisions already visible in the code, and an `AGENTS.md` or
   equivalent if agents work in the repo.
8. For each gap, name one specific tool or practice — the ecosystem's default
   unless there is a reason recorded in the repo not to — and the smallest
   first step that adopts it. Estimate effort as `hours`, `days`, or
   `ongoing`, and payoff as what goes wrong today without it.
9. Rank by payoff against effort. Cap the list at ten. If more than ten
   things qualify, the ranking is the deliverable, not the count.

## Constraints

- Read only. Recommend; do not install, configure, or scaffold anything.
- Never recommend replacing the language, framework, database, or hosting.
  Those are decisions this project has made; work within them.
- Do not recommend what is already there. If something is present but
  misconfigured or unused, that is a finding about the configuration, not a
  recommendation to add it.
- Every recommendation cites the evidence from this repo that motivates it, as
  `path:line` or a `git log` observation. No evidence, no recommendation.
- Proportion. A recommendation that would cost more to run than the project
  costs to maintain is wrong regardless of merit. Say when something is
  premature and what would make it worth revisiting.
- Prefer the ecosystem's settled choice over a newer or more capable tool.
  Name an alternative only when the settled choice has a concrete
  disadvantage here.
- No taste. Style preferences, naming, and architecture opinions are not
  stack advice unless a tool would enforce them mechanically.

## Done when

Every area in steps 2–7 has been assessed against what the repo contains,
each recommendation names one tool or practice, one first step, evidence,
effort, and payoff, and the list is ranked and at most ten items long.

## Output

Open with two or three lines: what the project is, its stage, and where its
tooling stands overall.

**Already solid** — what is in place and working, one line per item. Brief;
this tells the reader what you checked.

**Recommendations** — ranked, at most ten:

| # | Recommendation | Area | Evidence | First step | Effort | Payoff |
| --- | --- | --- | --- | --- | --- | --- |

`Area` is one of quality, consistency, delivery, observability, security,
standards. `Evidence` is `path:line` or a `git log` observation. `First step`
is a single command or file to add.

Close with two short lists:

- **Not yet** — things that would be reasonable later, and what would trigger
  them.
- **Not assessed** — areas skipped and why (for example, observability for a
  library).
