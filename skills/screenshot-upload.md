---
name: Screenshot Upload
description: Upload screenshots to the Cloudflare Pages screenshots project for shareable URLs. Activate when user says #screenshot, #upload-screenshot, or needs to share a screenshot in issues/docs.
allowed-tools: Read, Bash
---

# Screenshot Upload Workflow

Upload screenshots to `screenshots-5wx.pages.dev` for easy sharing in issues, PRs, and documentation.

## When to Use

Activate when user:
- Says `#screenshot` or `#upload-screenshot`
- Needs a shareable URL for a screenshot
- Wants to document visual changes or bugs
- Is adding screenshots to issues or PRs

## Project Location

- **Local:** `~/code/screenshots/`
- **URL:** `https://screenshots-5wx.pages.dev/<filename>`

## Quick Upload

### 1. Take Screenshot (if needed)

```bash
# Ensure Chrome is running in tmux first
browser-screenshot.js
# Saves to /tmp/screenshot-TIMESTAMP.png
```

### 2. Copy to Screenshots Project

```bash
# Copy with descriptive name
cp /tmp/screenshot-*.png ~/code/screenshots/my-descriptive-name.png

# Or rename during copy for clarity
cp /tmp/screenshot-1733468400000.png ~/code/screenshots/feature-xyz-before.png
```

### 3. Deploy to Cloudflare Pages

```bash
cd ~/code/screenshots && wrangler pages deploy . --project-name screenshots
```

### 4. Get URL

The screenshot is now available at:
```
https://screenshots-5wx.pages.dev/my-descriptive-name.png
```

## Naming Conventions

Use descriptive, kebab-case names:
- `feature-name-before.png` / `feature-name-after.png`
- `issue-ABG-42-repro.png`
- `mew-login-error-2025-12-06.png`
- `pr-123-visual-diff.png`

## Full Example

```bash
# 1. Navigate to the page
browser-nav.js "https://myapp.com/feature"

# 2. Take screenshot
browser-screenshot.js

# 3. Copy with good name
cp /tmp/screenshot-*.png ~/code/screenshots/feature-new-button.png

# 4. Deploy
cd ~/code/screenshots && wrangler pages deploy . --project-name screenshots

# 5. Use the URL
# https://screenshots-5wx.pages.dev/feature-new-button.png
```

## Using in Issues

### Linear Comment
```bash
linearis comments create ABG-42 --body "Screenshot: https://screenshots-5wx.pages.dev/issue-ABG-42-fix.png"
```

### GitHub Issue/PR
```bash
gh issue comment 123 --body "![Screenshot](https://screenshots-5wx.pages.dev/pr-123-result.png)"
```

## Batch Upload

For multiple screenshots:
```bash
# Copy all recent screenshots
cp /tmp/screenshot-*.png ~/code/screenshots/

# Rename them appropriately
cd ~/code/screenshots
mv screenshot-1733468400000.png step-1-login.png
mv screenshot-1733468401000.png step-2-dashboard.png

# Single deploy
wrangler pages deploy . --project-name screenshots
```

## Cleanup

Periodically clean old screenshots:
```bash
cd ~/code/screenshots
ls -la  # Review what's there
rm old-unused-screenshot.png
wrangler pages deploy . --project-name screenshots
```

## Gotchas

1. **Viewport reset:** `page.screenshot()` from puppeteer can change viewport to 800x600. Reset viewport after if needed.

2. **File exists:** If filename already exists, it will be overwritten on deploy. Use unique names or add dates.

3. **Deploy required:** Screenshots aren't live until you run `wrangler pages deploy`.

## Quick Reference

| Action | Command |
|--------|---------|
| Take screenshot | `browser-screenshot.js` |
| Copy to project | `cp /tmp/screenshot-*.png ~/code/screenshots/name.png` |
| Deploy | `cd ~/code/screenshots && wrangler pages deploy . --project-name screenshots` |
| URL format | `https://screenshots-5wx.pages.dev/<filename>` |
