---
name: Slack Agents
description: Manage pi-mono Slack agents (mom bots). Activate when user mentions slack agent, pilot, pilot sandbox, zip agent, revive agent, start agent, stop agent, agent status, pi-mono agents, or needs to manage running Slack bot instances.
---

# Slack Agents Management

Multi-agent Slack bot architecture based on pi-mono (Mario Zechner's mom package).

## Architecture Overview

```
pi-mono/                          # Primary fork (Pilot agent)
└── packages/mom/
    ├── run.sh                    # Direct start script
    ├── start-pilot.sh            # Tmux launcher
    ├── .env                      # Slack tokens + Anthropic key
    ├── data/                     # Workspace (mounted to container)
    └── logs/                     # Daily log files

pi-mono-zip/                      # Worktree of pi-mono (Zip agent)
└── packages/mom/
    ├── run.sh
    ├── start-zip.sh              # Tmux launcher
    ├── .env
    ├── data/
    └── logs/
```

**Note:** pi-mono-zip is a git worktree of pi-mono, not a separate clone.

## Current Agents

| Agent | Container | Repo | Workspace | Tmux Session |
|-------|-----------|------|-----------|--------------|
| Pilot | `pilot-sandbox` | `pi-mono` | Fatcatsdev Slack | `pilot` |
| Zip | `zip-sandbox` | `pi-mono-zip` | Personal Slack | `zip` |
| Mom | `mom-sandbox` | (Mario's) | Mario's Slack | - |

## Common Operations

### Check Agent Status
```bash
# List all agent containers
docker ps --format 'table {{.Names}}\t{{.Status}}' | grep -E 'sandbox|mom'

# List tmux sessions
tmux list-sessions | grep -E 'pilot|zip'

# Check if bot process is running
pgrep -af "mom/dist/main.js"
```

### Start an Agent (preferred: tmux)
```bash
# Pilot (in tmux session)
cd ~/code/pi-mono/packages/mom && ./start-pilot.sh

# Zip (in tmux session)
cd ~/code/pi-mono-zip/packages/mom && ./start-zip.sh

# Attach to running session
tmux attach -t pilot
tmux attach -t zip
```

### Start an Agent (direct, no tmux)
```bash
cd ~/code/pi-mono/packages/mom && ./run.sh
cd ~/code/pi-mono-zip/packages/mom && ./run.sh
```

### Stop an Agent
```bash
# Kill tmux session (also kills the process)
tmux kill-session -t pilot
tmux kill-session -t zip

# Or kill the node process directly
pkill -f "pi-mono/packages/mom/dist/main.js"      # Pilot
pkill -f "pi-mono-zip/packages/mom/dist/main.js"  # Zip
```

### View Logs
```bash
# Today's log
tail -f ~/code/pi-mono/packages/mom/logs/mom-$(date +%Y-%m-%d).log

# Recent activity
tail -100 ~/code/pi-mono-zip/packages/mom/logs/mom-$(date +%Y-%m-%d).log

# Or attach to tmux session to see live output
tmux attach -t pilot
```

### Restart Container (if needed)
```bash
docker restart pilot-sandbox
docker restart zip-sandbox
```

## Environment Setup

Each agent needs `.env` with:
```
MOM_SLACK_APP_TOKEN=xapp-...    # Socket mode token
MOM_SLACK_BOT_TOKEN=xoxb-...    # Bot OAuth token
ANTHROPIC_API_KEY=sk-ant-...    # Or ANTHROPIC_OAUTH_TOKEN
```

## Adding a New Agent

1. **Create worktree (preferred) or clone:**
   ```bash
   cd ~/code/pi-mono
   git worktree add ../pi-mono-newagent -b newagent-deploy
   ```

2. **Configure container name in run.sh:**
   ```bash
   CONTAINER_NAME="newagent-sandbox"
   ```

3. **Create tmux launcher (copy from existing):**
   ```bash
   cp start-pilot.sh ../pi-mono-newagent/packages/mom/start-newagent.sh
   # Edit SESSION="newagent"
   ```

4. **Create Slack app:**
   - https://api.slack.com/apps
   - Enable Socket Mode
   - Add bot scopes (see packages/mom/docs/slack-bot-minimal-guide.md)
   - Generate tokens

5. **Configure .env:**
   ```bash
   cd ~/code/pi-mono-newagent/packages/mom
   cp .env.example .env
   # Edit with tokens
   ```

6. **Build and run:**
   ```bash
   cd ~/code/pi-mono-newagent
   npm install
   npm run build
   cd packages/mom
   ./start-newagent.sh
   ```

## Troubleshooting

### Agent not responding
1. Check container: `docker ps | grep sandbox`
2. Check tmux: `tmux list-sessions`
3. Check logs for errors
4. Restart: `tmux kill-session -t pilot && ./start-pilot.sh`

### "Container not found"
```bash
# Recreate container (data preserved in ./data/)
docker rm pilot-sandbox 2>/dev/null
./run.sh  # Will recreate
```

### Token errors
- Verify tokens in .env
- Check Slack app is installed to workspace
- Ensure Socket Mode is enabled

## Future Direction

This architecture enables:
- Multiple isolated agents per workspace
- Shared codebase with per-agent config (worktrees)
- Independent sandboxed execution environments
- Named tmux sessions for easy management
- Centralized management from TinyBat VPS
