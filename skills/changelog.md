---
name: changelog
description: Writes a dated release entry from commits since the last version and bumps the version field. Use when releasing or when commits have landed on main since the last changelog entry.
---

# Changelog

## Goal

One new dated release entry covering everything merged since the last version,
with the version bumped correctly in both the changelog and the project's
version field.

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

1. Find the last version in the changelog; confirm it matches the version
   field. If they disagree, stop and ask.
2. `git log <last-version>..HEAD` on the default branch. Read the diffs, not
   just the messages.
3. Classify each operator-visible change as Added, Changed, or Fixed. Drop
   anything with no user-visible effect (refactors, tests, CI, deps, docs-only).
4. Decide the bump for this run:
   - any Added, or any behaviour change an operator would notice → **minor**
   - only Fixed → **patch**
   - **major**: never automatic. If something looks breaking (removed feature,
     changed defaults, incompatible format), flag it and ask; bump major only
     on the operator's say-so.
5. Write the entry at the top: `## [X.Y.Z] - YYYY-MM-DD`, then `### Added`,
   `### Changed`, `### Fixed` in that order, omitting empty sections. Never
   edit an already-released entry.
6. Update the version field with the project's own tooling where it exists
   (`npm version --no-git-tag-version`, `poetry version`, `cargo set-version`,
   ...); otherwise edit the field directly.
7. Validate: changelog and version field agree, dates are ISO, `git diff`
   touches only those two files.

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

- Only `CHANGELOG.md` and the version field change. No commit, no tag, no push
  — report the exact commands instead.
- Do not guess the bump when the change type is unclear; ask.
- Do not rewrite or reword past entries.

## Done when

The new entry lists every operator-visible change since the last version, the
version in the changelog and version field agree, and the diff touches only
those two files.

## Output

- The new entry verbatim.
- Old → new version and why that bump.
- Anything excluded and why.
- Any suspected breaking change awaiting a decision.
- Suggested `git commit` and `git tag` commands.
