# Init Session

Global orientation for starting a work session. Checks GitHub, Linear ABG, and global memory bank.

## What I'll Do

1. **Global Memory Bank Check** - Look for `~/global-memory-bank/` and read key context
2. **GitHub Account Check** - Run `gh auth status` to verify active account
3. **Linear ABG Check** - Run `linearis-abg issues list` to see current priorities
4. **Quick Summary** - Surface what's active and ready to work on

## Global Memory Bank

The global memory bank at `~/global-memory-bank/` contains cross-project knowledge that spans all work on this machine. Unlike project-level memory banks, this is for the user, not a specific codebase.

### Structure

```
~/global-memory-bank/
├── README.md                    # Quick orientation
├── 00-core/                     # Identity, systems, active focus
│   ├── identity.md              # Who the user is, preferences
│   ├── systems.md               # Tools, workflows, environments
│   └── active-focus.md          # Current priorities across projects
├── 01-patterns/                 # Reusable patterns
│   └── [workflow-name].md       # Patterns that work across projects
├── 02-contacts/                 # People, orgs, relationships
│   └── [person-or-org].md       # Context about collaborators
├── 03-learnings/                # Technical learnings
│   └── [topic].md               # Gotchas, discoveries, TILs
├── 04-projects/                 # Cross-project summaries
│   └── [project-name].md        # High-level project context
└── 05-sessions/                 # Archived session logs
    └── YYYY-MM-DD-topic.md      # Notable session outcomes
```

### Reading Order for Init

1. `00-core/active-focus.md` - What's the priority right now?
2. `00-core/identity.md` - Who am I working with?
3. `00-core/systems.md` - What tools are available?

### If Global Memory Bank Doesn't Exist

Mention that `~/global-memory-bank/` could be created for cross-project context. Don't create it automatically - just note its absence.

## Output Style

Natural, conversational summary:

---

**Global context:** [Brief summary from global memory bank, or note if it doesn't exist]

**GitHub:** [Active account - alosec or alexgarcia-wq]

**Active priorities (Linear ABG):**
- [Top issues from linearis-abg, focusing on Priority 1-2]

**Ready to work on:** [Brief summary of what's next based on priorities]

---

Keep it brief. The goal is orientation, not ceremony.
