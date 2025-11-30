# Save Context Command

Save the current project context with specified detail level for future reference.

**Usage**: `/save-context [A_LOT|A_LITTLE] [optional-description]`

## Instructions

When the user runs `/save-context`, capture the current project state and context with the specified detail level:

### A_LOT (Comprehensive Context)
- Read ALL memory bank files
- Document current file structure and key components
- Capture recent changes, git status, and work in progress
- Include technical decisions, patterns, and implementation details
- Save current todo list and task status
- Document any blockers, issues, or important discoveries
- Include user preferences and project-specific patterns from .clauderules

### A_LITTLE (Essential Context)
- Read activeContext.md and progress.md from memory bank
- Capture current task focus and immediate next steps
- Include recent file changes and git status
- Save essential project state and current work direction
- Document any critical blockers or decisions

## Output Format

```
## Context Saved: [timestamp]
**Detail Level**: [A_LOT|A_LITTLE]
**Description**: [user-provided description or auto-generated]

### Current Focus
[What you're currently working on]

### Project State
[Key information about current state]

### Next Steps
[What should happen next]

### Important Notes
[Critical context for future sessions]
```

The saved context should be comprehensive enough that you can resume work effectively after a memory reset.

Arguments: $ARGUMENTS (use this for detail level and optional description)