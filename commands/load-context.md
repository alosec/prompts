# Load Context Command

Load and orient to project context with specified detail level.

**Usage**: `/load-context [A_LOT|A_LITTLE] [optional-focus-area]`

## Instructions

When the user runs `/load-context`, load project context with the specified detail level to orient yourself for work:

### A_LOT (Deep Orientation)
- Read ALL memory bank files in hierarchical order:
  1. projectbrief.md (foundation)
  2. productContext.md, systemPatterns.md, techContext.md (core context)
  3. activeContext.md (current state)
  4. progress.md (status)
  5. Any additional context files
- Review .clauderules for project-specific patterns and preferences
- Check git status and recent commits
- Read current todo list if it exists
- Examine key project files and structure
- Load comprehensive understanding of architecture, patterns, and current state

### A_LITTLE (Quick Orientation)
- Read activeContext.md and progress.md from memory bank
- Check .clauderules for immediate patterns
- Review git status and current branch
- Load essential context for immediate task focus
- Quick scan of current todo list

## Output Format

```
## Context Loaded: [timestamp]
**Detail Level**: [A_LOT|A_LITTLE]
**Focus Area**: [optional focus area or general]

### Project Understanding
[Brief summary of what this project does]

### Current State
[Where things stand now]

### My Orientation
[What I understand about current work and next steps]

### Ready For
[What kinds of tasks I'm prepared to handle]
```

After loading context, you should be ready to continue work effectively with full understanding of the project state.

Arguments: $ARGUMENTS (use this for detail level and optional focus area)