---
name: nta-scan
description: Maps every outbound and inbound network path in a codebase, plus the commands and tools it executes, and rates each as expected or not, into an NTA.md report. Use when checking a codebase for exfiltration, backdoors, or unexplained network access.
---

# NTA scan

## Goal

An `NTA.md` at the repo root tabling every place this codebase reaches the
network, is reached from it, or shells out — each traced to a reason — so an
operator can see at a glance whether anything is unaccounted for.

## Context

Check first:

- What the project is for (README, manifest). That is the baseline for
  "expected": a deploy tool calling a cloud API is expected, a Markdown parser
  doing the same is not.
- Declared endpoints: config files, `.env.example`, compose and chart files, CI
  configuration, `Dockerfile` exposed ports.
- The dependency manifest and lockfile, including install and postinstall hooks.
- Whatever the project already states about egress: CSP headers, allowlists,
  network policies, proxy settings.
- `.gitignore` and any existing `NTA.md` from an earlier scan.

## Steps

1. Write down the network access this project legitimately needs before looking
   for any. Judge every finding against that baseline.
2. Outbound: HTTP and socket clients (`fetch`, `axios`, `requests`, `httpx`,
   `net/http`, `urllib`, `socket`, gRPC stubs, cloud SDKs), webhook senders, DNS
   lookups, and remote script, font, or asset URLs in HTML and templates.
3. Telemetry: analytics, crash and error reporting, update checks, licence or
   heartbeat pings. These are usually legitimate and rarely documented — list
   each one and what it puts in the payload.
4. Inbound: listening servers, route tables, bound ports, websockets, queue and
   webhook consumers, callback URLs, and anything that reads stdin, a watched
   file, or fetched content into a parser or deserializer.
5. Execution: `exec`, `spawn`, `system`, backticks, `eval`, dynamic import, and
   the shell in `Makefile`, `package.json` scripts, git hooks, `Dockerfile`, CI
   workflows, and install hooks. For each, say what it runs and where the
   command and its arguments come from. A command built from remote or user
   input, or a `curl ... | sh`, is a finding rather than a footnote.
6. Agent surface: MCP servers, tool and plugin definitions, registered model
   tools — what each is allowed to reach, and who can trigger it.
7. Concealment: hostnames or commands assembled at runtime from fragments,
   base64 or hex blobs, checked-in minified or binary files, and URLs in
   comments or fixtures pointing somewhere unrelated to the project.
8. Exfiltration shape: trace whether anything reading secrets, environment,
   credential files, browser data, or user documents reaches an outbound call
   from step 2. State the result explicitly, including when nothing does.
9. Account for every host: what it is and who owns it. A destination you cannot
   explain is Unknown at high severity, not benign.
10. Write the report to `NTA.md` at the repo root, replacing any earlier one,
    and add `NTA.md` to `.gitignore` if it is not already ignored. Create
    `.gitignore` if the repo has none. The report names internal hosts and weak
    spots, so it stays local unless the operator decides otherwise.

## Constraints

- `NTA.md` and the one `.gitignore` line are the only files you may write.
  Everything else is read only.
- Offline. Do not run the project or its scripts, do not send a request to any
  host you found, do not resolve or probe one.
- Never read `.env` or other environment files, key material, or credential
  stores. Variable names from `.env.example` are enough.
- Dependency code is in scope where it is vendored into the repo or runs an
  install hook. Auditing the whole tree is a different job — say if you skipped
  it.
- Judge from evidence in the repo, not from a library's reputation.
- Never report "clean". Report what you inspected, and what you did not.

## Done when

`NTA.md` exists, is ignored by git, and every outbound destination, inbound
entry point, and executed command found in the repo appears in one of its tables
with a reason — anything unaccounted for listed under Unknown.

## Output

`NTA.md`, dated, opening with one line: whether anything unexpected was found.

Then three tables, using `path:line` in Where:

**Outgoing**

| Destination | Where | Reason | Severity | Expected |
| --- | --- | --- | --- | --- |

**Incoming**

| Source | Where | Reason | Severity | Expected |
| --- | --- | --- | --- | --- |

**Executes**

| Command | Where | Reason | Severity | Expected |
| --- | --- | --- | --- | --- |

Severity is `none` for routine, `low` for worth knowing, `medium` for sensitive
data or an unclear destination, and `high` for an unaccounted-for destination,
concealment, or a path from secrets to the network. Expected is `yes`, `no`, or
`unclear`; on a healthy codebase nearly every row is `yes`.

Close with two short lists:

- **Unknown** — hosts, commands, or code paths you could not account for, and
  what would settle each.
- **Not inspected** — what was out of scope, and the risk that leaves.

In chat, report only the opening line, the `high` and `unclear` rows, and where
`NTA.md` was written.
