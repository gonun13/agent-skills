# Interaction and Feedback

Controls look like what they do, respond at once, and forgive mistakes. A
button is a `<button>`, a link goes somewhere, a form says what it needs before
it is submitted, and every action gets an answer within a tenth of a second.

## Why it holds

People act on affordances. When something looks tappable and is not, or does
something other than its label says, they stop trusting the whole interface.
Feedback delay reads as failure, so people repeat the action. Hover-only
information does not exist on touch screens. Forms are where most products
actually lose users: every unclear label or late error costs completions.

## In practice

- Use the native element for the job: `<button>` for actions, `<a href>` for
  navigation, and real `<input>`, `<select>` and `<dialog>`. They bring
  keyboard support, semantics and focus behaviour for free.
- Acknowledge every press within about 100ms, even if the result takes longer.
- Make targets at least 44×44px on touch, and never below the WCAG 2.2 floor
  of 24×24 CSS px, with about 8px between them. Extend the hit area with
  padding when the visible mark is small.
- Hover can enhance, but it is never the only path to information or action.
- Forms:
  - Put a persistent label above each field. A placeholder is an example, not
    a label.
  - State requirements and formats up front.
  - Validate on blur, not on every keystroke.
  - Place each error below its field and link it with `aria-describedby`.
  - Use the right input `type` and `autocomplete`, and never block paste.
- Destructive actions name the object and consequence, sit apart from routine
  actions, and prefer undo to a confirmation dialog when recovery is possible.
- Use a modal only when the task needs interruption or protected focus. A modal
  traps focus, closes on Escape, and returns focus to its trigger.
- Navigation shows where you are, keeps back behaviour predictable, and gives
  every meaningful state a URL. The URLs that already exist are a contract:
  links may be restyled, but their destinations, paths and query parameters do
  not change.

## How to tell it is being violated

- `<div onClick>` or `<span>` acts as a button, or buttons are used to
  navigate.
- Inputs are identified only by their placeholder.
- Icon buttons are 24px or smaller on touch layouts, crowded together.
- Tooltips or hover menus carry information that no other path exposes.
- The labels are "Submit", "OK", "Yes" or "No".
- Modals are used for simple edits, cannot be closed with Escape, or strand
  focus behind them.
- Nothing marks the current page in the navigation.

## Pass

**Look for**: non-semantic interactive elements; placeholder-only labels;
missing `type`, `autocomplete` or `inputmode`; paste blocked on inputs;
targets below 44px on touch or 24px anywhere; hover-only affordances; errors
shown only at the top or only on submit; unguarded destructive actions; modals
without focus management or Escape; navigation with no current-location state.

**Safe fix**: swap in the native element and keep the styling. A
`<div onClick>` or button that navigates becomes an `<a href>` to the exact
same destination. Add labels,
input types and `autocomplete`. Enlarge hit areas with padding or a
pseudo-element. Move errors beside their fields and link them. Add
`aria-current` to the navigation. Add Escape handling and focus return to
existing modals.

**Stop at**: changing a flow's steps, field order or field names. Those feed
the backend, analytics and autofill. Stop also at replacing a modal with a page
or inline pattern. Propose both with the reasoning.
