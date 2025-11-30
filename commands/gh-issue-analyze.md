# Analyze GitHub Issue

Review GitHub issue #$ARGUMENTS and create a structured implementation plan.

**Issue:** #$ARGUMENTS

## Instructions

1. **Issue Review**: Use `gh issue view $ARGUMENTS` to read the issue and all comments
2. **Code Context**: Briefly examine relevant files to understand current implementation
3. **Requirements Analysis**: Parse the issue requirements and identify core needs
4. **Implementation Plan**: Create a structured plan with file changes and tasks

## Output Format

```
## Understanding
[2-3 sentences summarizing what the issue requests]

## File Changes
```
path/to/file.ext
├── [C] NewComponent.tsx - Brief description of new component
├── [M] ExistingFile.tsx - What changes will be made
├── [M] styles.css - Style updates needed
└── [D] OldFile.tsx - Why this file will be removed
```

## Tasks
1. Specific actionable step
2. Another implementation task
3. Testing or validation step

## Considerations
- Any blockers or dependencies
- Questions that need clarification
- Assumptions being made
```

## Legend
- [C] = Create new file
- [M] = Modify existing file
- [D] = Delete file

Keep descriptions concise and focus on essential changes needed to address the issue.