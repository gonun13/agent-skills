---
name: docs-drift
description: Checks the README, docs, help text, and example config against what the code actually does, and reports every place they disagree. Use when documentation may have fallen behind the code, or before a release.
---

# Docs drift

## Goal

A list of every claim the project's documentation makes that the code no longer
backs up — and every behaviour the code has that the documentation never
mentions — each as a `path:line` pair the operator can act on.

## Context

Check first:

- Where the prose lives: `README`, `docs/`, `CONTRIBUTING`, `CHANGELOG`,
  `AGENTS.md` or `CLAUDE.md`, man pages, docstrings on the public surface,
  and inline `--help` or usage text.
- Where the truth lives: the CLI or argument parser, the route table, the
  config loader, the environment-variable reads, the package manifest's
  scripts and entry points, `Makefile` targets, and CI workflow steps.
- `.env.example`, sample configs, and docker-compose files — documentation in
  disguise, and the most likely to be stale.
- `git log` on the docs versus the code they describe. A README last touched
  two years before the CLI it documents is the first place to look.

## Steps

1. Inventory the documented surface: every command, subcommand, flag, option,
   environment variable, config key, endpoint, default value, exit code, file
   path, and version requirement that any document states. Note where each
   claim is made.
2. Inventory the real surface from the code: the same categories, read from
   the parser, loader, router, and manifest — not from comments or docstrings,
   which are documentation too.
3. Compare the two lists in both directions:
   - Documented but absent: the docs describe something the code no longer
     has, or never had.
   - Present but undocumented: the code accepts a flag, reads a variable, or
     exposes an endpoint no document mentions.
   - Both present but disagreeing: a different default, type, name, required
     status, or behaviour.
4. Run what can be run offline: every command the docs tell the reader to
   type, against the repo itself, where it is safe and has no side effects.
   Install and quick-start instructions are the most-read and least-checked
   lines in any project.
5. Check the examples: code snippets, sample requests, and sample output. An
   example that would not compile, parse, or run today is drift.
6. Check the links: relative paths to files that moved, anchors to headings
   that were renamed, and references to CI badges, issue templates, or scripts
   that no longer exist. External URLs are noted, not fetched.
7. Classify each finding by what a reader loses: `misleading` when following
   the docs fails or does the wrong thing, `missing` when a real capability is
   invisible, `stale` when the docs are merely out of date but harmless.

## Constraints

- Read only. Drift has two possible fixes — change the docs or change the code
  — and which one is right is a product decision, not yours. Report both sides
  and let the operator choose.
- Offline. Do not fetch external URLs, install anything, or run commands with
  side effects. A command from the docs is run only when it is plainly safe.
- Never read `.env` or other environment files. `.env.example` and the
  variable names the code reads are enough.
- Judge from the code, not from what seems likely. If the code is ambiguous,
  say so rather than guessing which side is right.
- Prose quality, tone, and structure are not drift. Only report disagreement
  between what is written and what is true.

## Done when

Every command, flag, variable, config key, endpoint, and default in the
documented surface has been matched against the code, every one in the code
has been matched against the docs, and every disagreement is listed with both
locations.

## Output

Open with one line: how many findings, and whether any are `misleading`.

Then one table:

| Docs | Code | Claim | Reality | Class |
| --- | --- | --- | --- | --- |

`Docs` and `Code` are `path:line`; use `—` for the side that is absent. Order
by class: `misleading`, then `missing`, then `stale`.

Close with two short lists:

- **Could not verify** — claims that depend on a live service, an external
  URL, or an environment you could not reproduce, and what would settle each.
- **Not inspected** — documents or code paths left out of scope, and why.
