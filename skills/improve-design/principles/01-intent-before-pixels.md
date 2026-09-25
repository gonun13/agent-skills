# Intent Before Pixels

Before changing how a surface looks, know who uses it, where they use it, and
the one thing it exists to do. A design is good or bad only against a purpose.
The same pale, spacious layout is right for a portfolio and wrong for an
operations console.

## Why it holds

Without a stated purpose, every choice falls back to the statistically average
one. That average is exactly what makes an interface look generated. The
purpose is also what settles disputes later. "Is this heading too big?" has no
answer until you know whether the page is trying to persuade someone or help
them finish a task.

## In practice

- Name the surface's **mode** from what the visitor's success looks like, not
  from the product category:
  - **Persuade**: the visitor decides and acts. Landing, pricing, campaigns.
  - **Operate**: the visitor completes a task. App UI, dashboards, settings,
    admin. Scanability and consistency outrank expression.
  - **Read**: the visitor understands something. Docs, articles, help,
    changelogs. Measure and structure come first.
  - **Experience**: the visitor is inside the work. Portfolios, galleries,
    showcases. The interface recedes.

  A developer tool's landing page is still Persuade, and its docs are still
  Read.
- Name the incumbent world: the palette, type, spacing, shapes, icons and voice
  already committed in code or in a written decision. Refinement works inside
  it. Redesign replaces it on purpose, and only when asked.
- Pick light or dark from the use scene: who, where, and under what light. Do
  not pick it from habit or category.
- The brief's own words win. If it pins a style, even a common one, follow it
  exactly. What these principles push against is a default nobody chose.

## How to tell it is being violated

- Nobody can say in one sentence what a screen is for or what its primary
  action is.
- A settings page wears marketing clothes, such as hero-sized type and gradient
  panels. Or a landing page reads like an admin table.
- Recent components ignore the tokens or `DESIGN.md` the project already
  wrote down.
- Swapping the logo would make the page fit an unrelated product unchanged.

## Pass

**Look for**: surfaces whose purpose and primary action cannot be named; a
mode mismatch between treatment and job; a theme chosen by habit; recorded
design decisions (tokens, `DESIGN.md`, brand guidelines) that newer code
ignores; a page so interchangeable that it could belong to anyone.

**Safe fix**: write the design read for each surface in scope. That is one
short paragraph covering the audience, mode, primary job and incumbent world.
Then bring a surface back to its mode inside the existing tokens. For example,
drop a dashboard's display-size headings to the product's own type scale, or
re-point components at the tokens they bypassed.

**Stop at**: anything that changes identity or structure. That includes the
palette, typefaces, logo, voice, navigation, page order, or any existing URL
or route. Propose it as a redesign with its reasoning, and let the operator
decide.
