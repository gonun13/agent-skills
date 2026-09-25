# Responsive by Structure

A layout adapts by changing its structure: what reorders, collapses, wraps or
moves aside as space runs out. It does not adapt by shrinking everything until
it fits. Start from the narrowest screen and add structure as space allows.

## Why it holds

For most products, most visits come from a phone, and a layout designed at
1440px and squeezed down shows it. Horizontal scroll, microscopic text and
thumb-hostile controls are the result. Responsive structure is also what
survives browser zoom, large system text, split-screen windows and embedded
views. Those are the conditions many users actually run in, and a fixed-width
design fails all of them.

## In practice

- Design mobile-first. Choose breakpoints where the content breaks, not at
  device widths, and use the project's existing breakpoint tokens.
- Nothing scrolls horizontally at 320px, except a deliberate container such as
  a data table or carousel with a visible affordance.
- Use `max-width`, `min()`, `clamp()` and `minmax()` grids rather than fixed
  pixel widths. Use `clamp()` for display type only. Body and product text stay
  predictable.
- Prefer container queries for components that appear in contexts of
  different widths.
- Use `min-height: 100dvh` instead of `100vh` on mobile, and respect
  `env(safe-area-inset-*)` on notched devices.
- Give images `srcset` or `sizes`, explicit dimensions or `aspect-ratio`, and
  `object-fit` where they crop.
- Make long tokens (URLs, IDs, email addresses) wrap with
  `overflow-wrap: anywhere` inside a flex or grid child with `min-width: 0`.
- Never disable zoom. The page must work at 200% zoom and with enlarged text.
- DOM order is reading and focus order. Reorder visually with care, because
  `order` and `row-reverse` can break keyboard navigation.
- Hiding content on mobile is a priority decision, not a way of saving space.
  Anything essential stays reachable.

## How to tell it is being violated

- The page scrolls sideways on a phone, or text is cut off at the right edge.
- The viewport meta tag contains `user-scalable=no` or `maximum-scale=1`.
- A hero set to `100vh` jumps as the mobile browser bar shows and hides.
- Text sits in fixed-height boxes and overflows at larger font sizes.
- Tables or code blocks force the whole page wider.
- The visual order and the tab order disagree on some breakpoint.

## Pass

**Look for**: overflow at 320px and at 375px; fixed pixel widths on
containers; zoom disabled; `100vh` on mobile; fixed heights around text;
images without dimensions; unwrapped long tokens; flex children missing
`min-width: 0`; visual reorder that breaks focus order; essential content hidden
below a breakpoint.

**Safe fix**: replace fixed widths with `max-width` or `min()`. Allow wrapping.
Wrap tables and code blocks in their own scroll container. Switch to `dvh`.
Add `aspect-ratio` and dimensions to images. Remove the zoom lock. Correct
the source order where a visual reorder broke focus order.

**Stop at**: a new navigation pattern for small screens, or a different
information priority per breakpoint. Propose it, with the content priority it
assumes.
