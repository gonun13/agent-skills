---
name: janitor
description: Removes dead code, unused dependencies, test leftovers, verbose comments, and hardcoded secrets, and keeps .gitignore current. Use when cleaning up or tidying a codebase.
---

# Janitor

## Goal

Leave the codebase smaller and cleaner than you found it, with every behaviour
still intact.

## Context

Check first:

- The build/test/lint commands the project actually uses, and its dependency
  manifest and lockfile.
- Whatever dead-code, unused-dependency, or secret-scanning tooling the project
  already has (linter rules, `knip`, `ts-prune`, `vulture`, `depcheck`,
  `cargo-udeps`, `gitleaks`, ...). Prefer its tools over your own judgement.
- `git status` and `.gitignore`, to tell committed files from local litter.

## Steps

1. Run the project's checks once before touching anything, so you know which
   failures you inherited.
2. Dead code: find unreferenced files, exports, functions, and flags. Confirm
   each is unused across the whole repo — including dynamic imports, reflection,
   config, and CI — before deleting it.
3. Dependencies: drop packages with no remaining references and update the
   lockfile with the project's own package manager.
4. Test residue: delete artifacts, fixtures, snapshots, logs, coverage output,
   and sample files that were produced by a run rather than authored.
5. Comments: compact the ones that restate the code. Keep anything explaining a
   constraint, a workaround, or a non-obvious reason.
6. Secrets: search for hardcoded credentials, tokens, and keys in source,
   config, and scripts. Replace each with configuration, and report it as
   needing rotation — removing it from the working tree does not remove it from
   history.
7. `.gitignore`: add entries for local, generated, or private paths you saw, and
   flag anything already committed that should not be public. Agent provider
   directories (`.claude/`, `.cursor/`, `.codex/`, `.opencode/`, ...) belong in
   `.gitignore`.
8. Other AI-provider files — prompts, agent configs, transcripts, generated
   scratch files — get flagged for the operator, not deleted. First decide from
   the code whether the project *uses* an AI provider or *integrates with one*:
   in an AI project these files are the product, so leave them alone and say so.
9. Validate: rerun the project's build, test, and lint commands and confirm the
   result matches step 1.

## Constraints

- Never trade behaviour for tidiness. If you cannot prove something is unused,
  leave it and list it as a suspicion instead.
- Never read, edit, move, or delete `.env` files or any other environment
  files, and never change an environment variable's value. Only make sure they
  are ignored by git and not committed.
- Delete only what you can justify; no drive-by refactors, renames, or
  reformatting.
- Don't rewrite git history or force-push.

## Done when

The project's own build, test, and lint commands pass exactly as they did
before, every change is accounted for in the report, and no known secret
remains in the working tree.

## Output

A report with one section per category (dead code, dependencies, test residue,
comments, secrets, `.gitignore`, AI-provider files), each listing:

- What changed, as `path:line` or `path`.
- Why it was safe to change, and how you verified it.

End with:

- **Left alone** — what looked removable but was not provably unused, and what
  would settle it.
- **Needs a human** — secrets to rotate, committed files to purge from history,
  or anything else outside this cleanup.
