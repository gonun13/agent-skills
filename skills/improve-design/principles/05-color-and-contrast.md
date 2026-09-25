# Colour and Contrast

Colour is a set of roles, not a bag of swatches. The roles are surface, text,
action, focus, border, and the status colours. Each role has a token, and each
token has one meaning. Contrast is not a style choice. It is the floor that
lets people read the page at all.

## Why it holds

When colour has no roles, every new component picks its own and the palette
decays into near-duplicates. The accent, spread everywhere, stops pointing at
anything. Low contrast is the most common accessibility failure on the web.
Colour-only meaning excludes about one in twelve men outright. Roles also make
theming possible, because a dark theme remaps the roles instead of repainting
every component.

## In practice

- Use semantic tokens (`--color-text-muted`, `--color-action`,
  `--color-danger`), not raw hex, in components. Primitive ramps feed the
  semantic roles, and components use only the roles.
- Use one accent and spend it on action and state. The strongest colour owns
  a deliberate role or region, not scattered sparkles.
- Meet WCAG AA contrast: 4.5:1 for body text, 3:1 for large text (24px, or
  about 19px bold), and 3:1 for control boundaries, icons and focus indicators.
  Check placeholders, disabled text, text on images, and both themes.
- Never make colour the only signal. Pair status colour with an icon, text or
  shape. Charts use labels, patterns or lightness as well as hue.
- On a coloured surface, derive secondary text from that surface's hue or from
  the foreground. Generic grey there looks washed out and usually fails
  contrast.
- Compose dark mode rather than inverting light mode. Raise elevated surfaces
  with lighter tones, lower saturation, and test contrast separately.
- For a new ramp, prefer OKLCH so that lightness steps are predictable, and
  reduce chroma near white and black. Prefer explicit colours to stacked
  transparencies, which make contrast depend on whatever sits behind.

## How to tell it is being violated

- Raw hex or `rgb()` values sit inside components while a token file exists.
- There are five greys within a few percent of each other (`#666`, `#6b6b6b`,
  `#707070`).
- The accent colours links, headings, icons, borders and badges alike.
- Grey text on a coloured panel, or light grey placeholder text, fails 4.5:1.
- Error and success are distinguished only by red and green.
- The dark theme is a `filter: invert()` or the same saturated hues on black.

## Pass

**Look for**: raw colour values in components; near-duplicate greys and
accents; accent used for decoration; computed contrast failures in every
state and theme, including hover, disabled, placeholder, text over images and
focus rings; status or data encoded by colour alone; a mechanically inverted
dark theme.

**Safe fix**: point raw values at the existing tokens. Merge near-duplicates
into the token they were approximating. Adjust lightness within the same hue
until the pair passes. Add an icon or text beside colour-only status. Strip the
accent off decoration so it points at action again.

**Stop at**: changing brand colours, adding a theme, or building a palette from
scratch. Propose the palette with its roles and contrast pairs, and let the
operator decide.
