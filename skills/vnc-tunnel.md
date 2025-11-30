---
name: VNC Tunnel
description: Set up VNC for headed browser automation on remote servers. Activate when user mentions vnc, remote desktop, headed browser, display forwarding, visual debugging, or needs to see browser on remote host.
allowed-tools: Bash, mcp__playwright__browser_navigate, mcp__playwright__browser_snapshot
---

# VNC Tunnel for Remote Headed Browsers

Use VNC to view and interact with headed browsers on remote servers. Essential for OAuth flows that require manual interaction or visual debugging.

## When to Use

- Google/OAuth login that can't be automated (anti-bot detection)
- Visual debugging of Playwright automation
- Any headed browser workflow on a remote/headless server

## Server Setup (one-time)

### Install VNC + Desktop Environment

```bash
# On the remote server (e.g., your-server)
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y tightvncserver xfce4 xfce4-goodies
```

### Configure VNC Startup

```bash
# Create/edit ~/.vnc/xstartup
cat > ~/.vnc/xstartup << 'EOF'
#!/bin/sh
xrdb "$HOME/.Xresources"
xsetroot -solid grey
export XKL_XMODMAP_DISABLE=1
startxfce4 &
EOF

chmod +x ~/.vnc/xstartup
```

### Start VNC Server

```bash
# First run will prompt for password
vncserver :1 -geometry 1280x800 -depth 24
```

### Stop VNC Server

```bash
# Kill specific display
vncserver -kill :1

# Kill all VNC servers for current user
vncserver -kill :*

# Or find and kill manually
ps aux | grep Xtightvnc
kill <pid>
```

### Restart VNC Server

```bash
vncserver -kill :1 && vncserver :1 -geometry 1280x800 -depth 24
```

## Client Connection

### SSH Tunnel (required - VNC is not encrypted)

```bash
# From your local machine
ssh -L 5901:localhost:5901 user@your-server

# Keep this terminal open while using VNC
```

### Connect VNC Client

- **macOS**: Screen Sharing app or RealVNC → `localhost:5901`
- **Linux**: Remmina, TigerVNC → `localhost:5901`
- **Windows**: RealVNC, TightVNC → `localhost:5901`

## Playwright MCP Configuration

For headed browser visible in VNC, the MCP config needs:

```json
{
  "playwright": {
    "command": "npx",
    "args": ["-y", "@playwright/mcp@latest", "--browser", "chrome"],
    "env": {
      "DISPLAY": ":1"
    }
  }
}
```

**Important**: If using a bash alias with inline `--mcp-config`, that overrides `~/.claude.json`. Edit the alias in `~/.bashrc` instead.

Example `cndsp` alias in `~/.bashrc`:
```bash
alias cndsp='claude --mcp-config "{\"mcpServers\":{\"playwright\":{\"command\":\"npx\",\"args\":[\"-y\",\"@playwright/mcp@latest\",\"--browser\",\"chrome\"],\"env\":{\"DISPLAY\":\":1\"}}}}"'
```

After editing, restart Claude Code for changes to take effect.

## Saving Session State

After manual OAuth login, save cookies for future headless use:

```javascript
// Via mcp__playwright__browser_run_code
await page.context().storageState({ path: '/home/user/session-auth.json' });
```

## Quick Reference

| Display | VNC Port | SSH Tunnel |
|---------|----------|------------|
| :1      | 5901     | `-L 5901:localhost:5901` |
| :2      | 5902     | `-L 5902:localhost:5902` |

## Troubleshooting

- **"Cannot open display"**: VNC server not running, start with `vncserver :1`
- **Connection refused on 5901**: SSH tunnel not active, re-run ssh command
- **Black screen in VNC**: xstartup not configured, check `~/.vnc/xstartup`
- **Browser still headless**: DISPLAY not passed to Playwright, check MCP config
- **Keyboard not working in browser**: Known Chrome issue, try clicking in browser first

## Managing XFCE4 Session

### Kill XFCE4 Desktop (inside VNC)

```bash
# Graceful logout
xfce4-session-logout --logout

# Force kill XFCE processes
pkill -f xfce
pkill -f xfdesktop
pkill -f xfwm4
pkill -f xfce4-panel
```

### Check What's Running on Display

```bash
# List processes using display :1
DISPLAY=:1 xdotool search --name "." 2>/dev/null

# Or check X clients
xlsclients -display :1
```

### Clean Shutdown Sequence

```bash
# 1. Close browser first (prevents orphan processes)
pkill -f chrome

# 2. Kill XFCE
pkill -f xfce

# 3. Kill VNC server
vncserver -kill :1

# 4. Verify nothing left
ps aux | grep -E "(vnc|xfce|chrome)" | grep -v grep
```

### Quick Start/Stop Commands

```bash
# Start everything
vncserver :1 -geometry 1280x800 -depth 24

# Stop everything
vncserver -kill :1  # This kills XFCE too since it's a child process
```

## Hosts with VNC Configured

- **your-server** (DigitalOcean): Display :1, XFCE4, used for Wix/Google OAuth
