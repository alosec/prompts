---
name: GitHub Issue Plan
description: Create a GitHub issue with screenshots and implementation plan. Stops before implementation for review/Q&A. Activate when user wants to document a change request, create an issue with visual context, or plan work on GitHub.
allowed-tools: Read, Bash, Write, Edit
---

# GitHub Issue Plan

Create well-documented GitHub issues with screenshots and implementation plans. **Stops before implementation** to allow for review and refinement.

## When to Use

- User wants to create a GitHub issue with screenshots
- User wants to plan a change before implementing
- User says "create an issue for X" or "plan X on GitHub"

## Pre-Flight

```bash
# Verify correct GitHub account
gh auth status
gh auth switch --user <username>  # if needed

# Verify repo target
git remote -v
```

## Step 1: Capture Screenshots

```bash
# Start browser with auth
export DISPLAY=:9 && browser-start.js --profile

# Navigate and capture
browser-nav.js "https://app.pages.dev/page"
sleep 2 && browser-screenshot.js
# Output: /tmp/screenshot-TIMESTAMP.png
```

**Login pattern for React apps:**
```bash
browser-eval.js '(() => {
  const setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, "value").set;
  const el = document.querySelector("input[type=\"email\"]");
  setter.call(el, "email"); el.dispatchEvent(new Event("input", { bubbles: true }));
})()'
# Repeat for password, then click submit
```

## Step 2: Upload Screenshot

```bash
browser-nav.js "https://app.pages.dev/images"
cd ~/code/agent-tools/browser-tools && node upload.js /tmp/screenshot-TIMESTAMP.png
# Output: https://app.pages.dev/api/images/XXXXX
```

## Step 3: Analyze Codebase

```bash
# Find relevant files
grep -r "term" src/ --include="*.tsx" -l

# Read key files to understand current implementation
```

## Step 4: Create Issue with Plan

**Always use `--body-file`, never `--body`**

```bash
cat > /tmp/gh-issue-body.md << 'EOF'
## Summary

[What needs to change and why]

## Current State

![Current](IMAGE_URL)

## Proposed Changes

[Description of what will change]

---

## Implementation Plan

[Understanding of what needs to be built - 2-3 sentences]

### File Changes

```
src/
├── [M] path/to/file.ts - Change description
└── [M] path/to/other.tsx - Change description
```

### Execution Steps

1. Step one
2. Step two
3. Build & deploy
4. Verify with screenshot

### Legend
- [C] Create, [M] Modify, [D] Delete
EOF

gh issue create --repo owner/repo --title "feat: Title" --body-file /tmp/gh-issue-body.md
rm /tmp/gh-issue-body.md
```

## Output

After creating the issue:
1. Share the issue URL
2. Summarize the plan
3. **Stop and wait** for user approval/feedback before implementing

## Safety Rules

- **Always `--body-file`** - never `--body` (shell injection risk)
- **Always `--repo owner/repo`** - prevents wrong-repo mistakes
- **Verify `gh auth status`** - correct account matters
- **Stop after planning** - don't implement until requirements are clear
