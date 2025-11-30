# Spawn Parallel Claude Instance

When the user invokes `/spawn <prompt>`, you MUST execute the bash commands to spawn a new Claude instance in a tmux split.

## Available Claude Launch Aliases

The user has configured several Claude Code launch aliases in `.bashrc`:

- **`claude`** - Basic Claude Code (no MCP servers)
- **`claudedanger`** - Claude with permissions skipped
- **`cn`** - Claude with no MCP servers (strict config)
- **`cnd`** - Claude with no MCP servers + skip permissions
- **`cnds`** - Claude with **Supabase MCP** + skip permissions
- **`cndsp`** - Claude with **Supabase MCP + Playwright MCP** + skip permissions ⭐

**Default for /spawn: Use `cnd` (no MCP servers, skip permissions)**

This is the lightweight default that works for most tasks. Users can explicitly request other aliases:
- Use `cndsp` for Supabase + Playwright MCP (database, auth, browser testing)
- Use `cnds` for Supabase MCP only
- Use `cn` for strict mode with no MCP servers

Unless the user explicitly requests a different alias, always use `cnd`.

## Your Action Required
Execute these bash commands to spawn the new instance:

```bash
tmux new-window
tmux send-keys "cnd 'Run /prepare to orient yourself. Read memory-bank/02-active/currentWork.md and check Beads issues with bd ready. Then: <enhanced-prompt>'" Enter
```

**Preparation included:**
- Runs `/prepare` to load project context
- Reads current work status from memory bank
- Checks Beads for issue status
- Then executes the enhanced prompt

**Workflow Guidance:**
For complex tasks requiring planning, advise the spawned instance to:
1. First run `/plan` after orientation to create an implementation strategy
2. Then run `/act` after planning is approved to execute the plan
3. This ensures structured approach: orient → plan → execute

## Prompt Enhancement
**DO NOT** pass the user's prompt verbatim. Transform and enhance it for the new agent:

### 1. Strip Meta-Instructions
Remove any language about "spawning" or "assigning" a new instance:
- ❌ "Assign new instance to fix the dropdown"
- ✅ "Fix the dropdown in website/src/components/Sidebar.astro"
- ❌ "Have the new agent implement this"
- ✅ "Implement the sidebar persistence feature"

### 2. Make It Direct
Address the spawned agent directly with a clear task:
- ❌ "Tell it to read this file and fix it"
- ✅ "Read website/src/layouts/Layout.astro and fix the authentication bug"

### 3. Add Specific Context
- If user references "this file", include the actual file path
- If user says "this plan", include the path to the plan you just created/read
- If user mentions "the task", include the task file path
- Add current working directory context if relevant
- Keep the enhancement conversational and minimal

**Goal:** Make the spawned agent's job easier by providing specific paths and context they need, while speaking TO them, not ABOUT them.

## What This Does
1. Creates a new tmux window (not a split pane)
2. Launches Claude with `cnd` (no MCP servers, skip permissions) in the new window
3. Automatically runs `/prepare` to orient the new instance
4. Reads memory bank to understand current work
5. Checks Beads issues to see available tasks
6. Executes the enhanced prompt with full context

The new Claude instance runs independently in a separate window with full project context and can work on research, planning, or implementation tasks while you continue working in the original window.

## Example Usage

**User types:**
```
/spawn Continue with pedicab-287 implementation
```

**You execute:**
```bash
tmux new-window
tmux send-keys "cnd 'Run /prepare to orient yourself. Read memory-bank/02-active/currentWork.md and check Beads issues with bd ready. Then: Continue with pedicab-287 (remove email thumbnail) implementation. Consider using /plan first if this requires design decisions, then /act to execute.'" Enter
```

**User types:**
```
/spawn Start the backroom tab feature
```

**You execute:**
```bash
tmux new-window
tmux send-keys "cnd 'Run /prepare to orient yourself. Read memory-bank/02-active/currentWork.md and check Beads issues with bd ready. Then: Start implementing pedicab-289 (Test Videos tab in Backroom dashboard)'" Enter
```

**User types:**
```
/spawn Research git worktrees
```

**You execute:**
```bash
tmux new-window
tmux send-keys "cnd 'Run /prepare to orient yourself. Read memory-bank/02-active/currentWork.md and check Beads issues with bd ready. Then: Research git worktree setup for concurrent feature development (pedicab-304)'" Enter
```

**User requests different alias:**
```
/spawn cn Research this API endpoint
```

**You execute:**
```bash
tmux new-window
tmux send-keys "cn 'Run /prepare to orient yourself. Read memory-bank/02-active/currentWork.md and check Beads issues with bd ready. Then: Research the /api/users endpoint implementation'" Enter
```
