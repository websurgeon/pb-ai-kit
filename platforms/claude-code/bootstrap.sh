#!/usr/bin/env bash
# Bootstrap Claude Code skills for this project.
# Creates .claude/commands/ at the project root and symlinks all platform commands.
# Idempotent — safe to re-run; existing symlinks are skipped.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
COMMANDS_SRC="$SCRIPT_DIR/commands"
COMMANDS_DEST="$PROJECT_ROOT/.claude/commands/pb"

EXPECTED_SKILLS=(
  analyse
  audit
  chat
  commit
  dev
  init
  plan
  refactor
  review
  tdd
  wip
)

mkdir -p "$COMMANDS_DEST"

created=0
skipped=0

for skill in "${EXPECTED_SKILLS[@]}"; do
  src="$COMMANDS_SRC/${skill}.md"
  dest="$COMMANDS_DEST/${skill}.md"
  rel_src="../../../.ai/platforms/claude-code/commands/${skill}.md"

  if [ ! -f "$src" ]; then
    echo "  WARN  source not found: $src" >&2
    continue
  fi

  if [ -L "$dest" ]; then
    ((skipped++)) || true
  else
    ln -s "$rel_src" "$dest"
    echo "  created  $dest"
    ((created++)) || true
  fi
done

echo ""
echo "Done. Created: $created  Skipped (already present): $skipped"
echo ""
echo "⚠️  New session required for /pb:* slash commands to work."
echo "   In this session, skills can still be activated — just ask Claude directly."
