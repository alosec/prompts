---
name: Update Commands
description: Sync prompts from ~/code/prompts to ~/.pi/agent/commands for pi-mono agent
---

# Update Commands

Sync prompt files from the prompts repository to pi-mono agent commands directory.

## Workflow

1. Edit/create prompts in `~/code/prompts/commands/` or `~/code/prompts/skills/`
2. Run sync script: `~/code/prompts/sync-to-pi.sh`
3. Commit changes to prompts repo

## Locations

```
Source (tracked in git)
├── ~/code/prompts/commands/*.md
└── ~/code/prompts/skills/*.md

Destination (pi-mono agent)
├── ~/.pi/agent/commands/*.md
└── ~/.pi/agent/commands/skills/*.md
```

## Quick Sync

```bash
~/code/prompts/sync-to-pi.sh
```

## Manual Single File

```bash
cp ~/code/prompts/commands/foo.md ~/.pi/agent/commands/
```

## After Changes

```bash
cd ~/code/prompts && git add -A && git commit -m "Add/update command" && git push
```
