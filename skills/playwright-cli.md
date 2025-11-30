---
name: playwright-cli
description: Use pw daemon CLI for token-efficient browser automation with persistent sessions. Activate when user mentions playwright, browser automation, web scraping, testing, screenshots, browser inspection, pw command, or persistent browser. Keywords include playwright, browser, web, screenshot, navigate, click, type, console, network, snapshot, headless, automation, e2e, pw, daemon.
---

# Playwright CLI Skill (pw daemon)

You have access to a persistent Playwright daemon CLI at `~/.local/bin/pw`. This keeps a browser session alive across multiple commands, enabling pipe-friendly workflows with Unix tools.

## Why This Tool Exists

Traditional Playwright MCP spawns a new browser per command (losing auth state, high overhead). The `pw` daemon:
- **Keeps browser alive** across commands (session persistence)
- **Enables piping** output through `grep`/`jq`/`head` before loading into context
- **Supports multiple instances** for concurrent browser sessions

## Quick Start

```bash
# Start daemon (headed by default)
pw start

# Run commands
pw browser-navigate --url "https://example.com"
pw browser-snapshot | head -20

# Stop when done
pw stop
```

## Multi-Instance Support

Run multiple independent browser sessions:

```bash
# Named instances
pw start --name slack
pw start --name gmail --headless

# Target specific instance
pw --name slack browser-navigate --url "https://slack.com"
pw --name gmail browser-navigate --url "https://gmail.com"

# Check all running instances
pw status --all

# Stop specific instance
pw stop --name slack
```

**Environment variable shortcut:**
```bash
export PW_INSTANCE=work
pw browser-snapshot  # uses "work" instance
```

**File locations per instance:**
- Socket: `/tmp/pw-daemon-{name}.sock`
- PID: `/tmp/pw-daemon-{name}.pid`
- Profile: `~/.playwright-session-{name}/`

## Daemon Commands

```bash
pw start [options]          # Start daemon
  --name <name>             # Instance name (default: "default")
  --headless                # Run headless
  --browser <type>          # chromium, firefox, webkit
  --user-data-dir <path>    # Custom browser profile
  --foreground              # Run in foreground (for debugging)

pw stop                     # Stop daemon
pw status                   # Check daemon status
pw status --all             # List all running instances
pw tools                    # List available MCP tools
```

## Browser Commands

### Navigation
```bash
pw browser-navigate --url <url>
pw browser-navigate-back
pw browser-tabs --action <list|new|close|select> [--index <n>]
```

### Inspection (Token-Efficient)
```bash
pw browser-snapshot                              # Accessibility tree (PREFERRED)
pw browser-console-messages [--only-errors true] # Console logs
pw browser-network-requests                      # Network activity
pw browser-take-screenshot [--filename <path>] [--full-page true]
```

### Interaction
```bash
pw browser-click --element <type> --ref <ref> [--double-click true]
pw browser-type --element <type> --ref <ref> --text <text> [--submit true]
pw browser-hover --element <type> --ref <ref>
pw browser-press-key --key <key>
```

### Forms
```bash
pw browser-fill-form --fields <field1=value1,field2=value2>
pw browser-select-option --element <type> --ref <ref> --values <value>
pw browser-file-upload --paths <path1,path2>
```

### Advanced
```bash
pw browser-evaluate --function <js-code>
pw browser-run-code --code <playwright-code>
pw browser-wait-for [--time <ms>] [--text <text>] [--text-gone <text>]
pw browser-resize --width <px> --height <px>
pw browser-close
```

## Output Formats

Use `-o <format>` flag:
- `-o json` - JSON (default, best for piping)
- `-o text` - Human-readable
- `-o raw` - Full JSON-RPC response

## Token-Efficient Patterns

### 1. Limit Lines
```bash
pw browser-console-messages | head -10
pw browser-network-requests | tail -5
```

### 2. Filter with grep
```bash
pw browser-snapshot | grep -i "submit"
pw browser-console-messages | grep ERROR
pw browser-network-requests | grep "404\|500"
```

### 3. Extract with jq
```bash
# Count network requests
pw browser-network-requests | jq 'length'

# Get just URLs
pw browser-network-requests | jq -r '.[].url' | head -10

# Filter by domain
pw browser-network-requests | jq -r '.[] | select(.url | contains("api")) | .url'
```

### 4. Count Instead of List
```bash
pw browser-console-messages | wc -l
pw browser-network-requests | grep ERROR | wc -l
```

## Common Workflows

### 1. Check Page Load
```bash
pw browser-navigate --url "https://example.com"
pw browser-console-messages | grep -i error | wc -l
```

### 2. Find and Click Element
```bash
# Find element reference
pw browser-snapshot | grep -i "login"
# Click it
pw browser-click --element "button" --ref "Login"
```

### 3. Fill Form and Submit
```bash
pw browser-type --element "input" --ref "email" --text "user@example.com"
pw browser-type --element "input" --ref "password" --text "secret"
pw browser-click --element "button" --ref "Sign in"
```

### 4. Monitor API Calls
```bash
pw browser-network-requests | jq -r '.[] | select(.url | contains("/api/")) | "\(.method) \(.status) \(.url)"' | head -10
```

### 5. Multiple Sessions (Parallel Work)
```bash
# Start instances for different services
pw start --name slack
pw start --name github --headless

# Work with each independently
pw --name slack browser-navigate --url "https://slack.com"
pw --name github browser-navigate --url "https://github.com"

# Check status
pw status --all
```

## Environment Setup

For headed mode, ensure DISPLAY is set:
```bash
export DISPLAY=:1  # or :0 for local
pw start
```

## Element References

Find refs with `browser-snapshot`:
```bash
pw browser-snapshot | grep -A 2 "login"
# Output: button "Login" [ref=e5]
```

Use: `--element "button" --ref "Login"` or `--ref "e5"`

## Session Persistence

Browser profile persists at `~/.playwright-session-{name}/`:
- Cookies survive daemon restarts
- localStorage persists
- Auth state maintained

For fresh profile:
```bash
pw start --user-data-dir /tmp/fresh-profile
```

## Error Handling

**"Daemon is not running"**
```bash
pw start
```

**"Display not found"**
```bash
export DISPLAY=:1
pw start
```

**Permission errors (multi-user)**
```bash
# Use named instance to avoid conflicts
pw start --name myinstance
```

**Element not found**
```bash
pw browser-snapshot | grep -i "<search-term>"
```

## Quick Reference

```bash
# Daemon control
pw start                    # Start default instance
pw start --name work        # Start named instance
pw stop                     # Stop default
pw stop --name work         # Stop named
pw status --all             # List all instances

# Browse
pw browser-navigate --url "https://example.com"
pw browser-snapshot | head -30
pw browser-click --element "button" --ref "Submit"
pw browser-type --element "input" --ref "email" --text "test@example.com"

# Inspect (with filtering)
pw browser-console-messages | grep ERROR
pw browser-network-requests | jq 'length'
pw browser-take-screenshot --filename shot.png
```

## Best Practices

### DO ✅
- Use `pw start --name <name>` for multiple concurrent sessions
- Filter output with `head`/`grep`/`jq` before loading into context
- Use `browser-snapshot` over screenshots when possible (text is efficient)
- Keep daemon running for related operations (session persistence)
- Use `pw status --all` to see running instances

### DON'T ❌
- Load full outputs without filtering (wastes tokens)
- Start new daemon for every command (defeats persistence)
- Forget `--name` when working with multiple instances
- Use screenshots when snapshot would work
