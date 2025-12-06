#!/bin/bash
# Sync prompts to pi custom commands directory

set -e

PROMPTS_DIR="$HOME/code/prompts"
PI_COMMANDS="$HOME/.pi/agent/commands"

# Sync commands
rm -f "$PI_COMMANDS"/*.md
cp "$PROMPTS_DIR/commands/"*.md "$PI_COMMANDS/"

# Sync skills
rm -rf "$PI_COMMANDS/skills"
mkdir -p "$PI_COMMANDS/skills"
cp "$PROMPTS_DIR/skills/"*.md "$PI_COMMANDS/skills/"

echo "Synced $(ls "$PI_COMMANDS"/*.md | wc -l) commands"
echo "Synced $(ls "$PI_COMMANDS/skills/"*.md | wc -l) skills"
