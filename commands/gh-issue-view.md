# View GitHub Issue

Read and review GitHub issue: $ARGUMENTS

Parse the input to determine:
- Issue number (if provided)
- Search criteria (if searching)

If issue number provided:
```bash
gh issue view NUMBER
```

If searching/listing:
```bash
gh issue list [--state open|closed|all]
```

Display the issue details including title, body, and comments.