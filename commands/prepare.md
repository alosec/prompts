# Prepare for Work

**Task**: $ARGUMENTS

## What I'll Do

Quick workspace prep - read the memory bank to get oriented, check current project status, then get ready to tackle whatever you need.

## Memory Bank Review Strategy

First, I'll check what memory bank structure exists in this project:
- **New structure** (post-Oct 2025): Organized folders (00-core, 01-architecture, 02-active, etc.)
- **Legacy structure**: Flat files in memory-bank/ root

### For New Structure (Prioritized Reading Order):

**Essential (read first):**
- `02-active/currentWork.md` - What's happening NOW
- `02-active/blockers.md` - Active obstacles
- `02-active/nextUp.md` - Prioritized tasks

**Context (read as needed):**
- `00-core/projectbrief.md` - What we're building
- `00-core/productContext.md` - Why this exists
- `01-architecture/systemPatterns.md` - Architecture patterns
- `01-architecture/techContext.md` - Tech stack
- `01-architecture/design-language.md` - Design system
- `01-architecture/database/schema.md` - Database structure

**Reference (read when implementing):**
- `03-guides/` - How-to documentation
- `.clauderules` - Project patterns

**History (read when curious):**
- `04-history/sessions/` - Recent work
- `04-history/progress.md` - Overall status

### For Legacy Structure:

Reading core files:
- `projectbrief.md` - What we're building and why
- `activeContext.md` or `currentWork.md` - What's happening now
- `progress.md` - What's done and what's next
- `systemPatterns.md` - Architectural patterns
- `techContext.md` - Technologies and constraints
- `.clauderules` - Project patterns

## GitHub Account Check
Run `gh auth status` to verify which GitHub account is currently active. This prevents commits/PRs from the wrong account and ensures proper access to repositories.

## Git Status Check
Quick check of what's changed, staged, or needs attention in the repo.

## Beads Issue Check
Check for active issues in the project using `bd ready` to see what's ready to work on, or `bd list` to see all issues. Include a brief summary of any relevant issues in the output.

## Output Style

I'll give you a natural, conversational summary like:

---

**Current situation:** [What's going on with the project in plain English]

**Files I'm looking at:**
```
project/
├── memory-bank/ - My knowledge base
├── src/ - The actual code
└── [relevant areas for the task]
```

**Status check:** [Clean repo / Changes pending / Whatever's happening]

**Ready to work on:** [The specific task you mentioned, or ready for whatever]

---

The goal is to be prepared and oriented without any formal ceremony. Just a quick "here's where we are, here's what I know, what do you need?"