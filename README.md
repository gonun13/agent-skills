# agent-skills

`askill` is a non-invasive small interactive launcher for running reusable instructions with
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

Skills are folders containing a `SKILL.md`:

```text
skills/
├── _template/
│   └── SKILL.md
├── adversarial-review/
│   └── SKILL.md
├── changelog/
│   └── SKILL.md
├── diagnose/
│   └── SKILL.md
├── docs-drift/
│   └── SKILL.md
├── improve-seo/
│   └── SKILL.md
├── janitor/
│   └── SKILL.md
├── kickoff/
│   └── SKILL.md
├── nta-scan/
│   └── SKILL.md
├── repo-recon/
│   └── SKILL.md
├── software-architecture/
│   ├── SKILL.md
│   └── principles/
│       ├── 01-separation-of-concerns.md
│       └── ...
├── spec-driven-dev/
│   └── SKILL.md
└── stack-advise/
    └── SKILL.md
```

The folder name is the name shown in the menu. Folders beginning with `_` are
not listed.

## Usage

```console
$ ./askill
```

If you want, you can put the root `askill` script on your `PATH`, for example:

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
- Mistral Vibe (`vibe`)
- opencode (`opencode`)

Each mode maps to that CLI's own equivalent:

| | plan | auto |
|---|---|---|
| claude | `--permission-mode plan` | `--permission-mode auto` |
| cursor-agent | `--mode plan` | `--sandbox enabled` |
| codex | `--sandbox read-only` | `--sandbox workspace-write --ask-for-approval on-request` |
| copilot | `--mode plan` | `--mode autopilot` |
| Mistral Vibe | `--agent plan` | `--agent accept-edits` |
| opencode | `--agent plan` | `--agent build --auto` |

`auto` is the provider's auto mode, not its bypass: the agent works without
stopping at every approval, but the CLI's sandbox and deny rules stay in force.
No permission-bypass flag is ever passed, and a test asserts it.

It still writes to the project you selected — there is no worktree or
confirmation step. `plan` is the read-only choice.

## Writing a skill

Copy `skills/_template/` to `skills/<skill-name>/`, update the `name` and
`description` in `SKILL.md`, and write the instructions. `askill` passes the
skill body (frontmatter stripped) to the provider as the first prompt.

A skill folder may carry supporting files beside its `SKILL.md`. Only the
`SKILL.md` body is sent as the prompt, so anything else has to be findable
by path from the selected project's working directory — which is why the
layout above puts this repository beside the projects it is run against.

## Development

```console
$ ./tests/run.sh
$ shellcheck askill tests/run.sh
```
