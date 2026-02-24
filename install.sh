#!/bin/bash
set -e

SKILL_DIR="$HOME/.claude/skills/handoff-package"
SKILL_URL="https://raw.githubusercontent.com/c3-jthalbert/handoff-package/main/SKILL.md"

mkdir -p "$SKILL_DIR"
curl -sL "$SKILL_URL" -o "$SKILL_DIR/SKILL.md"

echo "Installed handoff-package skill to $SKILL_DIR/SKILL.md"
echo "It will be available in your next Claude session."
