# Words Are Interface

Labels, buttons, errors, empty states and helper text are part of the design,
not something poured into it afterwards. They say what something is, what will
happen, and what to do next. They should say it in the user's language, once,
and the same way every time.

## Why it holds

People read interfaces in fragments, a button here and a heading there. Every
fragment has to stand on its own. A vague label forces a guess. An error with
no remedy forces a support ticket. Two names for one concept teach people that
two things exist. Copy is also where a generated interface gives itself away
fastest: filler verbs, fake names and invented numbers.

## In practice

- Name things by what users understand, not by how the system is built. People
  manage notifications, not webhook configuration.
- An action is a verb plus an object that says what happens: "Save changes",
  "Send invite", "Delete project". An action keeps its name through the whole
  flow: the "Publish" button leads to a "Published" message.
- An error says what failed, why (when that is known and useful), and how to
  recover, in the interface's voice. It does not apologise, joke or blame, and
  a code is never the main message.
- An empty state explains the situation and offers the next action. A loading
  message names the real operation.
- Say each idea once. If the heading already explains it, the intro adds
  something new or goes.
- Use sentence case, plain verbs and no filler. Keep the tone steady, and
  adjust it to the stakes of the moment.
- Link text makes sense out of context. Five "Learn more" links are five
  identical links to a screen reader.
- A confirmation names the action on both the message and the button: "Delete
  3 files?" with "Delete files" and "Cancel".
- Write whole, translatable strings. Do not concatenate fragments. Leave room
  for 30–40% expansion.

## How to tell it is being violated

- Buttons read "Submit", "OK", "Yes", "Click here" or "Learn more".
- Errors read "Invalid input", "Error 500" or "Something went wrong" with no
  next step.
- One concept has two names across screens, such as Workspace and Project, or
  Remove and Delete.
- Title Case and sentence case are mixed at the same level.
- Placeholder copy has shipped: lorem ipsum, "John Doe", "Acme", `99.9%`,
  "Elevate your workflow".
- A heading is followed by an intro that restates it.

## Pass

**Look for**: generic action labels; errors without a cause or remedy; empty
states without an action; inconsistent terms for one concept; mixed casing
conventions; ambiguous link text; filler and placeholder copy; concatenated
strings; confirmations that do not name the action.

**Safe fix**: rewrite microcopy that already exists, meaning labels, buttons,
errors, empty states, helper text and link text, keeping its meaning. Unify
terms onto the one the product uses most. Normalise casing. Flag, but do not
invent, the content that placeholder copy stood in for.

**Stop at**: marketing and brand copy, factual claims, prices, and legal or
consent text. Stop also at renaming a domain term, and at i18n keys shared
across the codebase. Propose each change with the before and after, and let
the owner of the voice decide. Copy never changes a URL. Renaming a page or
navigation label leaves its path and slug alone. A reworded heading whose
`id` is generated from its text keeps the old `id`, so that existing
`#fragment` links still land.
