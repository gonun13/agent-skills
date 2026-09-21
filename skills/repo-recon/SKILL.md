---
name: repo-recon
description: Surveys an unfamiliar codebase — what it is, how it builds, and where to start. Use when orienting in a repo you have not worked in before.
---

# Repo recon

## Goal

An orientation briefing accurate enough that a competent engineer who has never
seen this repository can start work from it.

## Context

Check first: the README, the package or build manifest (`package.json`,
`pyproject.toml`, `go.mod`, `Cargo.toml`, `pom.xml`, ...), any `CONTRIBUTING`
file, and the `docs/` entry point.

## Steps

1. Identify what the project is and who it is for.
2. Determine the languages, frameworks, and how it is built, run, and tested.
   Quote the actual commands from the manifest or CI config rather than assuming
   the conventional ones.
3. Map the top-level layout, one line per significant directory. Skip vendored
   code, lockfiles, build output, and dependency directories.
4. Find the entry points: `main`, server bootstrap, CLI definition, exported
   package surface, or route table.
5. Locate the tests: where they live, which runner, and roughly how much of the
   codebase they appear to cover.
6. Note the operational surface: configuration files, environment variables,
   secrets handling, CI workflows, deploy or container definitions.
7. Check `git log --oneline -20` and the branch layout for where work is
   currently concentrated.

## Constraints

- Read only. Do not change files, propose refactors, or argue for a redesign.
- Quote what the repo says; when something cannot be determined, say so and name
  the file that would answer it.

## Done when

Every section below is filled from evidence in the repo, with unresolved items
listed under Unknowns rather than guessed at.

## Output

One section each, in this order:

- What this is
- Stack
- Build / run / test
- Layout
- Entry points
- Tests
- Configuration and secrets
- Where the work is
- Unknowns

Reference files as `path:line`.
