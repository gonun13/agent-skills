---
name: diagnose
description: Works a bug or performance regression through a gated loop — reproduce, minimise, hypothesise, instrument, fix, regression-test — without touching code before the fault is understood. Use when something is broken, throwing, failing, or slow.
---

# Diagnose

## Goal

The root cause of one defect, proven by a reproduction that goes red before the
fix and green after it, with a regression test that keeps it that way.

## Context

Check first:

- The symptom. If the operator has not described one, ask for it, or find it:
  a failing test, a red CI job, a stack trace in the logs, an open issue. Get
  the exact error text, the input that triggers it, and the expected behaviour
  before doing anything else.
- How the project runs its tests and a single test in isolation, so the
  feedback loop is seconds rather than minutes.
- Whether the bug is new: `git log` and `git bisect` around the affected code
  tell you if there is a commit that introduced it, which is usually the
  shortest route to the cause.
- Existing tests near the fault. They show how the code is meant to be
  exercised and where a regression test belongs.

## Steps

Each step is a gate. Do not move on until it has produced what it says.

1. Reproduce. Get a command that fails, reliably, for the reason reported.
   Prefer a failing test; fall back to a script or a request against a locally
   running instance. If you cannot reproduce it, stop and report what you tried
   — a fix for a bug you cannot see is a guess.
2. Minimise. Shrink the input, the setup, and the code path until the smallest
   thing that still fails remains. Strip everything the failure does not depend
   on. The minimal case is what becomes the regression test.
3. Hypothesise. Write down one specific claim about the cause — which line,
   which value, which ordering — and what observation would prove it wrong.
   "Something in the parser" is not a hypothesis; "`parse()` treats an empty
   string as the end of input at line 142" is.
4. Instrument. Test the hypothesis with evidence, not by reading harder: a
   debugger, a print of the actual value at the suspect point, an assertion, a
   profiler for a regression in speed. If the evidence disproves it, return to
   step 3 with what you learned. Remove instrumentation before the fix lands.
5. Fix. Change the smallest thing that corrects the cause you proved, not the
   symptom you saw. If the true fix is large or touches a design decision, stop
   and say so with the evidence rather than patching around it.
6. Regression-test. Turn the minimal case from step 2 into a permanent test
   beside the existing ones. Confirm it fails with the fix reverted and passes
   with it applied, then run the full suite.

## Constraints

- No code changes before step 5, other than temporary instrumentation. A fix
  attempted before the cause is proven is a second bug waiting to happen.
- One defect per run. If you find another on the way, note it under Also
  found and leave it.
- The fix touches only what the cause requires. No drive-by refactors,
  renames, formatting, or "while I was here" cleanups.
- Never mutate real state to reproduce: use a disposable database, fixture, or
  process, never a live one.
- Do not weaken or delete a failing test to make the suite green. If a test is
  wrong, say why with evidence and let the operator decide.
- If you cannot get past a gate, report where you stopped and what you have.
  A partial diagnosis with evidence is worth more than a complete one without.

## Done when

The regression test fails on the pre-fix code and passes on the post-fix code,
the full suite passes, and the diff contains only the fix and the test.

## Output

- **Symptom** — what was reported, quoted.
- **Reproduction** — the exact command that failed, and its output.
- **Cause** — the line or interaction at fault as `path:line`, and the
  evidence that proved it. List hypotheses that were tested and ruled out.
- **Fix** — what changed and why that is the cause and not the symptom.
- **Regression test** — where it lives, and confirmation it went red then
  green.
- **Also found** — other defects noticed and left alone.
- **Stopped at** — if a gate could not be passed: which one, what was tried,
  and what would get through it.
