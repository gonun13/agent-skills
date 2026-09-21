# Record Decisions and Enforce Guardrails

Write down the architectural decisions that matter, with their reasons, and
make the rules that follow from them checkable by a machine. Knowledge that
lives only in people's heads leaves when they do; rules that are only in a
document drift.

## Why it holds

Two distinct failures, and they need each other's fix. Without records, the
same debate is had every year by people who do not know it was settled, and a
constraint that was chosen deliberately is undone by somebody who reasonably
assumed it was an accident — the reason is what makes a decision re-evaluable,
and it is the part that is always missing. Without automated guardrails, a
recorded decision decays anyway: the boundary holds in review for six months
and then somebody is in a hurry. A record says what was decided; a check keeps
it true.

## In practice

- One record per decision: the context, the options considered, what was
  chosen, the consequences accepted. Short enough to actually be written.
- Record the *reason*, not just the rule. A rule without its reason cannot be
  revisited, only obeyed or broken.
- Keep records immutable and supersede them. Editing a decision to say something
  else destroys the history that made it worth writing.
- Keep them with the code, in version control, so the decision and the thing it
  decided move together.
- Automate what can be automated: dependency direction, layering, allowed
  imports, contract compatibility, budgets. Run it in CI, where it blocks.
- A guardrail must name the rule it is enforcing and where that rule was
  decided. A failure that just says "forbidden" teaches nobody.

## How to tell it is being violated

- "Why is it like this?" has no answer but "before my time".
- A settled question is reopened in review every few months.
- A documented boundary is violated in several places and nobody noticed.
- A decision record has been edited to reverse its own verdict.

## Pass

**Look for** — constraints that live only in review comments or chat; a
documented boundary violated in several places nobody noticed; a decision
record edited to reverse its own verdict instead of superseded; rules stated
without their reason; a documented rule with nothing in CI keeping it true.

**Safe fix** — write the missing record where the project already keeps them
(`spec/decisions/`, `docs/adr/`, `AGENTS.md`): context, options, choice,
consequences, and above all the reason. Where a rule is already stated and
already checkable by a tool the project already runs, add the check and make
its failure message name the rule and where it was decided.

**Stop at** — adding a linter, a CI job or a dependency the project does not
have, and superseding a decision that is not yours to supersede. Record what
you found and hand it to the owner.
