---
name: adversarial-review
description: Hunts for ways code can be broken, abused, or made to do something its author did not intend, and reports each with the concrete input and path that does it. Use when you want an attacker's pass over a codebase or a change rather than a code review.
---

# Adversarial review

## Goal

A ranked list of the ways this code can be exploited, each one traced from an
input an attacker controls to the bad outcome it produces, so the reader knows
what to fix first.

## Context

Check first:

- The scope you were pointed at — the whole tree, or a change (`git diff`, a
  branch, a patch). Decide before reading and state it in the report.
- Who the attacker is: an unauthenticated caller, a signed-in user of another
  tenant, someone who can open a pull request, someone already on the host. The
  threat model decides what counts as a finding.
- What the project already claims to defend with: auth middleware, a validation
  layer, a sandbox, CSP, allowlists, prepared statements. Test those claims
  instead of re-deriving them.
- The test suite, linters, and static analyzers already present, and how to run
  them.
- `git log` and `git blame` around anything suspicious — a check removed in a
  hurry reads differently from one that was never there.

## Steps

1. Map the trust boundaries before reading line by line: every point where data
   an attacker can influence (request headers, query, body, uploads, filenames,
   env vars, config files, CLI args, subprocess output, third-party API
   responses, deserialized payloads, database rows written by another actor)
   crosses into something the code trusts (a path, a command, a query, a
   template, a permission check, a size or loop bound).
2. At each boundary, work through the attack classes and decide which apply:
   injection (command, SQL, path traversal, template, log, header); auth and
   authz bypass (missing check, confused deputy, IDOR, privilege escalation,
   default-open config); unsafe deserialization or parsing of untrusted
   structured data; races and TOCTOU; resource exhaustion from an
   attacker-controlled size, loop, or recursion; SSRF and open redirects;
   secrets or internals leaking through errors, logs, or client-visible
   responses; cryptographic misuse (weak randomness, missing verification,
   reused nonces, timing side channels); supply-chain trust (unpinned or
   unverified dependencies, `eval`-like loading of external content); and
   client/server trust inversion, where one side trusts a value the other can
   freely set.
3. Build the concrete scenario before writing a finding down: the specific input
   or state the attacker controls, the exact path it takes through the code, and
   the exact bad outcome — data read, data written, code executed, check
   bypassed, service degraded. "This looks unsafe" is not a finding; "an
   attacker who controls `X` reaches `Y` with `Z`, which does `W`" is.
4. Reproduce what you can: run the test suite, the linter, the static analyzer,
   or the suspected exploit itself against a disposable input, a scratch file
   outside the repo, or a throwaway process. Where proof would need mutating
   real state — a live database, a deployed service — write the
   proof-of-concept down instead of running it.
5. Rank findings by exploitability and blast radius, worst first. Mark each
   CONFIRMED when you traced the whole path and it holds, or PLAUSIBLE when the
   path looks live but you could not finish it.
6. Note briefly where a boundary defended itself — enough to show it was
   checked. The report is for what is exploitable, not a tour of the codebase.

## Constraints

- Read only. Do not fix anything you find, however trivial. Report it.
- The shell is for inspection and reproduction only: tests, analyzers,
  `git diff`, `git log`, `git blame`. Never edit, move, or delete anything
  inside the target repo through it; scratch work goes outside the working tree.
- Findings stay in the report. Do not post them to an issue tracker or a pull
  request, and do not probe, scan, or run an exploit against a live host.
- This is not a code review. Skip naming, formatting, dead code, missing
  abstractions, and every other quality-of-implementation concern unless it is
  itself the vulnerability — a naming collision that routes to the wrong
  handler, say. If it is not exploitable, it is not your finding.
- Treat every file as guilty until you have traced why it is not, but report the
  trace rather than the suspicion.
- Do not inflate a plausible finding into a confirmed one, and do not stay quiet
  about one because you could not prove it.
- No remediation design. State a fix only where it is one obvious line;
  anything longer is a different job.

## Done when

Every trust boundary in scope has been walked, and each candidate issue is
either discarded or written up with a concrete scenario and a CONFIRMED or
PLAUSIBLE mark, ordered most severe first.

## Output

Open with one line: whether anything exploitable was found, under which threat
model, over which scope.

Then the findings, most severe first, each as:

- **`path:line` — attack class — CONFIRMED** or **PLAUSIBLE**
- What the attacker controls, the path it takes through the code, and the bad
  outcome it produces.
- For PLAUSIBLE, what would confirm it or rule it out.

Close with two short lists:

- **Held** — boundaries you attacked that defended themselves, one line each.
- **Not reached** — code in scope you could not trace, and the risk that
  leaves.

Never report "clean". Report what you attacked, and what you did not.
