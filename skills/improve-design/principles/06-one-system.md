# One System

The same thing looks and behaves the same everywhere. That means one button
component, one radius scale, one elevation scale, one icon family and one set
of breakpoints. Consistency is what lets people learn an interface once and
then stop thinking about it.

## Why it holds

Every one-off is a small tax: on the reader, who has to work out whether the
difference means something, and on the next developer, who has to choose which
of three buttons to copy. Drift compounds. The fourth variant is always easier
to add than the first was. A product that feels "not quite professional" is
usually one that feels slightly inconsistent in a hundred places.

## In practice

- Reuse before you create. If the project ships a component library or shared
  components, use them. A hand-rolled equivalent beside a library one is drift.
- Keep the shape language small: one radius scale (for example 4, 8 and 12px,
  plus full for pills on small controls) chosen by element size and role.
- Declare elevation once per element, as a border or a shadow but not both. Use
  one shadow scale with a real offset and a soft blur, not a unique shadow per
  component.
- Use one icon family, at one stroke weight, sized on the type scale and
  optically aligned with the text. Icons are drawn from a library or authored
  SVG, never emoji or Unicode glyphs.
- Use named z-index layers (base, dropdown, sticky, overlay, modal, toast)
  instead of an arms race towards 9999.
- Classify each drift before fixing it:
  - a **missing token**, where a value repeats and needs a name;
  - a **one-off** that an existing component should replace;
  - a **local defect**, which is simply wrong.

  Fix it at the narrowest correct level.
- Add a token on the third occurrence, not the first. Two uses are a
  coincidence.

## How to tell it is being violated

- There are several button, input or card implementations with slightly
  different padding, radius or hover behaviour.
- Radii of 4, 5, 6, 8, 10 and 12px all appear on similar elements.
- Every card has its own `box-shadow`, or a 1px border sits under a wide soft
  shadow.
- Two icon libraries are in use, or emoji stand in for icons.
- `z-index: 9999` and `z-index: 10000` both appear.
- A component library is installed while hand-rolled equivalents live beside
  it.

## Pass

**Look for**: duplicate implementations of the same control; the count of
distinct radius, shadow, border and z-index values; mixed icon sets and glyph
icons; inline styles that duplicate tokens; library components shadowed by
local copies; drift between screens that ought to match.

**Safe fix**: replace one-offs with the existing shared component or token.
Collapse near-duplicate radii and shadows onto the existing scale. Replace
stray icons with their equivalents from the primary set. Name a repeated value
as a token once it has appeared three times.

**Stop at**: building a design system where none exists, migrating between
component libraries, or changing a shared component's public API that other
code depends on. Propose it, sized, with the drift counts as evidence.
