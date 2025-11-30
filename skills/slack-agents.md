---
name: Slack Agents
description: Manage pi-mono Slack agents (mom bots). Activate when user mentions slack agent, sir cladius, cladius, mom bot, zip agent, revive agent, start agent, stop agent, agent status, pi-mono agents, or needs to manage running Slack bot instances.
---

# Slack Agents Management

Multi-agent Slack bot architecture based on pi-mono (Mario Zechner's mom package).

## Architecture Overview

```
pi-mono/                          # Primary fork (Sir Cladius + future agents)
└── packages/mom/
    ├── run.sh                    # Start script
    ├── .env                      # Slack tokens + Anthropic key
    ├── data/                     # Workspace (mounted to container)
    └── logs/                     # Daily log files

pi-mono-zip/                      # Secondary fork (Zip agent)
└── packages/mom/
    ├── run.sh
    ├── .env
    ├── data/
    └── logs/
```

## Current Agents

| Agent | Container | Repo | Workspace |
|-------|-----------|------|-----------|
| Sir Cladius | `cladius-sandbox` | `pi-mono` | Personal Slack |
| Zip | `zip-sandbox` | `pi-mono-zip` | Zip Slack |
| Mom | `mom-sandbox` | (original) | Mario's Slack |

## Common Operations

### Check Agent Status
```bash
# List all agent containers
docker ps --format 'table {{.Names}}\t{{.Status}}' | grep -E 'sandbox|mom'

# Check if bot process is running
pgrep -af "mom/dist/main.js"
```

### Start an Agent
```bash
# Sir Cladius
cd ~/code/pi-mono/packages/mom && ./run.sh

# Zip
cd ~/code/pi-mono-zip/packages/mom && ./run.sh
```

### Stop an Agent
```bash
# Find and kill the node process
pkill -f "pi-mono/packages/mom/dist/main.js"      # Cladius
pkill -f "pi-mono-zip/packages/mom/dist/main.js"  # Zip
```

### View Logs
```bash
# Today's log
tail -f ~/code/pi-mono/packages/mom/logs/mom-$(date +%Y-%m-%d).log

# Recent activity
tail -100 ~/code/pi-mono-zip/packages/mom/logs/mom-$(date +%Y-%m-%d).log
```

### Restart Container (if needed)
```bash
docker restart cladius-sandbox
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

1. **Clone/fork pi-mono:**
   ```bash
   cd ~/code
   cp -r pi-mono pi-mono-newagent
   ```

2. **Configure container name in run.sh:**
   ```bash
   CONTAINER_NAME="newagent-sandbox"
   ```

3. **Create Slack app:**
   - https://api.slack.com/apps
   - Enable Socket Mode
   - Add bot scopes (see packages/mom/docs/slack-bot-minimal-guide.md)
   - Generate tokens

4. **Configure .env:**
   ```bash
   cd ~/code/pi-mono-newagent/packages/mom
   cp .env.example .env
   # Edit with tokens
   ```

5. **Build and run:**
   ```bash
   cd ~/code/pi-mono-newagent
   npm install
   npm run build
   cd packages/mom
   ./run.sh
   ```

## Troubleshooting

### Agent not responding
1. Check container: `docker ps | grep sandbox`
2. Check node process: `pgrep -af mom/dist`
3. Check logs for errors
4. Restart: kill process, run `./run.sh`

### "Container not found"
```bash
# Recreate container (data preserved in ./data/)
docker rm newagent-sandbox 2>/dev/null
./run.sh  # Will recreate
```

### Token errors
- Verify tokens in .env
- Check Slack app is installed to workspace
- Ensure Socket Mode is enabled

## Future Direction

This architecture enables:
- Multiple isolated agents per workspace
- Shared codebase with per-agent config
- Independent sandboxed execution environments
- Centralized management from your-server
