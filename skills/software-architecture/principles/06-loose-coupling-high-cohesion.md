# Loose Coupling, High Cohesion

Two questions about every boundary, asked together. Coupling: how much does
this part need to know about that one? Cohesion: how closely related is what is
inside this part? You want little of the first and a lot of the second.

## Why it holds

They are two halves of one judgement, and optimising either alone produces a
worse system. Chase loose coupling on its own and you get a scatter of tiny
components that must all be changed and released together — the coupling moved
into the release process, where it is harder to see. Chase cohesion on its own
and you get one well-organised component that everything depends on. Change
stays cheap only when a change is local *and* the things that change together
live together.

## In practice

- Put what changes together in the same unit, and release it together.
- Communicate through the narrowest thing that works: a value, an event, a
  contract — not a shared table, a shared cache, or a shared in-memory object.
- Prefer knowing *that* something happened over knowing *who* will care.
- Measure coupling by what a change costs, not by counting imports. A single
  import of a stable interface is cheap; three imports of internals are not.
- Accept some duplication to avoid a dependency between things that are not
  really the same thing. Two rules that coincidentally agree today are two
  rules.

## How to tell it is being violated

- A feature touches five repositories and they must be deployed in order.
- A component's tests break when an unrelated component changes.
- Two modules import each other, directly or through a cycle.
- A shared library is where every team puts anything, and everyone waits on it.

## Pass

**Look for** — import cycles, direct or through a chain; a component whose
tests break when an unrelated one changes; a feature that touches several
packages that must then move together; a `shared` or `common` library everyone
depends on and everyone waits on; components talking through a shared table,
cache or in-memory object instead of a value, an event or a contract.

**Safe fix** — move what changes together into the same unit. Break a cycle by
moving the shared piece down into something both sides depend on, or by
inverting one direction (`04`). Duplicating a small rule to remove a dependency
between two things that are not really the same thing is a fix here, not a
regression.

**Stop at** — release units, deployment order, and anything that would replace
a shared store with an event or an API. Propose those with their cost.
