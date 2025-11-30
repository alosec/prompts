# Edit GitHub Issue

Edit GitHub issue title and/or body: $ARGUMENTS

Parse the input to extract:
- Issue number (required)
- New title (optional)
- New body content (optional)

## Instructions:
Use the SAFE pattern to prevent command injection when editing issue content:

```bash
# Step 1: Create docs/issues/ directory if it doesn't exist
mkdir -p docs/issues/

# Step 2: If updating body, write content to temporary file using Write tool
# Use the Write tool to create docs/issues/temp-issue-body.md with the new body content
# This avoids heredoc parsing issues and command execution risks

# Step 3: Edit issue using appropriate flags
# For title only:
gh issue edit NUMBER --title "NEW_TITLE"

# For body only:
gh issue edit NUMBER --body-file docs/issues/temp-issue-body.md

# For both title and body:
gh issue edit NUMBER --title "NEW_TITLE" --body-file docs/issues/temp-issue-body.md

# Step 4: Clean up temporary file if created
rm -f docs/issues/temp-issue-body.md
```

Confirm the changes after editing.

⚠️ **CRITICAL**: Never use `--body` parameter with technical content! Backticks and $() in --body will execute as commands.