# agent-skills

`askill` is a non-invasive small interactive launcher for running reusable instructions with
the coding-agent CLI already installed on your machine. The skills it runs
live in [`skills/`](skills/), one folder each.

## Install

From the folder that holds your projects, clone this repository beside them;
`askill` offers every sibling folder as a project:

```sh
git clone https://github.com/gonun13/agent-skills.git
```

It needs Bash and at least one supported CLI: Claude Code (`claude`), Cursor
Agent (`cursor-agent`), Codex CLI (`codex`), GitHub Copilot CLI (`copilot`),
Mistral Vibe (`vibe`), or opencode (`opencode`). Only installed ones are listed.

## Usage

Run it and pick a skill, project, provider, and mode with the arrow keys or by
number:

```console
$ ./agent-skills/askill

Skill
  1) adversarial-review
  2) changelog
  ...
> 1

Project
  1) agent-skills
  2) project-one
  3) project-two
> 2

Provider
  1) Claude Code
> 1

Mode
  1) auto
  2) plan
> 2

Opening Claude Code in project-one with adversarial-review (plan).
```

`askill` then opens the provider's normal interactive CLI in that project with
the skill as the first prompt. Everything after launch belongs to the provider.

`auto` is the provider's own auto mode, not a permission bypass, but it still
writes to the selected project with no worktree or confirmation step. `plan` is
the read-only choice. The per-provider flags are in [`askill`](askill).

To write a skill, copy `skills/_template/` to `skills/<skill-name>/` and edit
its `SKILL.md`. Only the `SKILL.md` body is sent, so any supporting files must
be referenced by a path that resolves from the project directory.

Tests: `./tests/run.sh` and `shellcheck askill tests/run.sh`.

License: [MIT](LICENSE)
