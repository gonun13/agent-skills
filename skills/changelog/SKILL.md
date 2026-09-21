---
name: changelog
description: Supervises a project's changelog and versioning practice, correcting existing entries and instructions before writing a dated release entry and bumping the version field. Use when releasing or when a project has changelog or versioning material to review.
---

# Changelog

## Goal

Maintain an accurate, consistent changelog and versioning practice. If the
project already has changelog entries or changelog/versioning instructions,
act as the supervisor: audit them, conservatively flag or correct misleading
messages, and refine the relevant project documentation. Then write one new
dated release entry covering everything merged since the last version, with
the version bumped correctly in the new entry and the project's version field
when a release is due. Existing release version numbers remain untouched.

## Context

Check first:

- `CHANGELOG.md` (or `CHANGES.md` / `HISTORY.md`); if none exists, create one
  in [Keep a Changelog](https://keepachangelog.com) format.
- The project's version field: `package.json`, `pyproject.toml`, `Cargo.toml`,
  `go.mod` tags, `VERSION`, ... Ask if you cannot find one.
- Terminology sources: `README`, `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING`,
  `docs/`, `.cursor/rules` — use the project's own names for things.
- The default branch (`main` or `master`) and the last released version's commit
  or tag.

## Steps

1. Audit the project before making a release:
   - Identify existing changelog entries, release-note conventions, and
     changelog/versioning instructions in project docs or agent instructions.
   - If any exist, enter supervisor mode. Check entries for factual accuracy,
     consistent versions and dates, duplicate or missing changes, project
     terminology, and compliance with the documented format.
   - Correct existing message wording only when it is clearly inaccurate,
     vague, or inconsistent, using the smallest change possible. Preserve the
     historical meaning and release facts; do not silently invent changes or
     add missing historical claims.
   - Refine stale, incomplete, or contradictory changelog/versioning
     instructions in the relevant project documentation. Make the policy
     actionable and consistent with the project's actual tooling and format.
     Do this proactively; do not wait for the user to point out each issue.
2. Find the last version in the changelog and compare it with the version
   field. Never change an existing version number, release heading, or release
   date. If they disagree, explain the mismatch and stop to ask unless the
   project clearly identifies the version field as an unreleased next version.
3. `git log <last-version>..HEAD` on the default branch. Read the diffs, not
   just the messages.
4. Classify each operator-visible change as Added, Changed, or Fixed. Drop
   anything with no user-visible effect (refactors, tests, CI, deps, docs-only).
5. Decide the bump for this run:
   - any Added, or any behaviour change an operator would notice → **minor**
   - only Fixed → **patch**
   - **major**: never automatic. If something looks breaking (removed feature,
     changed defaults, incompatible format), flag it and ask; bump major only
     on the operator's say-so.
6. Write the entry at the top: `## [X.Y.Z] - YYYY-MM-DD`, then `### Added`,
   `### Changed`, `### Fixed` in that order, omitting empty sections. Never
   change an already-released entry's version number, date, section structure,
   or historical facts. In supervisor mode, reword an old entry only when
   strictly necessary for accuracy, clarity, terminology, or consistency.
7. Update the version field with the project's own tooling where it exists
   (`npm version --no-git-tag-version`, `poetry version`, `cargo set-version`,
   ...); otherwise edit the field directly.
8. Validate: changelog and version field agree, dates are ISO, corrected
   documentation matches the resulting practice, and `git diff` touches only
   the changelog, version field, and explicitly refined project documentation.

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

- In supervisor mode, the changelog, version field, and relevant project
  documentation or agent instructions may change. Do not modify unrelated
  product code or documentation.
- No commit, no tag, no push — report the exact commands instead.
- Do not guess the bump when the change type is unclear; ask.
- Historical records are immutable by default. Never change an old version
  number, release date, release heading, or version ordering. Reword past
  entry text only when strictly necessary and without changing its meaning.
- If an old record appears factually wrong, preserve it and report the issue
  for the operator's decision; do not silently rewrite it.
- Do not turn a vague changelog instruction into a new release policy without
  grounding it in the project's existing tooling and conventions.

## Done when

The existing changelog and versioning practice has been audited, any clear
message or documentation problems have been corrected, and the new entry
lists every operator-visible change since the last version. The version in the
changelog and version field agree, and the diff contains only scoped changelog,
version, and documentation updates.

## Output

- Supervisor findings: messages corrected, documentation refined, and anything
  intentionally left unchanged with the reason.
- The new entry verbatim.
- Old → new version and why that bump.
- Anything excluded and why.
- Any suspected breaking change awaiting a decision.
- Suggested `git commit` and `git tag` commands.
