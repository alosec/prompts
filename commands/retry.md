---
name: Retry
description: Reset to previous message when context overflows or response fails. Use when agent produces oversized response that crashes context.
---

# Retry Command

When context window overflows or agent produces problematic response:

1. User branches back to previous message in conversation
2. User invokes `/retry` or `#retry` with simplified request
3. Agent acknowledges the reset and proceeds with constrained response

## Guidelines

- Keep responses concise
- Avoid large file dumps
- Use `head`, `tail`, `grep` to filter output
- Summarize instead of listing everything
- If task requires large output, break into smaller steps

## Response Format

Brief acknowledgment, then proceed with the task using minimal tokens.
