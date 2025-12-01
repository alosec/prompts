---
name: Issue Resolution
description: End-to-end workflow for resolving tickets with feature branches, screenshot verification, and cross-system tracking. Activate when user says #resolve, #fix-issue, or asks to work on a Linear/GitHub issue.
allowed-tools: Read, Bash, Write, Edit
---

# Issue Resolution Workflow

Complete pattern for resolving issues with evidence, cross-linking, and clean git history.

## When to Use

Activate when user:
- Says `#resolve` or `#fix-issue` followed by an issue ID
- Asks to "work on" or "fix" a Linear or GitHub issue
- Wants to close out a ticket with proper documentation

## Workflow Steps

### 1. Load the Issue

```bash
# Linear issue
linearis issues read ABG-XX

# GitHub issue (if exists)
gh issue view <number>
```

Understand what needs to be done before touching code.

### 2. Cross-Link Systems (if needed)

If issue exists in only one system, consider creating in the other:
- Linear for tracking/planning
- GitHub for code-level discussion and PR linking

Add cross-references in comments:
```bash
# Link GitHub issue in Linear comment
linearis comments create ABG-XX --body "GitHub: owner/repo#123"

# Link Linear in GitHub comment
gh issue comment 123 --body "Linear: ABG-XX"
```

### 3. Create Plan

Read the planning skill and create an implementation plan:
```bash
cat ~/code/prompts/skills/planning.md
```

Post plan as a comment for documentation:
```bash
# Write plan to temp file
cat > /tmp/plan.md << 'EOF'
## Implementation Plan
[plan content]
EOF

# Post to GitHub
gh issue comment <number> --body-file /tmp/plan.md
```

### 4. Feature Branch

```bash
# Use descriptive branch name
git checkout -b fix/short-description
# or
git checkout -b feat/short-description
```

### 5. Implement Fix

Make changes, following existing patterns in the codebase.

### 6. Build & Deploy

```bash
# Build
npm run build

# Deploy (adjust for project)
wrangler pages deploy dist/
# or
npm run deploy
```

### 7. Screenshot Verification

Capture visual evidence that the fix works:

```bash
# Start browser with cookies/auth
export DISPLAY=:9 && browser-start.js --profile

# Navigate to the affected area
browser-nav.js "https://app.example.com/affected-page"

# Login if needed (React form pattern)
browser-eval.js '(() => { 
  const setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, "value").set;
  const email = document.querySelector("#email");
  setter.call(email, "user@example.com");
  email.dispatchEvent(new Event("input", { bubbles: true }));
  // ... password, submit
})()'

# Capture screenshot
browser-screenshot.js
# Saves to /tmp/screenshot-TIMESTAMP.png

# Upload to image hosting (if available)
# Use any image host: imgur, project-specific endpoint, or paste directly
# Example: node upload-image.js /tmp/screenshot-*.png
# Returns a public URL for the image
```

### 8. Document with Screenshot

Post the evidence to GitHub:

```bash
cat > /tmp/resolved.md << 'EOF'
## Fix Verified

[Description of what was fixed]

### Screenshot
![fix verified](IMAGE_URL_HERE)

### Changes
- file1.ts: description
- file2.ts: description
EOF

gh issue comment <number> --body-file /tmp/resolved.md
```

### 9. PR & Merge

```bash
# Create PR
gh pr create --title "Fix: short description" --body "Fixes #<issue-number>"

# After review (or immediately for solo projects)
gh pr merge --squash

# Clean up
git checkout main
git pull
git branch -d fix/short-description
```

### 10. Close Issues

```bash
# Close GitHub issue (if not auto-closed by PR)
gh issue close <number>

# Update Linear
linearis issues update ABG-XX --state Done
```

## Quick Reference

| Step | Command |
|------|---------|
| Read Linear | `linearis issues read ABG-XX` |
| Read GitHub | `gh issue view <num>` |
| Branch | `git checkout -b fix/name` |
| Screenshot | `browser-screenshot.js` |
| Upload image | Upload to any image host (imgur, project endpoint, etc.) |
| PR | `gh pr create` |
| Merge | `gh pr merge --squash` |
| Close Linear | `linearis issues update ABG-XX --state Done` |

## Notes

- **Always verify visually** when the fix has UI impact
- **Document as you go** - future you will thank present you
- **Cross-link systems** - makes auditing and searching easier
- **Squash merge** - keeps main branch history clean
