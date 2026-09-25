# Motion With Purpose

Motion earns its place by explaining something. It acknowledges an action,
shows where something came from or went, keeps continuity through a change, or
marks the one moment the surface is built around. Motion that explains nothing
is decoration, and decoration that moves is noise.

## Why it holds

Motion is the strongest attention signal a screen has. Spread across every
section and card, it competes with the content and makes the interface feel
slow, and repeated users feel every millisecond of it. Poorly built motion
drops frames, shifts layout, and can make people with vestibular disorders
physically unwell. Motion done with restraint does the opposite: it makes
cause and effect legible.

## In practice

- Before adding motion, name its job: feedback, state change, spatial
  relationship, continuity, or one authored focal moment. If you cannot name
  one, leave it static.
- Time it by distance and consequence:

  | Duration | Use |
  | --- | --- |
  | 100–150ms | immediate feedback |
  | 150–300ms | routine state changes |
  | 300–500ms | layout, overlay and view transitions |
  | 500–800ms | one deliberate focal entrance |

  Exits run at about two thirds of the entrance time.
- Ease out on arrival, for example `cubic-bezier(0.16, 1, 0.3, 1)`, and ease in
  on departure. Use linear only for constant-rate progress. Bounce and elastic
  curves are a style choice, not a default.
- Prefer one authored moment to scattered effects. The same fade-and-rise on
  every section is the most recognisable generated default.
- Animate `transform` and `opacity` first. Keep blur, filter and shadow
  animations bounded to small regions. Do not animate `width`, `height`, `top`,
  `left` or margins, which cause layout work and shift.
- Motion is interruptible and never blocks input. Content is visible in its
  default state, so a failed script does not hide the page.
- Every animation has a `prefers-reduced-motion` path that removes spatial
  movement but keeps meaningful state changes, such as a crossfade. Reduced
  means gentler, not broken.
- Drive scroll effects with `IntersectionObserver`, CSS scroll-driven
  animations or the project's motion library. Never use raw `scroll` listeners.
  Pause loops when they are off screen.

## How to tell it is being violated

- `transition: all` appears, or routine hover feedback takes 400ms or more.
- Every section or card fades up on scroll in the same way.
- Layout properties are animated, or content starts at `opacity: 0` and waits
  for JavaScript.
- There is no `prefers-reduced-motion` handling anywhere, or a global kill
  switch also removes useful feedback.
- A `window.addEventListener('scroll', …)` drives visual effects.
- Hover scales or lifts images and cards that are not themselves actions.

## Pass

**Look for**: `transition: all`; durations out of proportion to their job;
identical entrance animations repeated across sections; animated layout
properties; hidden-until-JS content; missing or blunt reduced-motion handling;
scroll listeners; infinite animations that keep running off screen; motion
without a nameable job.

**Safe fix**: narrow transitions to the properties that change. Shorten
durations to the table above and set the easing. Swap layout-property
animation for `transform`. Make the default state visible. Add a
`prefers-reduced-motion` query with a crossfade alternative. Delete motion
that has no job.

**Stop at**: adding an animation library or authoring new choreography, such
as page transitions, a hero sequence or shared-element transitions. Propose it
with the job it would do.
