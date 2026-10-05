---
name: your-skill-name
description: What this does. Use when <trigger, e.g. the user mentions X>.
---

# Skill title

## Goal

One sentence: the concrete outcome this produces.

## Context

What to check first: relevant files, commands, or docs. Only what's not obvious.

## Steps

1. ...
2. ...
3. Validate: `<the actual check/test command>`.

In plan mode, stop at <step>; the plan is <what the operator reviews>.

## Constraints

- What's in scope and what must not change.
- Don't guess — inspect the repo or state what's unknown.

## Done when

Checkable criteria (tests pass, specific output produced, etc.).

## Output

Exact structure the result should take. A skill that changes no code names
the file its report is saved to.

Supporting files are referenced by their path inside the skill directory,
e.g. `principles/01-name.md`.
