# Accessible by Default

Build from semantic HTML, make everything operable by keyboard, and make
everything perceivable without sight, colour or motion. WCAG 2.2 AA is the
floor, not the goal. Accessibility is a property of the design, not an audit
stage after it.

## Why it holds

Roughly one person in five has a disability. Everyone is temporarily impaired
sometimes, whether in bright sunlight, holding a baby, on a slow connection or
with a broken trackpad. Semantic structure is also what search engines, browser
reader modes, password managers and automation tools rely on. Retrofitting
accessibility costs far more than choosing the right element in the first
place, and in many markets it is a legal requirement.

## In practice

- Semantic HTML comes first. Use landmarks (`header`, `nav`, `main`, `footer`),
  one `h1`, headings in order, lists as lists, and tables for tabular data.
- Everything is operable by keyboard in a logical order, with no traps and no
  positive `tabindex`. Provide a skip link to the main content.
- Give focus a visible `:focus-visible` style, at least 2px, with 3:1 contrast
  against its surroundings, themed from the palette. Never remove it without a
  replacement.
- Every control has an accessible name that matches its visible label.
  Icon-only buttons get an `aria-label`. Decorative icons are hidden with
  `aria-hidden="true"`.
- Every meaningful image has `alt` text describing its content or function in
  context. Decorative images get `alt=""`, never a missing attribute.
- Use ARIA only where native HTML cannot express the pattern. A wrong role is
  worse than none.
- Announce async status changes such as saved, errors, or updated counts
  through a polite live region, without moving focus. Move focus deliberately
  on route changes and when dialogs open or close.
- Set `lang` on `<html>`. Honour `prefers-reduced-motion` and
  `prefers-contrast`. Let colour, contrast and target size follow
  `05-color-and-contrast.md` and `08-interaction-and-feedback.md`.

## How to tell it is being violated

- `outline: none` or `outline: 0` appears with no replacement focus style.
- Clickable `div`s or `span`s exist with no role, `tabindex` or key handler.
- Images have no `alt`, or `alt="image"`, or a file name as alt.
- Icon buttons have no accessible name, so a screen reader announces "button".
- The page cannot be completed with the keyboard, or focus disappears behind a
  modal.
- `aria-label` sits on non-interactive `div`s while real controls lack names.

## Pass

**Look for**: removed focus styles; non-semantic controls; missing landmarks
and skipped heading levels; missing or poor `alt`; nameless icon buttons;
positive `tabindex`; keyboard traps; dialogs without focus management;
unannounced status changes; missing `lang`; ARIA that contradicts native
semantics. Run the project's accessibility checks (axe, Lighthouse,
eslint-plugin-jsx-a11y, Pa11y) where they exist, and tab through each surface
in scope by hand.

**Safe fix**: use native elements with the existing styling. Add focus-visible
styles from the palette, labels and `aria-label`s, and `alt` decisions. Add
landmarks and correct the heading levels. Add a skip link and a polite live
region for status. Remove redundant or wrong ARIA.

**Stop at**: custom widgets that need a full ARIA pattern rebuilt, such as a
combobox, tree grid or drag and drop. Propose replacing them with the native
element or a proven primitive already in the stack. Stop also at alt text
whose meaning you cannot determine. Name it under **Needs a human** instead of
guessing.
