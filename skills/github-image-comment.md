---
name: GitHub Image Comment
description: Post screenshots to GitHub issues via example-admin image hosting. Activate when user mentions screenshot to issue, post image to github, comment with screenshot, upload screenshot to issue, or wants to attach visual evidence to an issue or PR.
---

# GitHub Image Comment

Post screenshots to GitHub issues/PRs using the example-admin private image hosting system.

## When to Use

- Posting visual evidence (screenshots, UI changes) to GitHub issues
- Commenting on issues with images
- Attaching screenshots to PRs
- Any time you need to embed an image in a private GitHub repo

## Prerequisites

- Browser session authenticated to example-admin dashboard
- Screenshot file on disk

## Workflow

### Step 1: Take Screenshot (if needed)

```javascript
// Using Playwright MCP
mcp__playwright__browser_take_screenshot({
  filename: "descriptive-name.png"
})
```

Screenshot saves to: `/home/user/code/example-finance-dash/.playwright-mcp/`

### Step 2: Navigate to Image Upload Page

```javascript
mcp__playwright__browser_navigate({
  url: "https://example-admin.pages.dev/images"
})
```

Or use preview branch URL if testing: `https://BRANCH-NAME.example-admin.pages.dev/images`

### Step 3: Click Upload Zone

```javascript
// Get snapshot first to find the ref
mcp__playwright__browser_snapshot()

// Click the upload drop zone (usually has "Click to select or drag" text)
mcp__playwright__browser_click({
  element: "Upload drop zone",
  ref: "eXX"  // ref from snapshot
})
```

### Step 4: Upload File

```javascript
mcp__playwright__browser_file_upload({
  paths: ["/full/path/to/screenshot.png"]
})
```

### Step 5: Click Upload Button

```javascript
mcp__playwright__browser_click({
  element: "Upload Image button",
  ref: "eXX"  // ref from snapshot
})
```

### Step 6: Get Image URL

After upload, the page shows:
- Markdown format: `![filename](https://example-admin.pages.dev/api/images/XXXX)`
- Direct URL: `https://example-admin.pages.dev/api/images/XXXX`

**Important:** Use production URL (`example-admin.pages.dev`) in the markdown, not preview branch URL, so the image works after merge.

### Step 7: Post to GitHub Issue

```bash
# Write comment to temp file (NEVER use --body directly)
# Use Write tool to create /tmp/gh-comment.md

# Then post
gh issue comment ISSUE_NUMBER --body-file /tmp/gh-comment.md
rm /tmp/gh-comment.md
```

## Example Comment Template

```markdown
Fixed! [Brief description of what was done]

**Changes made:**
1. First change
2. Second change

**Result:**
- Key metric or outcome

![Description of screenshot](https://example-admin.pages.dev/api/images/XXXX)

Preview branch: https://BRANCH.example-admin.pages.dev
```

## Image Hosting Details

- **Bucket:** Private Supabase storage (`issue-images`)
- **Auth:** Dashboard login required to view
- **URL format:** `https://example-admin.pages.dev/api/images/{8-char-id}`
- **How it works:** API endpoint calls edge function to generate signed URL, then redirects
- **Max size:** 5MB
- **Formats:** PNG, JPG, GIF, WebP

## Troubleshooting

**"File chooser" modal not appearing:**
- Make sure to click the upload zone first, then use `browser_file_upload`

**Image not loading in GitHub:**
- Verify you're logged into the dashboard
- Check the image ID is correct
- Use production URL, not preview branch URL

**Upload fails:**
- Check file size < 5MB
- Verify file format is supported
- Ensure authenticated session is active
