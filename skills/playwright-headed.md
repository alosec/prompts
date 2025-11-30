---
name: Playwright Headed Browser
description: Configure Playwright MCP for headed (visible) browser mode. Activate when user mentions headed browser, visible browser, see the browser, watch automation, non-headless, or browser not showing.
allowed-tools: Bash, Read, Edit, mcp__playwright__browser_navigate, mcp__playwright__browser_snapshot, mcp__playwright__browser_click
---

# Playwright MCP Headed Browser Configuration

By default, Playwright MCP runs headless. To see the browser visually, you need specific configuration.

## Requirements

1. **Display available** - Either local display or VNC on remote server
2. **DISPLAY env var** - Must be passed to Playwright MCP process
3. **Browser flag** - `--browser chrome` (chromium may default headless)

## Configuration Methods

### Method 1: ~/.claude.json (if not using alias override)

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest", "--browser", "chrome"],
      "env": {
        "DISPLAY": ":1"
      }
    }
  }
}
```

### Method 2: Bash Alias with Inline Config (overrides ~/.claude.json)

If using an alias like `cndsp` that passes `--mcp-config`, you must edit the alias:

```bash
# In ~/.bashrc
alias cndsp='claude --mcp-config "{\"mcpServers\":{\"playwright\":{\"command\":\"npx\",\"args\":[\"-y\",\"@playwright/mcp@latest\",\"--browser\",\"chrome\"],\"env\":{\"DISPLAY\":\":1\"}}}}"'
```

### Method 3: Global DISPLAY Export (backup)

```bash
# In ~/.bashrc
export DISPLAY=:1
```

This helps but isn't sufficient alone - the MCP config `env` block is required.

## Key Points

- **`--browser chrome`** - Use Chrome, not Chromium (more reliable for headed mode)
- **`"env":{"DISPLAY":":1"}`** - Must be in MCP config, not just shell env
- **Restart required** - Claude Code must be restarted after config changes
- **Inline config wins** - `--mcp-config` flag overrides `~/.claude.json`

## Local Machine vs Remote Server

### Local (macOS/Linux with display)

```json
{
  "env": {
    "DISPLAY": ":0"
  }
}
```

Or omit DISPLAY entirely on macOS - it may auto-detect.

### Remote Server (via VNC)

```json
{
  "env": {
    "DISPLAY": ":1"
  }
}
```

Requires VNC server running on display :1. See `vnc-tunnel` skill.

## Verifying Headed Mode

After config change and restart:

1. Run `mcp__playwright__browser_navigate` to any URL
2. If headed: browser window appears on display
3. If still headless: check config, ensure restart happened

## Download Location

Playwright MCP downloads go to:
```
/home/user/code/.playwright-mcp/
```

## Common Issues

| Problem | Cause | Fix |
|---------|-------|-----|
| Browser not visible | DISPLAY not passed | Add `env` block to MCP config |
| Still headless after config | Using alias override | Edit alias in ~/.bashrc |
| "Cannot open display" | No X server/VNC | Start VNC: `vncserver :1` |
| Changes not taking effect | Didn't restart | Fully restart Claude Code |

## Session Persistence

Save auth state for future runs:

```javascript
// After manual login, via mcp__playwright__browser_run_code
await page.context().storageState({ path: '/path/to/auth.json' });
```

Load on next session by configuring Playwright with `storageState` option.
