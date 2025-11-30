# GitHub Issue List Command

Review all open GitHub issues and provide a comprehensive yet brief overview, grouped by logical areas.

## Instructions:
1. Use `gh issue list` to get all open issues
2. Group issues by logical areas/themes
3. Provide a bulleted list with super brief summaries
4. Focus on high-level overview rather than details
5. Include issue numbers for reference

## Command:
```bash
gh issue list --state open --limit 100 --json number,title,labels,body
```

## Expected Output Format:
Present results as a bulleted list grouped by logical areas, such as:
- **Feature Area 1**
  - #X: Brief one-line summary
  - #Y: Brief one-line summary
- **Feature Area 2**
  - #Z: Brief one-line summary

Keep summaries to essential points only. Focus on what each issue aims to achieve rather than implementation details.

$ARGUMENTS