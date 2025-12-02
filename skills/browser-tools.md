---
name: Browser Tools
description: Chrome DevTools Protocol tools for web automation. Activate when user mentions browser automation, scraping, screenshots, web navigation, cookies, or needs to interact with web pages programmatically.
allowed-tools: Bash
---

# Browser Tools

Chrome DevTools Protocol tools for agent-assisted web automation. Connect to Chrome on `:9222` with remote debugging.

## Quick Reference

| Command | Purpose |
|---------|---------|
| `browser-start.js` | Launch Chrome with remote debugging |
| `browser-start.js --profile` | Launch with user's cookies/logins |
| `browser-nav.js <url>` | Navigate to URL |
| `browser-eval.js 'code'` | Execute JavaScript |
| `browser-screenshot.js` | Capture viewport |
| `browser-content.js <url>` | Extract page as markdown |
| `browser-cookies.js` | Show cookies |
| `browser-search.js "query"` | Google search |
| `browser-pick.js "instruction"` | Interactive element picker |

## Starting the Browser

```bash
# Fresh profile (no cookies)
export DISPLAY=:1 && browser-start.js

# With user's Chrome profile (cookies, logins preserved)
export DISPLAY=:1 && browser-start.js --profile
```

**DISPLAY required** - Set to VNC display (`:1`) or local display (`:0`).

## OAuth Login Pattern

For services requiring Google/GitHub OAuth:

1. **Start with profile**: `DISPLAY=:1 browser-start.js --profile`
2. **Navigate to login**: `browser-nav.js https://app.example.com/login`
3. **Complete OAuth via VNC**: User manually logs in (anti-bot detection blocks automation)
4. **Profile persists**: Cookies saved to `~/.cache/scraping/`
5. **Future runs**: Same `--profile` flag reuses authenticated session

### Profile Locations

| Path | Purpose |
|------|---------|
| `~/.config/google-chrome/` | User's real Chrome profile (source) |
| `~/.cache/scraping/` | Working profile used by browser-tools |

The `--profile` flag rsyncs from the real profile to the working directory.

## Multi-User Setup

Browser-tools installed at `/usr/local/share/browser-tools/` (shared).

For user access, create symlinks in `~/bin/`:
```bash
ln -sf /usr/local/share/browser-tools/browser-start.js ~/bin/
# ... repeat for other scripts
```

Ensure `~/bin` is in PATH (default in Debian's `.profile`).

## React Form Input

For controlled React inputs, use the native setter:

```bash
browser-eval.js '(() => {
  const e = document.querySelector("#email");
  const setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, "value").set;
  setter.call(e, "user@example.com");
  e.dispatchEvent(new Event("input", { bubbles: true }));
  return e.value;
})()'
```

## Screenshots

```bash
browser-screenshot.js
# Returns: /tmp/screenshot-XXXXX.png
```

View locally or upload to hosting for sharing.

## Common Workflows

### Scrape Authenticated Content

```bash
DISPLAY=:1 browser-start.js --profile
browser-nav.js https://dashboard.example.com
browser-content.js https://dashboard.example.com
```

### Visual Verification

```bash
browser-nav.js https://myapp.com
browser-screenshot.js
# Inspect /tmp/screenshot-*.png
```

### Search and Extract

```bash
browser-search.js "topic" --content -n 3
# Returns search results with page content
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Cannot open display" | Set `DISPLAY=:1` (VNC) or start VNC server |
| Chrome won't start | Kill existing: `pkill -f 'chrome.*remote-debugging'` |
| Cookies not persisting | Use `--profile` flag |
| Permission denied | Check `/usr/local/share/browser-tools/` permissions |

## See Also

- `vnc-tunnel` skill - VNC setup for remote headed browsers
- `oauth-bypass` skill - Full OAuth automation pattern
- `playwright-headed` skill - Alternative: Playwright MCP headed mode
