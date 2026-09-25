# Space and Rhythm

Space is the cheapest grouping device a design has. Things that belong together
sit close. Things that do not are separated generously. A small, fixed scale of
spacing values gives the whole product a rhythm people feel without noticing.

## Why it holds

People read relationships from distance before they read borders, boxes or
labels. When spacing is arbitrary, the eye finds groups that are not there and
misses the ones that are. Designers then compensate with cards, dividers and
backgrounds, which add weight without adding meaning. A shared scale also stops
spacing debates. The only question left is which step, never which number.

## In practice

- Use one spacing scale, usually on a 4px base (4, 8, 12, 16, 24, 32, 48, 64,
  96…). An 8-only scale lacks the middle steps that dense UI needs.
- Contrast tight and generous intervals on purpose. The gap inside a group is
  clearly smaller than the gap between groups. Equal spacing everywhere flattens
  the hierarchy.
- Put more space above a heading than below it, so the heading belongs to what
  follows.
- Group by proximity first. Add a container, border or background only when
  proximity cannot carry the relationship. Cards are the lazy container, and
  cards nested inside cards are always wrong.
- Align to shared edges. Elements that almost align, a few pixels off, look
  like errors. Fix optical alignment after checking the render.
- Keep one content width per surface type. Use `gap` for sibling rhythm in
  flex and grid rather than per-child margins.
- Density follows the mode. Operate surfaces can be tighter than Persuade or
  Experience surfaces. The scale is the same; the steps chosen differ.

## How to tell it is being violated

- Spacing values that belong to no scale: 13px, 27px, `mt-[37px]`.
- Every gap on the page is the same size.
- Borders, cards or background panels do the grouping that proximity should.
- Containers change width from section to section for no content reason.
- Elements sit a pixel or two off a shared edge.

## Pass

**Look for**: count the distinct margin, padding and gap values, and flag
anything off the project's scale; uniform spacing between unequal
relationships; nested cards; wrappers whose only job is a border or
background; near-misses in alignment; inconsistent container widths;
margin-collapse and specificity fights between section and component styles.

**Safe fix**: snap each off-scale value to the nearest step of the existing
scale. Widen the gaps between groups and tighten the gaps within them. Replace
child margins with `gap`. Delete redundant wrappers and borders where proximity
already groups. Align to shared edges.

**Stop at**: introducing a spacing scale or grid system where the project has
none. Propose the tokens with evidence from the values actually in use. Stop
also at page-level layout restructuring, which belongs to
`02-hierarchy-and-focus.md` as a proposal.
