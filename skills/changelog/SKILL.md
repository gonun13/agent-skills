---
name: changelog
description: Supervises a project's changelog and versioning practice, correcting existing entries and instructions before writing a dated release entry and bumping the version field. Use when releasing or when a project has changelog or versioning material to review.
---

# Changelog

## Goal

One new dated release entry covering everything merged since the last release,
with the project's version bumped to match, and the existing changelog audited:
clear wording problems corrected, factual problems reported.

## Context

Check first:

- `CHANGELOG.md` (or `CHANGES.md` / `HISTORY.md`); if none exists, create one
  in [Keep a Changelog](https://keepachangelog.com) format. Note whether it has
  an `## [Unreleased]` section.
- The project's version field: `package.json`, `pyproject.toml`, `Cargo.toml`,
  `VERSION`, ... Some projects have none — Go modules, for one — and the
  version is the git tag alone. Ask if you can find neither.
- Changelog and versioning instructions, and the project's own names for
  things: `README`, `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING`, `docs/`,
  `.cursor/rules`.
- The default branch (`main` or `master`) and the last release: the latest
  version tag (`git describe --tags --abbrev=0`). With no tags, the commit that
  added the last release heading:
  `git log -S'## [X.Y.Z]' --format=%H -- CHANGELOG.md | tail -1`. With neither,
  ask where the release starts.

## Steps

1. Audit what exists. Check existing entries for factual accuracy against the
   history, consistent versions and dates, duplicates, the project's
   terminology, and its documented format. Fix wording only where it is
   clearly inaccurate, vague, or inconsistent, with the smallest change that
   keeps its meaning; report anything factually wrong instead of rewriting it.
   Correct a changelog or versioning instruction only where it contradicts the
   project's actual tooling or format — a file, command, or section that no
   longer exists. Gaps and vague instructions are proposals, not edits.
2. Compare the last release with the version field. If they disagree, explain
   the mismatch and stop to ask, unless the project clearly marks the field as
   the unreleased next version.
3. `git log --stat <last-release>..HEAD` on the default branch. Open a commit's
   diff only where its message is vague, or the files it touches suggest more
   than the message says — messages undersell, so don't trust them alone.
4. If there is an `## [Unreleased]` section, it is the draft of this entry:
   check each line against the log, add what is missing, and drop what did not
   happen or has no user-visible effect.
5. Classify each operator-visible change as Added, Changed, Deprecated,
   Removed, Fixed, or Security. Drop anything with no user-visible effect
   (refactors, tests, CI, deps, docs-only).
6. Decide the bump for this run:
   - only Fixed or Security → **patch**
   - any Added or Deprecated, or a behaviour change an operator would notice →
     **minor**
   - anything breaking (Removed, changed defaults, an incompatible format) →
     never automatic. Flag it and ask. On the operator's say-so, bump
     **major** from 1.0.0 up, and **minor** below it (`0.4.2` → `0.5.0`).
7. Write the entry. With an `## [Unreleased]` section, rename it to
   `## [X.Y.Z] - YYYY-MM-DD` and add a fresh empty `## [Unreleased]` above it;
   otherwise add the entry at the top. Sections go in the order Added,
   Changed, Deprecated, Removed, Fixed, Security, omitting empty ones. If the
   file keeps compare links at the bottom, add the new one and repoint
   Unreleased.
8. Update the version field with the project's own tooling where it exists
   (`npm version --no-git-tag-version`, `poetry version`, `cargo set-version`,
   ...); otherwise edit the field directly. Where the version is the tag alone,
   the `git tag` command in the Output is the bump.
9. Validate: changelog and version field agree, dates are ISO, and `git diff`
   touches only the changelog, the version field, and any instruction
   corrected in step 1.

In plan mode, stop after step 6. The plan is the new entry verbatim, the old →
new version, and each correction to existing entries or instructions.

When writing entries:

- One line per change, present tense, what an operator can now do or now sees.
- No file paths, function names, PR numbers, or internal type names.
- Use project vocabulary from the docs, not synonyms.
- Security fixes: name the class of issue fixed without a reproduction recipe;
  never name reporters, internal hosts, customers, or credentials. If the fix
  is not yet safe to disclose, ask before writing it.
- Private or internal-only changes (telemetry, infra, secrets rotation) get no
  entry.

## Constraints

- Only the changelog, the version field, and instructions that contradict the
  tooling (step 1) may change. No product code or unrelated documentation.
- Released entries are history: never change their version number, date,
  heading, or order. Their text changes only as step 1 allows.
- No commit, no tag, no push — report the exact commands instead.
- Do not guess the bump when the change type is unclear; ask.

## Done when

Existing entries and instructions have been audited, the new entry lists every
operator-visible change since the last release, the changelog and version field
agree, and the diff contains only the changes the constraints allow.

## Output

- Audit: wording corrected, instructions corrected, and factual problems left
  for the operator, each with the reason.
- The new entry verbatim.
- Old → new version and why that bump.
- Anything excluded and why.
- Any suspected breaking change awaiting a decision.
- Proposals: instruction gaps or policy the project has not settled.
- Suggested `git commit` and `git tag` commands.
