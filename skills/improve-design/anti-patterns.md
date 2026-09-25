# Anti-patterns: the tells of generated UI

These are the defaults an interface drifts toward when nobody decides. Models
reach for them, templates ship them, and a hurried team copies them. None is
wrong in every context. The brief's own words, or a recorded decision, can
earn any of them. But where an axis was left free, finding one here means no
decision was made. The fix is to rewrite the element, not to soften it.

Each entry names the tell, then what to do instead. The number in brackets is
the principle file that owns the fix.

## Page structure

- **Identical card grids as the page.** Rows of same-size cards, each an icon,
  a heading and two lines of text, carry the whole page. Instead, give content
  the shape of its own importance: lead with one item, and use a list, a table
  or prose when that is what the content is. [02, 03]
- **Three equal feature columns** under the hero. Instead, rank the features,
  and let the most important one take more room. [02]
- **The hero-metric template.** A big number, a small label, three supporting
  stats and a gradient accent. Use it only when the number really is the story,
  and the number is real. [02, 12]
- **An eyebrow over every heading**, meaning a tracked-out ALL-CAPS kicker
  above each section title. Instead, delete it and let the heading carry its
  own weight. At most one on a page, where it adds information. [02, 04]
- **Section numbers** (`01 / 02 / 03`, `001 · Capabilities`) on content that
  is not a sequence. Keep them only for real steps or timelines. [02]
- **A centred hero on a dark gradient mesh**, with a headline, a subline and
  two buttons. Instead, open with the most characteristic thing in the
  product's world: the product itself, a real image, a live demo, or a strong
  typographic statement. [01]
- **Zigzag monotony.** More than two consecutive image-and-text rows
  alternating sides. Change the layout family when the content changes. [03]
- **Nested cards**: a card inside a card inside a panel. Instead, flatten the
  structure, and group by space. [03]
- **Modal by reflex.** A dialog for a task that needs neither interruption nor
  protected focus. Edit inline, or on its own page. [08]
- **A logo wall with captions**, meaning category labels printed under each
  customer logo, or text standing in for logos. Show logos only, and real ones
  only. [12]

## Typography

- **Gradient text** on headings. Instead, take emphasis from weight, size or
  position. [04]
- **One accented word** in a headline, set in a different colour, italic or
  weight. Instead, commit the whole line to one treatment. [04]
- **ALL-CAPS tracked labels everywhere.** Keep uppercase for short, rare
  labels. [04]
- **Monospace as a costume** for "technical", on anything that is not code,
  data or measurement. [04]
- **The unexamined default face**: whatever the framework or system shipped,
  used as the brand's display voice with no decision behind it. [04]
- **Over-tight display tracking** below -0.04em, and display sizes that clip
  their descenders or overflow on mobile. [04, 10]

## Colour and surface

- **The "AI" palette**: a purple-to-blue gradient, neon glows, or a dark
  background with a violet accent, chosen because the product "does AI".
  Instead, choose hue from the product's meaning. [05]
- **Glow halos**: coloured `box-shadow` with zero offset used as decoration.
  Instead, shadows have an offset and a soft blur, and express elevation.
  [05, 06]
- **Glassmorphism as decoration**: blur and translucency with no layer behind
  them worth revealing. [05]
- **Side-stripe borders**: a coloured `border-left` wider than 1px on cards,
  list items, callouts or alerts. Instead, use an icon, a background tint or
  the heading. [06]
- **The ghost card**: a 1px border under a wide, soft shadow. Choose one of
  the two. [06]
- **One shadow on everything**, the same soft `rgba(0,0,0,.1)` under every
  element regardless of elevation. [06]
- **Over-rounding**: card radii above about 16px, and pill shapes on anything
  bigger than a small control. [06]
- **Hard offset shadows** (`4px 4px 0`) outside a world that really is
  neo-brutalist. [06]
- **Palette clichés**: a warm cream background with a high-contrast serif and a
  terracotta accent; near-black with a single acid-green or vermilion accent;
  beige, brass and espresso for "premium". Each is fine when the brief asks for
  it, and a tell when it does not. [01, 05]
- **Decorative texture**: grid lines, stripes, dot patterns or noise with no
  map, blueprint or canvas beneath them. [05]
- **Theme by category**, such as dark because the audience is developers.
  Instead, pick the theme from the use scene. [01]

## Decoration and chrome

- **Emoji or Unicode glyphs as icons**, or two icon libraries mixed. Use one
  drawn icon family at one stroke weight. [06]
- **Fake screenshots** built from `div`s and grey bars, and sketchy hand-drawn
  SVG "illustrations". Instead, use the real product, a real image, or an
  honest labelled placeholder. [12]
- **Chrome standing in for content**: decorative sparklines, progress rings,
  status dots and skeleton-looking blocks that mean nothing. [02]
- **Template meta-strings**: `A · B · C` joined by middle dots, labels built
  as `WORD — fragment` with a spaced em dash, and a `→` appended to every link
  and button. [12]
- **Scroll cues** ("Scroll", "↓", an animated mouse wheel), fake version badges
  (`BETA`, `v0.6`) and decorative locale or time strips that are not true or
  not needed. [12]

## Motion

- **The same fade-and-rise on every section.** Instead, create one authored
  moment, and let the rest stay still. [09]
- **Hover lift on every card**, and zoom on images that are not actions. Put
  hover feedback on the actual target. [09]
- **Bounce and elastic easing** on routine UI. [09]
- **Parallax and marquees by default.** Use at most one marquee, and only with
  a reason. [09]
- **Content hidden until JavaScript animates it in.** [09]

## Content

- **Placeholder people and companies**: "John Doe", "Jane Smith", "Acme",
  "Nexus", "Cloudly". [12]
- **Fake-precise or fake-round numbers**: `99.99%`, `10x faster`, `1,234,567
  users`, `$0 to $1M`, with no source behind them. [12]
- **Filler verbs**: elevate, seamless, unleash, supercharge, revolutionise,
  empower, unlock, next-generation. [12]
- **Duplicate calls to action with different wording** on one page: "Get in
  touch" and "Contact us". [02, 12]
- **Invented testimonials, ratings or customer logos.** Never ship these. Use a
  labelled placeholder and a line under **Needs a human**. [12]
- **Lorem ipsum shipped.** [12]
