# Comment on GitHub Issue

Add a comment to GitHub issue: $ARGUMENTS

Parse the input to extract:
- Issue number (required)
- Comment text (required)

IMPORTANT: For safety, write the comment using the Write tool to create a temporary file:

1. Use Write tool to create `/tmp/gh-comment-body.md` with the comment content
2. Run `gh issue comment NUMBER --body-file /tmp/gh-comment-body.md`
3. Clean up with `rm /tmp/gh-comment-body.md`

Never use --body parameter directly or heredoc/EOF syntax as it can cause command injection with technical content.