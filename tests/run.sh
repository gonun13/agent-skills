#!/usr/bin/env bash

set -u

repo="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

passed=0
failed=0

assert_contains() {
  local value="$1"
  local expected="$2"
  if [[ "$value" == *"$expected"* ]]; then
    return
  fi
  printf '    expected to find: %s\n' "$expected"
  printf '    in: %s\n' "$value"
  return 1
}

assert_absent() {
  local value="$1"
  local unexpected="$2"
  if [[ "$value" != *"$unexpected"* ]]; then
    return
  fi
  printf '    expected not to find: %s\n' "$unexpected"
  printf '    in: %s\n' "$value"
  return 1
}

assert_no_bypass() {
  local value="$1"
  local flag
  for flag in --dangerously --yolo --allow-all bypassPermissions danger-full-access \
              'arg=--force' 'arg=disabled' 'arg=never'; do
    if [[ "$value" == *"$flag"* ]]; then
      printf '    bypass flag reached the provider: %s\n' "$flag"
      return 1
    fi
  done
}

run_case() {
  local provider="$1"
  local mode="$2"
  local expected="$3"
  local provider_bin="$provider"
  local mode_choice=1
  local case_dir="$tmp/$provider-$mode"
  local root="$case_dir/agent-skills"
  local project="$case_dir/sample-project"
  local stubs="$root/stubs"
  local capture="$case_dir/capture"
  local output

  [[ "$provider" == cursor ]] && provider_bin=cursor-agent
  [[ "$mode" == plan ]] && mode_choice=2

  mkdir -p "$root/skills" "$stubs" "$project"
  project="$(cd -P "$project" && pwd)"
  cp "$repo/askill" "$root/askill"
  chmod +x "$root/askill"

  cat > "$root/skills/example.md" <<'EOF'
---
name: example
description: UNIQUE_FRONTMATTER
---

UNIQUE_SKILL_INSTRUCTION
EOF
  printf 'must not appear in the menu\n' > "$root/skills/_template.md"

  cat > "$stubs/$provider_bin" <<'EOF'
#!/usr/bin/env bash
{
  printf 'cwd=%s\n' "$PWD"
  printf 'arg=%s\n' "$@"
} > "$ASKILL_CAPTURE"
EOF
  chmod +x "$stubs/$provider_bin"

  output="$(
    printf '1\n1\n1\n%s\n' "$mode_choice" |
      env PATH="$stubs:/usr/bin:/bin" ASKILL_CAPTURE="$capture" "$root/askill" 2>&1
  )" || {
    printf 'not ok - %s %s did not launch\n%s\n' "$provider" "$mode" "$output"
    failed=$((failed + 1))
    return
  }

  local recorded
  recorded="$(cat "$capture")"
  if assert_contains "$recorded" "cwd=$project" &&
     assert_contains "$recorded" "$expected" &&
     assert_contains "$recorded" 'UNIQUE_SKILL_INSTRUCTION' &&
     assert_absent "$recorded" 'UNIQUE_FRONTMATTER' &&
     assert_no_bypass "$recorded" &&
     [[ "$output" != *'_template'* ]]; then
    printf 'ok - %s %s\n' "$provider" "$mode"
    passed=$((passed + 1))
  else
    printf 'not ok - %s %s\n' "$provider" "$mode"
    failed=$((failed + 1))
  fi
}

run_case claude auto $'arg=--permission-mode\narg=auto'
run_case claude plan $'arg=--permission-mode\narg=plan'
run_case cursor auto $'arg=--sandbox\narg=enabled'
run_case cursor plan $'arg=--mode\narg=plan'
run_case codex auto $'arg=--sandbox\narg=workspace-write\narg=--ask-for-approval\narg=on-request'
run_case codex plan $'arg=--sandbox\narg=read-only'
run_case copilot auto $'arg=--mode\narg=autopilot'
run_case copilot plan $'arg=--mode\narg=plan'
run_case opencode auto $'arg=--agent\narg=build\narg=--auto'
run_case opencode plan $'arg=--agent\narg=plan'

help="$("$repo/askill" --help)"
if assert_contains "$help" 'Usage: askill'; then
  printf 'ok - help\n'
  passed=$((passed + 1))
else
  printf 'not ok - help\n'
  failed=$((failed + 1))
fi

printf '\n%d passed, %d failed\n' "$passed" "$failed"
(( failed == 0 ))
