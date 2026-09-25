# Typography

Most of any interface is text, so typography carries most of its hierarchy,
voice and readability. Use few families, a small set of named roles on a
deliberate scale, and a comfortable line length. Those three do more than any
decoration.

## Why it holds

Type is read continuously, so small errors compound. Lines that are too long
tire the eye. Sizes that are too close blur the hierarchy. A late-loading font
shifts the whole page. The face is also the fastest carrier of personality: an
unexamined default says that nobody decided. Getting type right is usually the
biggest single improvement a surface can get.

## In practice

- Use one family, or two with clearly different jobs. A second family has to
  do something the first cannot.
- Define roles rather than sizes: display, heading, title, body, label,
  caption, data. Each role has one size, weight and line height everywhere it
  appears. Product UI suits a ratio of about 1.2 to 1.25; marketing display can
  step more boldly.
- Web body text is at least 16px. The measure is 45–75 characters, set with a
  `max-width` in `ch`. Body line height is about 1.5, headings about 1.1–1.25.
  Wider lines need more leading.
- Tighten tracking a little on large display type, but never beyond
  -0.04em. Leave body tracking at the default, and open it up slightly on small
  uppercase labels.
- Make weight steps meaningful, for example 400 for body, 500 or 600 for
  labels, and 600 or 700 for headings. Never synthesise bold or italic that the
  font does not ship.
- Use `font-variant-numeric: tabular-nums` for numbers that align or update.
  Use `text-wrap: balance` on short headings and `pretty` on paragraphs.
- Load only the weights and styles that are used. Use `font-display: swap` or
  `optional` with a metric-matched fallback, so text never disappears and the
  page does not jump.
- Light text on dark needs compensation: a touch more line height and
  tracking, and a step more weight if the face looks thin.

## How to tell it is being violated

- There are more distinct font sizes than roles, some only 1–2px apart.
- Body text is 14px or smaller on a marketing or reading surface.
- Paragraphs run the full width of a wide screen.
- Numbers in tables or counters shift width as they change.
- Eight font weights are loaded and two are used, or text flashes invisible on
  load.
- A system face stands in as the brand's display voice with no decision
  behind it.

## Pass

**Look for**: the count of distinct font sizes, weights and line heights
against the roles actually needed; near-duplicate sizes; body text under 16px;
unbounded measure; `line-height: 1` on multi-line text; tight tracking on body
copy; untabulated numerals in data; unused font files and weights; missing
`font-display`; headings that break with a single orphaned word.

**Safe fix**: collapse near-duplicate sizes onto the existing scale, and give
each role one definition. Cap the measure in `ch`. Correct line height and
tracking. Add `tabular-nums`, `text-wrap: balance` and `text-wrap: pretty`.
Remove unused weights. Add `font-display` and a fallback.

**Stop at**: changing a typeface family. That is identity, so propose it with
the reason and the licence and hosting implications. Stop also at introducing a
type scale where none exists; propose one derived from the sizes in use.
