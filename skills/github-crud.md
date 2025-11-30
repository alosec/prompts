---
name: GitHub Issues & PRs
description: CRUD operations for GitHub issues and pull requests. Activate when user mentions github issues, gh issue, create issue, close issue, comment on issue, PR, pull request, gh pr, issue image, screenshot to issue, or any GitHub issue/PR management task.
allowed-tools: Bash, Read, Write, Edit, Grep, Glob
---

# GitHub Issues & PRs CRUD Skill

Complete workflow for managing GitHub issues and pull requests via `gh` CLI.

## Safety Rules

**MANDATORY: NEVER use `--body` parameter. ALWAYS use `--body-file`.**

This is not optional. The `--body` flag is dangerous because:
- Backticks execute as shell commands: `--body "Fix \`rm -rf /\`"` runs the command
- `$()` executes: `--body "$(cat /etc/passwd)"` leaks sensitive data
- Even innocent markdown like `code` or `$(var)` can cause issues

**Required workflow:**
1. Use Write tool to create `/tmp/gh-body.md` with content
2. Use `--body-file /tmp/gh-body.md`
3. Clean up: `rm /tmp/gh-body.md`

**NO EXCEPTIONS.** Even for "simple" bodies without code, use `--body-file`.

## Quick Reference

| Operation | Command |
|-----------|---------|
| List issues | `gh issue list` |
| View issue | `gh issue view NUMBER` |
| Create issue | `gh issue create --title "..." --body-file FILE` |
| Edit issue | `gh issue edit NUMBER --title/--body-file` |
| Comment | `gh issue comment NUMBER --body-file FILE` |
| Close | `gh issue close NUMBER` |
| Reopen | `gh issue reopen NUMBER` |
| List PRs | `gh pr list` |
| View PR | `gh pr view NUMBER` |
| Create PR | `gh pr create --title "..." --body-file FILE` |
| Merge PR | `gh pr merge NUMBER` |

---

## Issue Operations

### List Issues

```bash
# All open issues
gh issue list --state open --limit 100 --json number,title,labels,body

# Filter by label
gh issue list --label "bug"

# Filter by assignee
gh issue list --assignee "@me"
```

### View Issue

```bash
# View issue with comments
gh issue view NUMBER

# JSON output for parsing
gh issue view NUMBER --json title,body,comments,labels,state
```

### Create Issue

**Safe pattern:**
1. Write body content to temp file using Write tool
2. Create issue with `--body-file`
3. Clean up temp file

```bash
# Step 1: Use Write tool to create /tmp/gh-issue-body.md
# Step 2: Create issue
gh issue create --title "Issue title" --body-file /tmp/gh-issue-body.md
# Step 3: Clean up
rm /tmp/gh-issue-body.md
```

### Edit Issue

```bash
# Edit title only
gh issue edit NUMBER --title "New title"

# Edit body (use temp file)
gh issue edit NUMBER --body-file /tmp/gh-issue-body.md

# Add/remove labels
gh issue edit NUMBER --add-label "bug,priority"
gh issue edit NUMBER --remove-label "wontfix"

# Assign
gh issue edit NUMBER --add-assignee "@me"
```

### Comment on Issue

**Safe pattern:**
```bash
# Step 1: Use Write tool to create /tmp/gh-comment.md
# Step 2: Add comment
gh issue comment NUMBER --body-file /tmp/gh-comment.md
# Step 3: Clean up
rm /tmp/gh-comment.md
```

### Close Issue

```bash
# Simple close
gh issue close NUMBER

# Close with comment (use temp file for comment)
gh issue comment NUMBER --body-file /tmp/resolution.md
gh issue close NUMBER
```

---

## PR Operations

### List PRs

```bash
# Open PRs
gh pr list

# All PRs including merged/closed
gh pr list --state all

# My PRs
gh pr list --author "@me"
```

### View PR

```bash
gh pr view NUMBER
gh pr view NUMBER --json title,body,commits,files,reviews
```

### Create PR

**Safe pattern:**
```bash
# Step 1: Use Write tool to create /tmp/gh-pr-body.md with:
# ## Summary
# - Bullet points
#
# ## Test plan
# - [ ] Test item

# Step 2: Create PR
gh pr create --title "feat: description" --body-file /tmp/gh-pr-body.md

# Step 3: Clean up
rm /tmp/gh-pr-body.md
```

### Merge PR

```bash
# Merge with squash (recommended)
gh pr merge NUMBER --squash

# Merge with rebase
gh pr merge NUMBER --rebase

# Regular merge
gh pr merge NUMBER --merge

# Delete branch after merge
gh pr merge NUMBER --squash --delete-branch
```

---

## Downloading Images from Issues

GitHub user-uploaded images (in issue bodies/comments) require authentication to download.

**Pattern:**
```bash
# Create temp directory
mkdir -p /tmp/issue-images

# Download with gh auth token
TOKEN=$(gh auth token)
curl -sL -H "Authorization: token $TOKEN" -o /tmp/issue-images/image.png "https://github.com/user-attachments/assets/UUID"

# Verify download
file /tmp/issue-images/image.png
```

**Why this works:** GitHub's `user-attachments/assets` URLs redirect to authenticated storage. Without the token header, you get a 9-byte redirect page instead of the actual image.

**Viewing downloaded images:** Use the Read tool on the downloaded file path — it handles images natively.

---

## Image Attachments (Private Repos)

For posting screenshots to GitHub issues/PRs in private repos, use the **github-image-comment** skill which provides hosted image uploads via psyt-admin dashboard.

This is the preferred method - no commits to repo, cleaner URLs, proper auth-gating.

---

## API Operations

For operations not supported by `gh` CLI directly:

```bash
# Edit a comment
gh api repos/OWNER/REPO/issues/comments/COMMENT_ID -X PATCH -f body="New body"

# Get all comments on an issue
gh api repos/OWNER/REPO/issues/NUMBER/comments

# Add reaction to issue
gh api repos/OWNER/REPO/issues/NUMBER/reactions -f content="+1"

# Get PR review comments
gh api repos/OWNER/REPO/pulls/NUMBER/comments
```

---

## Analysis Workflow

When asked to analyze an issue:

1. **View the issue**: `gh issue view NUMBER`
2. **Examine relevant code**: Search codebase for related files
3. **Create implementation plan** with:
   - Understanding (2-3 sentences)
   - File changes with [C]reate/[M]odify/[D]elete annotations
   - Tasks (specific actionable steps)
   - Considerations (blockers, questions, assumptions)

---

## Common Patterns

### Check which account is active
```bash
gh auth status
```

### Switch accounts
```bash
gh auth switch
```

### Get repo info
```bash
gh repo view --json nameWithOwner,isPrivate
```

### Link issue in commit
```bash
git commit -m "fix: resolve bug

Fixes #123"
```

### Link PR to issue
Include in PR body: `Closes #123` or `Fixes #123`
