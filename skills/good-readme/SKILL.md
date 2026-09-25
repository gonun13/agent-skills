---
name: good-readme
description: Creates or improves a repository's main README as the shortest page that tells a visitor what the project is and gets them to a first working result. Use when preparing a repository for visitors or trimming a bloated README, not for a documentation-wide audit or a profile README.
---

# Good README

## Goal

The shortest README that lets a first-time visitor understand the project and
reach a first working result. The default shape is:

```markdown
# name

One or two sentences: what it does and who it is for.

## Install

The fewest commands that reach a working result.

## Usage

One example, only if the install section does not already show one.

License: [MIT](LICENSE)
```

This is a ceiling to grow from only when needed, not a checklist to fill.

## Context

Check first:

- The README visitors actually see. On GitHub, `.github/README` wins over the
  root, then `docs/`. Keep its location and format; create a root `README.md`
  if none exists.
- Manifests, lockfiles, entry points, and scripts. These establish what the
  project does and which commands work; old README claims are not proof.
- Existing license, docs, and community files, to link rather than restate.
  Never expose credentials found in remotes or config.

## Steps

1. Establish purpose, audience, and state from the repository. Ask only for
   facts that block the rewrite.
2. Write the opening: one H1 and a one-to-three-sentence factual pitch. Add a
   features list only when the project does several distinct things the pitch
   cannot carry. Never write a list that restates the pitch.
3. Write getting started: only the steps a new user must perform, in order,
   as copyable fenced commands without prompts, using the real package manager.
   Skip what tooling handles and prerequisites every reader has. Show required
   environment variables with safe values; end with how to tell it worked.
4. Add one usage example of the main task, unless getting started already
   shows it. Capture shown output from a real run, not from the old README.
5. Everything else is one line or nothing: license, contributing, security,
   support, and docs each get a single link to the existing file. A section is
   only for what a visitor would get wrong without it, such as a documented
   limitation. Use an existing screenshot or badge only if it informs.
6. Cut. Reread as a first-time visitor and delete or link out anything they
   would not miss: architecture and internals, directory trees, exhaustive
   flag, environment, or config tables (link to `--help` or docs instead),
   changelog content, repeated facts, a table of contents on a page that does
   not need scrolling, and boilerplate sections. When the cut content is what
   the project provides, such as its included items, keep a one-line link.
7. Validate: check relative links, anchors, image paths, and fences; verify
   commands against scripts and entry points; run safe examples where feasible.

## Constraints

- Scope is the main README. Do not change code, dependencies, settings, or
  policy files to make the README's claims true.
- Do not grow an existing README by default. Deleting detail, or moving it to
  existing docs, counts as an improvement.
- Keep the project's language and tone.
- Do not guess commands, versions, URLs, features, license terms, or contacts.
  Flag missing licensing or contradictions instead of resolving them.
- Use sample config, never secret-bearing files. Validation is not permission
  to deploy, publish, or call paid services.

## Done when

The README has a pitch and an actionable path to a first result, its commands
are backed by repository evidence, and its links resolve. Nothing is left that
could be removed without a first-time visitor failing or being misled.

## Output

Apply the changes. In the handoff, link the README, list what was removed or
moved and where it went, report the validation you did, and list any facts you
could not settle.
