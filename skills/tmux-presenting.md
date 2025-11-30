---
name: tmux-presenting
description: Present code files and context in tmux pane for collaborative examination. Activate when user mentions tmux, presenting code, showing in another pane, sharing files, looking at code together, or examining files side-by-side.
allowed-tools: Bash, Read, Grep, Glob
---

# Tmux Presentation Mode

This skill enables collaborative code examination by presenting files in a separate tmux pane. The pattern: show a file, let it sit for discussion, then move to the next topic when ready.

## Core Pattern

**The idea:** Present code in pane 1, discuss in pane 0. Each presentation should persist for extended discussion time.

**Key principles:**
1. **Non-interactive commands only** - Use `cat`, `bat`, `less -f`, never interactive prompts
2. **Clear interrupts first** - Send `C-c` before each presentation to ensure clean state
3. **Slow, deliberate pacing** - One file at a time, let it breathe
4. **Context over speed** - Better to show 2 files well than 10 files quickly

## Basic Commands

### Show a file in pane 1
```bash
# Clear any running process first
tmux send-keys -t 1 C-c

# PREFERRED: bat with numbers, grid, no paging (excellent for presentations)
tmux send-keys -t 1 "bat --style=numbers,grid --paging=never /path/to/file.ts" C-m

# Alternative with cat if bat not available
tmux send-keys -t 1 "cat /path/to/file.ts" C-m
```

**Why `bat --style=numbers,grid --paging=never`?**
- `--style=numbers,grid` - Line numbers + clean grid layout
- `--paging=never` - No interactive pager, shows everything immediately
- Perfect for tmux pane presentations where content should persist

### Show specific lines
```bash
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "sed -n '100,200p' /path/to/file.ts | bat --style=numbers,grid --paging=never -l typescript" C-m
```

### Show multiple related sections
```bash
# First section
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "echo '=== SearchBar.tsx:108-118 (handleInputChange) ===' && sed -n '108,118p' src/app/components/SearchBar/SearchBar.tsx" C-m
```

### Clear the pane
```bash
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "clear" C-m
```

## Workflow Examples

### Example 1: Examining a plan document
```bash
# Show the v2 plan
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "bat memory-bank/features/redis-autocomplete-integration/plan-v2-lightweight-autocomplete.md" C-m
```

Then wait for user to read and discuss. Don't rush to the next file.

### Example 2: Comparing two approaches
```bash
# Show current implementation
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "echo '=== Current: answerQuery.ts ===' && bat src/app/api/search/answerQuery.ts" C-m

# Later, when ready to compare
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "echo '=== Proposed: plan-v2 architecture ===' && sed -n '28,56p' memory-bank/features/redis-autocomplete-integration/plan-v2-lightweight-autocomplete.md" C-m
```

### Example 3: Walking through call chain
```bash
# Step 1: Entry point
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "echo '=== Step 1: SearchBar input handling ===' && sed -n '108,120p' src/app/components/SearchBar/SearchBar.tsx" C-m

# After discussion, move to step 2
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "echo '=== Step 2: ViewStore.setSearchQuery ===' && sed -n '365,375p' src/app/view/ViewStore.ts" C-m
```

## Best Practices

### DO:
- **Send C-c before every presentation** - Ensures clean state
- **Use descriptive headers** - `echo '=== Context ==='` before showing code
- **Present one concept at a time** - Don't rapid-fire multiple files
- **Wait for user response** - Let them read and think
- **Use bat/syntax highlighting** - Makes code easier to read

### DON'T:
- **Don't use interactive tools** - No `vim`, `nano`, interactive `less` without `-f`
- **Don't spam send-keys** - One presentation, then pause
- **Don't show huge files** - Use `sed -n` or `head`/`tail` to show relevant sections
- **Don't assume pane is ready** - Always C-c first

## Common Patterns

### Pattern: "Let's look at this file together"
```bash
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "bat path/to/file.ext" C-m
```
Then discuss. Move to next file only when conversation shifts.

### Pattern: "Here's the specific section"
```bash
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "echo '=== File.ts:123-145 (function name) ===' && sed -n '123,145p' path/to/File.ts | bat -l typescript" C-m
```

### Pattern: "Compare these two sections"
```bash
# Show first
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "echo '=== OLD: Path 1 (Heavy) ===' && sed -n '28,42p' plan.md" C-m

# After discussion, show second
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "echo '=== NEW: Path 2 (Lightweight) ===' && sed -n '44,56p' plan.md" C-m
```

### Pattern: "Here's the context tree"
```bash
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "tree -L 3 memory-bank/features/" C-m
```

## Troubleshooting

### Pane seems stuck
```bash
# Nuclear option - interrupt and clear
tmux send-keys -t 1 C-c C-c C-c
tmux send-keys -t 1 "clear" C-m
```

### Long file truncated
```bash
# Use less with quit piped in
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "cat large-file.txt | less -f" C-m
# Or just show specific sections
tmux send-keys -t 1 "head -n 100 large-file.txt" C-m
```

### Syntax highlighting not working
```bash
# Fallback to cat if bat not available
tmux send-keys -t 1 C-c
tmux send-keys -t 1 "cat file.ts" C-m
```

## Integration with Planning

When examining plans or discussing architecture:

1. **Start with high-level context** (show the plan summary)
2. **Drill into specific sections** (show implementation details)
3. **Compare alternatives** (show old vs new approach)
4. **Examine actual code** (show current implementation)
5. **Return to plan** (show how it addresses the issue)

**Pacing is key** - This is collaborative exploration, not a presentation sprint. Each file should sit long enough for real discussion.

## Example Session Flow

```
User: "Let's examine the v2 plan"

Claude: I'll present the v2 plan in pane 1 so we can look at it together.
[Sends: tmux send-keys -t 1 C-c]
[Sends: tmux send-keys -t 1 "bat memory-bank/features/.../plan-v2.md" C-m]

"I'm showing the full v2 plan now. The key insight is in lines 28-56
where we compare the current heavy flow vs the new lightweight flow.
What part should we dig into first?"

User: "Show me the architecture comparison"

Claude: Let me focus on that section specifically.
[Sends: tmux send-keys -t 1 C-c]
[Sends: tmux send-keys -t 1 "echo '=== Architecture Comparison ===' && sed -n '28,80p' plan-v2.md | bat -l markdown" C-m]

"Now showing the current vs new flow comparison. Notice how the new
flow skips createLayers() entirely for the dropdown..."

[Discussion happens naturally, Claude waits for next question]
```

## Remember

**This is pair programming, not automation.** The goal is shared understanding, not speed. Each presentation should enable conversation, not replace it.