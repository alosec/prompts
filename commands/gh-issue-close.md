# Close GitHub Issue

Resolve or close GitHub issue after implementation: $ARGUMENTS

Parse the input to extract:
- Issue number (required)
- Resolution comment (optional)

Steps:
1. If a resolution comment is provided, add it first using the SAFE method:

```bash
# Step 1: Create docs/issues/ directory if it doesn't exist
mkdir -p docs/issues/

# Step 2: Write resolution comment content to temporary file using Write tool (SAFER than cat/heredoc)
# Use the Write tool to create docs/issues/temp-resolution-comment.md with the resolution content
# This avoids heredoc parsing issues and command execution risks

# Step 3: Add comment using --body-file (NEVER use --body with technical content)
gh issue comment NUMBER --body-file docs/issues/temp-resolution-comment.md

# Step 4: Clean up temporary file
rm docs/issues/temp-resolution-comment.md
```

2. Close the issue:
```bash
gh issue close NUMBER
```

3. Confirm the issue has been closed.

⚠️ **CRITICAL**: Never use `cat > file <<'EOF'` or `--body` parameter with technical content! Backticks and $() in heredocs/--body will execute as commands. Always use the Write tool for file creation.