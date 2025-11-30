---
name: OAuth Bypass
description: Bypass OAuth/SSO login flows using VNC + headed Playwright. Activate when user mentions oauth, google login, SSO, sign in with google, authentication wall, login automation, captcha, anti-bot, or needs to authenticate on a third-party service.
allowed-tools: Bash, mcp__playwright__browser_navigate, mcp__playwright__browser_snapshot, mcp__playwright__browser_click, mcp__playwright__browser_type, mcp__playwright__browser_run_code, mcp__playwright__browser_wait_for
---

# OAuth Bypass with VNC + Headed Playwright

OAuth providers (Google, Microsoft, GitHub, etc.) have anti-bot detection that blocks headless browser automation. The solution: run a **headed browser** on a remote server via **VNC**, let the user complete login manually, then **capture the session state** for future automation.

## When to Use

- Google OAuth / "Sign in with Google"
- Microsoft/Azure AD SSO
- GitHub OAuth
- Any login with CAPTCHA or anti-bot detection
- Services that detect and block Playwright/Puppeteer

## Prerequisites

1. **VNC server** running on remote host (see `vnc-tunnel` skill)
2. **Playwright MCP** configured for headed mode (see `playwright-headed` skill)
3. **SSH tunnel** active for VNC access

## Quick Setup Checklist

```bash
# On remote server (e.g., your-server)
vncserver :1 -geometry 1280x800 -depth 24

# From local machine
ssh -L 5901:localhost:5901 user@your-server

# Connect VNC client to localhost:5901
```

Ensure Playwright MCP has:
```json
{
  "env": {"DISPLAY": ":1"},
  "args": ["--browser", "chrome"]
}
```

## Workflow

### Step 1: Navigate to Login Page

```
mcp__playwright__browser_navigate to the service's login URL
```

### Step 2: Initiate OAuth Flow

Click "Sign in with Google" or equivalent button. This typically opens a popup or redirects.

### Step 3: User Completes Login in VNC

**Critical:** User must manually complete the OAuth flow in the VNC window:
- Enter credentials
- Complete 2FA if prompted
- Handle any CAPTCHA challenges
- Approve permissions

Claude cannot automate this step - anti-bot detection will block it.

### Step 4: Verify Login Success

```
mcp__playwright__browser_snapshot
```

Check that user is now authenticated (look for user email, dashboard content, etc.)

### Step 5: Save Session State

```javascript
// Via mcp__playwright__browser_run_code
await page.context().storageState({ path: '/home/user/SERVICE-auth.json' });
```

This saves cookies and localStorage for future use.

## Session Files

Store session state files in home directory with clear naming:

| Service | File |
|---------|------|
| Google | `/home/user/google-auth.json` |
| Wix (via Google) | `/home/user/wix-auth.json` |
| GitHub | `/home/user/github-auth.json` |
| Custom | `/home/user/{service}-auth.json` |

## Using Saved Sessions

For future automation runs, configure Playwright to load the session:

```javascript
// When launching browser
const context = await browser.newContext({
  storageState: '/home/user/SERVICE-auth.json'
});
```

**Note:** Sessions expire. If automation fails with auth errors, repeat the manual login flow.

## Common OAuth Providers

### Google
- Login URL: `https://accounts.google.com`
- Look for: "Continue with Google" buttons
- Session includes: Google cookies + any service using Google OAuth

### Microsoft/Azure AD
- Login URL: `https://login.microsoftonline.com`
- Often used for: Office 365, corporate SSO

### GitHub
- Login URL: `https://github.com/login`
- OAuth URL: `https://github.com/login/oauth/authorize`

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Popup opens in new window | Can't track - user must complete in VNC |
| "Unusual activity detected" | Use VNC, don't automate typing |
| Session expired | Re-authenticate manually, save new session |
| Browser shows in VNC but Playwright can't control | Restart Claude Code, verify DISPLAY env |

## Security Notes

- Session files contain authentication tokens - keep them secure
- Don't commit session files to git
- Sessions may include access to email, documents, etc.
- Rotate/regenerate sessions if machine is compromised

## Example: Google → Wix Flow

```
1. Navigate to Wix login page
2. Click "Continue with Google"
3. User completes Google login in VNC (popup)
4. User approves Wix access
5. Verify Wix dashboard loads
6. Save combined session: /home/user/wix-auth.json
7. Future runs: Load session, navigate directly to Wix dashboard
```
