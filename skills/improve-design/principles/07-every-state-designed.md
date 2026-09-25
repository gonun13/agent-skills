# Every State Designed

A screen is not one picture. It is loading, empty, full, overflowing, failing,
partly permitted, and done. Controls have default, hover, focus, active,
disabled and busy states. Design each state that can occur, or the user will
meet the one you skipped.

## Why it holds

Mock-ups show the happy path with ideal content, but real use rarely matches
it. A blank list gives no clue whether it is loading, empty or broken. A button
with no busy state gets clicked twice. A name longer than the one in the
mock-up breaks the row. The missing states are where users lose trust, and
they are where generated and hurried interfaces are thinnest.

## In practice

- Give every interactive element visible **hover** (where hover exists),
  **focus-visible**, **active**, **disabled** and, for async actions, **busy**
  states. A disabled control should show or explain why it is disabled.
- Give **loading** an honest indicator. Skip it for waits under about 300ms,
  where a flash is worse than nothing. Use a skeleton that keeps the layout for
  content-shaped waits, and name the operation for long ones. Never invent
  progress.
- Treat **empty** as an invitation. Tell first use, no results, filtered to
  nothing, no permission and failure apart, and give each one the next useful
  action.
- Make **errors** say what failed and how to recover, next to where the
  problem is. Keep the user's input.
- Keep **success** brief for routine actions. Confirm the outcome with the
  same verb as the action.
- Stress the **content extremes**: zero, one and hundreds of items; a
  60-character name; a missing avatar; a very large number; a translation 40%
  longer. Wrap rather than truncate. When truncating, expose the full text.
- Reserve space for content that arrives late, so data never shoves the layout
  about.

## How to tell it is being violated

- Buttons have no pressed or focus style, or can be submitted twice while a
  request is in flight.
- A list or table renders as blank space when there is no data.
- A failure shows up only in the console, or as "Something went wrong".
- A long user name or title overflows its container or pushes controls off
  screen.
- The page jumps when data, images or fonts arrive.

## Pass

**Look for**: controls missing any of hover, focus-visible, active, disabled
or busy styles; async actions without a pending state or double-submit guard;
lists, tables and search results without empty states; generic or silent
errors; layouts that break at content extremes; spinners where a skeleton
would hold the layout; content-induced layout shift.

**Safe fix**: add the missing states with existing tokens and components. Set
`disabled` and `aria-busy` during pending actions. Add empty states with a next
action that already exists in the product. Reserve space with `aspect-ratio` or
`min-height`. Allow long strings to wrap with `overflow-wrap: anywhere`.

**Stop at**: states that need new behaviour or data. That includes retry
logic, undo, optimistic updates, offline caching, or an error the API does not
yet expose. Propose them, naming the backend support each would need.
