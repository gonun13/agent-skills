---
name: improve-design
description: Measures a project's frontend against twelve UI/UX design principles and a catalogue of generated-UI tells, then either improves the interface toward them, writes a ranked critique, or runs the one principle you pick. Use when an interface looks generic, cluttered or unfinished, before shipping a UI, or when asked for a design, UX or accessibility review.
---

# Improve design

## Goal

The interface measurably closer to the twelve principles below and free of the
tells in `anti-patterns.md`, or a ranked account of where it is not. Every claim
is tied to a principle file and a `path:line`. Every change leaves what the
product does untouched, and the rendered result has been looked at, not
assumed.

## Context

**Find the principle files first.** Each one covers the principle, why it holds,
what it looks like in practice, and how to tell when it is broken. It ends with
a `## Pass` section that says what to look for, what a safe fix is, and where
to stop. `anti-patterns.md` sits beside them and lists the defaults generated
interfaces reach for when nobody made a decision. Nothing is loaded for you.
Try these locations in order:

1. `principles/` and `anti-patterns.md` beside this `SKILL.md`.
2. `../agent-skills/skills/improve-design/`. This repo is normally cloned beside
   the projects it is run against.
3. Any `improve-design/` already vendored inside the project.

If none of them resolve, say so once and work from the index below alone. That
is the degraded mode. It is still useful, but cite the index rather than
inventing detail, and never invent a thirteenth principle.

**Check that there is an interface at all.** A library, CLI, or API service has
no screens to improve. Say so and stop rather than inventing work.

**The index.** There is one file per principle, numbered in reading order. The
numbering is not a ranking, because a real decision usually turns on two or
three principles at once.

| File | Principle | Reach for it when |
| --- | --- | --- |
| `01-intent-before-pixels.md` | Know the surface's job before touching it. | Always first. Settles refine or redesign, and the surface's mode. |
| `02-hierarchy-and-focus.md` | One thing first on every screen. | Everything shouts, or the primary action is hard to find. |
| `03-space-and-rhythm.md` | Proximity groups; a scale sets the rhythm. | Spacing feels arbitrary, cramped, or evenly monotonous. |
| `04-typography.md` | Few families, a role scale, a readable measure. | Too many sizes, long lines, weak heading contrast. |
| `05-color-and-contrast.md` | Colour is a role, and contrast is a floor. | Raw hex in components, grey-on-colour, colour-only status. |
| `06-one-system.md` | Same thing, same look, everywhere. | Three button styles, five radii, mixed icon sets. |
| `07-every-state-designed.md` | Loading, empty, error and overflow are screens too. | Blank lists, silent submits, layouts that break on long text. |
| `08-interaction-and-feedback.md` | Controls look like what they do and answer at once. | Forms, targets, modals, navigation, destructive actions. |
| `09-motion-with-purpose.md` | Motion explains change, or it goes. | Fade-ups everywhere, sluggish transitions, no reduced-motion path. |
| `10-responsive-by-structure.md` | Layout adapts by structure, not by shrinking. | Horizontal scroll, fixed widths, the mobile layout as an afterthought. |
| `11-accessible-by-default.md` | Semantic, operable, perceivable: WCAG 2.2 AA as floor. | Div buttons, missing focus, unlabeled controls. |
| `12-words-are-interface.md` | Copy names actions, errors say how to recover. | "Submit", "Something went wrong", two names for one thing. |

## Steps

1. **Pick the mode** and state it in one line before touching anything:
   - If the operator named a mode, or named a principle by number or title,
     obey that.
   - Otherwise, if writes are permitted, use **improve**.
   - Otherwise, if the session is read-only, use **critique**.
   - Otherwise, **ask**. List the twelve with their numbers, take a selection
     (`all`, or for example `02 07 11`), and ask once whether to improve or
     critique. Ask once, then commit. This is a selection, not an interview.

   Also state the **depth**. It is **refine** unless the operator asked for a
   redesign. Refine keeps the incumbent identity: the palette, typefaces, logo,
   voice and information architecture. Redesign may replace the look, but it
   still keeps content, function and every existing URL. Never split the
   difference by polishing a look you were asked to replace.

2. **Survey.** Do this in every mode. Before reading, name the scope: the whole
   app, a route, a component, or a change (`git diff`, a branch). Then:
   - Read what the project has already decided: `DESIGN.md`, brand guidelines,
     design tokens, the Tailwind or theme config, CSS custom properties,
     Storybook, `spec/`, ADRs, `AGENTS.md`, `CLAUDE.md`, `README`. A departure
     that was chosen deliberately and written down is an answer, not a finding.
   - Identify the stack and the component library (shadcn/ui, MUI, Chakra,
     Radix, Vuetify, a house kit, or none) and its styling mechanism. Improve
     with the mechanism the project already has. Never add a second one.
   - Extract the incumbent system from the code: families and sizes in use,
     colour values and their roles, the spacing, radius, shadow and z-index
     values, breakpoints, and the icon set. Count the distinct values. This is
     the baseline that drift is measured against.
   - **Record the URL baseline.** List what already exists: the routes or pages
     (from the router, the file-based `pages/` or `app/` tree, or the built
     output), the API endpoints the UI calls, redirect rules, and the fragment
     anchors that in-page links and headings expose. This list is a contract.
     Step 4 must leave every entry resolving to the same content.
   - Learn the build, lint, test and visual-regression commands and run them
     once, so you know which failures you inherited.
   - **Render it.** Start the dev server or build. If a browser or screenshot
     tool is available, capture each surface in scope at about 375px and
     1440px wide, in every theme the project ships. If nothing can render, say
     so, work from the source, and label every visual claim as unverified.

3. **Read the principle files in scope and `anti-patterns.md`** before judging
   anything. Start with `01-intent-before-pixels.md`: write its design read for
   each surface in scope. That means who uses the surface, its mode, its one
   job, and the incumbent world. Every finding cites the file it came from.

4. **Improve.** Work by severity, not by index order:
   1. Blocked tasks and inaccessible paths (07, 08, 11).
   2. Missing states (07).
   3. Hierarchy, layout and responsive structure (02, 03, 10).
   4. Type, colour and system drift (04, 05, 06).
   5. Motion and copy (09, 12), then removing the tells.

   Make the smallest change first, inside each file's `Safe fix` and never past
   its `Stop at`. Take the cheap gains. A component the work already touches has
   its best chance of improving now. Where a tell from `anti-patterns.md`
   appears, rewrite the element rather than softening it, unless the brief or a
   recorded decision asked for it.

   **Verify in bounded passes, not a loop.** Once the edits are in, render
   again at both widths and in every theme, then fix everything that round
   shows in one batch. Confirm with at most one more round, then stop
   polishing. Re-run the project's checks. They must give the same result as in
   step 2, and a behaviour change is a bug, not a design improvement. Diff the
   URL baseline against the result, so that no route, endpoint, redirect or
   anchor was lost or renamed. Anything past `Stop at` is written up as a
   proposal instead of done.

5. **Critique.** Run the same survey with no edits. Score each principle in
   scope from 0 to 4: 0 absent, 1 major gaps, 2 partial, 3 minor gaps, 4
   solid. Then rank the findings by severity:
   - **P0** blocks a task or excludes users.
   - **P1** is a WCAG AA failure or significant friction.
   - **P2** is an annoyance with a workaround.
   - **P3** is polish.

   Give each finding a `path:line`, the principle file, the symptom from that
   file's "How to tell it is being violated", and the size of the fix. List the
   tells found, and name what already works so it survives the next change.
   Then offer to write the critique to `docs/design-review.md`, and write it
   only if the operator says yes.

6. **Ask** runs step 4 or 5 narrowed to the chosen principles, and says which
   principles were not examined.

7. **Name the conflicts.** Where two principles pulled opposite ways, say which
   one gave way and why. Common pairs are consistency against distinctiveness,
   density against whitespace, motion against performance, and brevity against
   clarity. Two principles disagreeing is the normal case, not a contradiction
   to report. That sentence is the reasoning, and it is the part a reader
   months from now needs.

## Constraints

- **Never trade function for looks.** Data, form field names and their order,
  analytics hooks, test IDs and API calls stay exactly as they are. The
  project's own checks are what prove it.
- **Existing URLs are a public contract, in every mode and at every depth.**
  Do not rename, move, remove or restructure a route, page path, slug, query
  parameter, API endpoint or redirect. Do not rename the file or folder that a
  file-based router turns into a path. Keep fragment anchors working: when
  heading text changes and the `id` is generated from it, pin the old `id`. A
  `<div onClick>` turned into a link keeps its exact destination. New pages
  may be added, but existing ones stay where they are. If a better
  information architecture would move a URL, propose it with the 301 mapping
  and let the operator decide. Never make that change as a side effect.
- **The brief wins.** A pinned palette, typeface, era or style is honoured even
  where it matches an entry in `anti-patterns.md`. What these principles
  outrank is a default nobody chose.
- **Refine keeps the identity.** Replacing brand colours, typefaces, the logo,
  the voice or the navigation structure is a redesign. Do it only when asked.
  Otherwise, propose it.
- Microcopy is in scope: labels, buttons, errors, empty states and helper text.
  Marketing copy, factual claims, prices and legal or consent text are not.
  Propose changes to those, and never invent them.
- **No invented content.** No fake testimonials, metrics, customer logos,
  names or screenshots. A missing asset gets an honest, labelled placeholder
  and a line under **Needs a human**.
- No new dependencies: no UI kit, animation library, icon set, font service or
  CSS framework unasked. A self-hosted font or a new token file is a proposal.
- Do not widen the change you were asked for. Past a `Stop at`, propose what
  you would do and why, and let whoever is deciding decide.
- In critique mode, write no file until the operator says yes to it.
- Only claim what was seen. Say which surfaces were rendered, at which widths
  and in which themes. Never report "design complete".

## Done when

- The mode, depth and scope were stated.
- Each surface in scope has a design read.
- Every principle in scope was either applied or explicitly deferred with a
  reason.
- No tell from `anti-patterns.md` remains in touched code without a recorded
  reason.
- The rendered result was inspected at both widths, or declared unverifiable.
- The project's build, test and lint commands give the same result as in step
  2.
- Every route, endpoint, redirect and anchor in the URL baseline still
  resolves to the same content.
- Nothing was changed past a `Stop at`.

## Output

Open with one line: the mode, the depth, the scope, which principles were
examined, how the result was verified (rendered widths and themes, or
source-only), and that no existing URL changed.

Then one section per principle that produced something, in index order:

- **Improve**: what changed, as `path:line`, and why it was safe.
- **Critique**: the score, then each gap as `[P?] path:line`, with the symptom
  and the size of the fix.

**Tells.** List each tell found in `anti-patterns.md` with its `path:line` and
whether it was removed, kept on purpose (with the reason), or left for a
proposal.

Close with:

- **Keep.** What already works and should survive the next change.
- **Left alone.** What sat past a `Stop at` or was blocked, and what would
  settle it.
- **Conflicts.** Where two principles pulled opposite ways, which gave way, and
  why.
- **Needs a human.** Brand or identity decisions, copy rewrites, missing
  assets, and anything that needs access you do not have.
- **Not examined.** Principles out of scope, in ask mode.
