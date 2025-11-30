# Create GitHub Issue

Create a new GitHub issue with the following details: $ARGUMENTS

Parse the input to extract:
- Title (required)
- Body/description (optional)

Then create the issue using the SAFE pattern to prevent command injection:

```bash
# Step 1: Create docs/issues/ directory if it doesn't exist
mkdir -p docs/issues/

# Step 2: Write body content to temporary file using Write tool (SAFER than cat/heredoc)
# Use the Write tool to create docs/issues/temp-issue-body.md with the issue content
# This avoids heredoc parsing issues and command execution risks

# Step 3: Create issue using --body-file (NEVER use --body with technical content)
gh issue create --title "TITLE" --body-file docs/issues/temp-issue-body.md

# Step 4: Clean up temporary file
rm docs/issues/temp-issue-body.md
```

Provide the issue number and URL after creation.

⚠️ **CRITICAL**: Never use `--body` parameter with technical content! Backticks and $() in --body will execute as commands.