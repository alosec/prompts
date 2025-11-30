---
name: Quiet Build
description: Use filtered build command to reduce context usage. Activate when building the project, running npm build, or checking for build errors.
allowed-tools: Bash
---

# Quiet Build

## When to Use
Activate whenever the user asks to:
- Build the project
- Run a build
- Check for build errors
- Compile the application

## Instructions

Always use the quiet build command pattern that filters output to show only essential information:

```bash
npm run build 2>&1 | grep -E "(error|Error|✓ Completed|✨ Success)"
```

### Why This Matters
- Reduces context usage significantly
- Shows only relevant information (errors and completion status)
- Prevents context window pollution with verbose build logs
- Maintains fast response times

### What Gets Shown
- Build errors (if any)
- Completion confirmation
- Success messages
- Critical warnings

### What Gets Filtered
- Verbose progress output
- Detailed file processing logs
- Non-critical informational messages

## Timeout
Always set a 120000ms (2 minute) timeout for build commands.
