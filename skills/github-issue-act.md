---
name: GitHub Issue Act
description: Execute implementation for a planned GitHub issue. Feature branch, implement, deploy, verify with screenshots, PR, merge. Activate when user approves a plan and says to implement, or references an issue to execute.
allowed-tools: Read, Bash, Write, Edit
---

# GitHub Issue Act

Execute an approved implementation plan. Creates feature branch, implements changes, deploys, verifies with screenshots, and handles PR workflow.

## When to Use

- User approves a plan and says "go ahead" or "implement"
- User says "act on #XX" or "execute the plan"
- Following a `github-issue-plan` workflow after approval

## Prerequisites

- Issue exists with clear requirements
- Plan is understood and approved
- Correct GitHub account active (`gh auth status`)

## Step 1: Feature Branch

```bash
git checkout -b feature/descriptive-name
# or fix/, feat/, etc.
```

## Step 2: Implement

Make the planned changes. Use `edit` tool for surgical modifications.

## Step 3: Commit

```bash
git add -A
git commit -m "feat: short description

- Detail 1
- Detail 2

Closes #<issue-number>"
```

## Step 4: Build & Deploy Preview

```bash
npm run build 2>&1 | tail -5
wrangler pages deploy dist/ 2>&1 | tail -3
# Note preview URL: https://BRANCH-NAME.project.pages.dev
```

## Step 5: Verify with Screenshot

```bash
# Use PREVIEW URL, not production
browser-nav.js "https://feature-branch.project.pages.dev/page"

# Login if needed on preview deployment
# ... login steps ...

sleep 2 && browser-screenshot.js
```

## Step 6: Upload & Comment

```bash
browser-nav.js "https://app.pages.dev/images"
cd ~/code/agent-tools/browser-tools && node upload.js /tmp/screenshot-TIMESTAMP.png

cat > /tmp/gh-comment.md << 'EOF'
## ✅ Implementation Complete

**Preview URL:** https://feature-branch.project.pages.dev/page

### Screenshot

![Updated](IMAGE_URL)

### Changes
- Change 1
- Change 2

Branch: `feature/descriptive-name`
EOF

gh issue comment <num> --repo owner/repo --body-file /tmp/gh-comment.md
rm /tmp/gh-comment.md
```

## Step 7: Push & PR

```bash
git push -u origin feature/descriptive-name

cat > /tmp/gh-pr-body.md << 'EOF'
## Summary

[Brief description]

## Screenshots

| Before | After |
|--------|-------|
| ![Before](URL) | ![After](URL) |

## Preview

https://feature-branch.project.pages.dev/page

Closes #<issue-number>
EOF

gh pr create --title "feat: Description" --body-file /tmp/gh-pr-body.md --base main
rm /tmp/gh-pr-body.md
```

## Step 8: Wait for Approval

Share PR URL and **wait for user to approve/merge**.

## Step 9: Merge & Deploy (after approval)

```bash
gh pr merge <num> --squash --delete-branch

git checkout main
git pull

# Deploy to production
npm run build 2>&1 | tail -3
wrangler pages deploy dist/ 2>&1 | tail -3
```

## Quick Reference

| Action | Command |
|--------|---------|
| Screenshot | `browser-screenshot.js` |
| Upload | `node upload.js /tmp/file.png` |
| Comment | `gh issue comment <num> --body-file file.md` |
| PR | `gh pr create --body-file file.md` |
| Merge | `gh pr merge <num> --squash --delete-branch` |

## Safety Rules

- **Preview URL for verification** - changes aren't on prod until merged
- **Wait for PR approval** - don't merge without user confirmation
- **Always `--body-file`** - never raw `--body`
- **Squash merge** - keeps history clean
