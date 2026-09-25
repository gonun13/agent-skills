# Hierarchy and Focus

Every view has one thing that matters most, a few things that support it, and
everything else. Show them in that order. Hierarchy is how a design tells people
where to look and what to do, before they have read a word.

## Why it holds

Attention is the scarcest resource on a screen. When everything is emphasised,
nothing is, and the visitor has to do the sorting the design refused to do.
Clear hierarchy cuts the time to the first useful action. It also makes the
product feel calm rather than loud. Most "this looks cluttered" feedback is
really a hierarchy problem, not a spacing or colour problem.

## In practice

- Apply the squint test. With the detail blurred, you should still be able to
  pick out the primary element, the secondary element and the major groups, in
  order.
- Give each view one primary action, styled as primary. Secondary actions look
  secondary, and tertiary ones look like links.
- Build hierarchy from several signals at once: size, weight, space, contrast
  and position. Colour alone is the weakest of these and fails for many
  readers.
- Adjacent levels need a visible step. Headings a pixel or two apart, or 500
  against 600 weight, read as a mistake rather than a hierarchy.
- Semantic order matches visual order. The visually largest heading is the
  `h1`, and levels are not skipped for styling.
- Beyond about four or five equally weighted choices, people slow down. Group
  them, rank them, or disclose the rest progressively.
- Demote before you promote. Removing emphasis from the noise usually works
  better than adding more to the signal.

## How to tell it is being violated

- Two or more buttons in one view share the primary style.
- Bold, colour or uppercase is applied so widely that it no longer marks
  anything.
- Decoration such as badges, icons, gradients or borders is louder than the
  content it frames.
- A visitor asked "what do you do here?" hesitates between several equally
  loud options.
- The heading outline in the DOM disagrees with what the page visually
  presents.

## Pass

**Look for**: several primary-styled actions in one view; emphasis (bold,
colour, caps, badges) on more than a small share of elements; heading sizes
that differ by less than about 1.2×; decoration louder than content; decision
points with more than about five equal options; heading levels chosen for
their styling.

**Safe fix**: demote. Move the extra actions to the secondary or tertiary
variant the component set already has. Remove redundant emphasis. Widen the
steps between adjacent levels using the existing type scale. Correct the
heading semantics so they match what is shown.

**Stop at**: reordering content, removing sections, or merging screens. That
is information architecture. Propose it with the reading order you would use
and why. Merging or splitting screens moves URLs, so the proposal must keep
every existing path resolving, for example through a 301 to the merged page.
