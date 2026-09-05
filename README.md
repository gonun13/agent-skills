# agent-skills

`askill` is a small interactive launcher for running reusable instructions with
the coding-agent CLI already installed on your machine.

```console
$ askill

Skill
  1) repo-recon
> 1

Project
  1) my-project
> 1

Provider
  1) Claude Code
> 1

Mode
  1) auto
  2) plan
> 2
```

It then changes into the selected project and replaces itself with the
provider's normal interactive CLI, using the selected skill as the first
prompt. Authentication, configuration, model selection, session persistence,
and everything after launch belong to the provider.

## Layout

Clone this repository beside the projects you want to work on:

```text
workspace/
├── agent-skills/
├── project-one/
└── project-two/
```

Skills are single Markdown files:

```text
skills/
├── _template.md
└── repo-recon.md
```

The filename is the name shown in the menu. Files beginning with `_` are not
listed.

## Install

Put the root `askill` script on your `PATH`, for example:

```console
$ ln -s "$PWD/askill" ~/.local/bin/askill
```

The only runtime dependency is Bash plus at least one supported provider CLI.

## Providers

Only installed CLIs appear in the menu:

- Claude Code (`claude`)
- Cursor Agent (`cursor-agent`)
- Codex CLI (`codex`)
- GitHub Copilot CLI (`copilot`)
- opencode (`opencode`)

`plan` uses each provider's native plan or read-only mode.

`auto` deliberately disables approval and sandbox protections so the provider
can work without interruption. It is equivalent to the provider's dangerous
or unattended mode and can modify files or run commands directly in the
selected project. There is no worktree, confirmation, target guard, or askill
safety layer.

## Writing a skill

Copy `skills/_template.md` to `skills/<skill-name>.md`, update its `name` and
`description`, and write the instructions. `askill` passes the complete file to
the provider as the first prompt.

## Development

```console
$ ./tests/run.sh
$ shellcheck askill tests/run.sh
```
