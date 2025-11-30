# Git Checkpoint Command

Save current work progress with a conventional commit message. Uses a subagent to preserve context in the main conversation thread.

**Usage**: `/checkpoint [brief|verbose|custom message]`
- `brief` (default): Generate concise commits using specific conventional types
- `verbose`: Generate comprehensive commit messages with architectural documentation  
- `custom message`: Use provided text as commit message directly

## Context Preservation Strategy

This command delegates the checkpoint task to a subagent to:
- **Preserve main thread context**: Keep the primary conversation focused on development work
- **Isolate git operations**: Handle complex git analysis and commit logic separately
- **Maintain conversation flow**: Return control to main thread after checkpoint completion
- **Reduce context pollution**: Avoid cluttering main conversation with git command outputs

## Commit Types (Brief Format):
- **feat**: New feature, refactor, or significant change to user-facing functionality
- **dev**: Infrastructure, build tools, development environment, or technical setup
- **chore**: Boring maintenance tasks, dependency updates, cleanup, basic fixes
- **docs**: Memory bank updates, documentation, README changes, or knowledge management

## Subagent Instructions

Launch a Task agent with the following comprehensive prompt:

**Task Description**: Create git checkpoint with conventional commit message

**Agent Prompt**: 
```
You are a git checkpoint specialist. Your task is to analyze the current repository state and create an appropriate commit to save the work progress.

## Steps to execute:

1. **Review current changes**:
   - Run `git status` to see all modified and untracked files
   - Run `git diff` to review all unstaged changes
   - Run `git diff --staged` to review any staged changes

2. **Analyze recent work**:
   - Run `git log --oneline -5` to see recent commit history
   - Identify the changes and their scope
   - Categorize changes into appropriate commit type

3. **Evaluate commit splitting strategy**:
   - Assess if changes represent multiple logical units that should be separate commits
   - Look for distinct categories like: documentation updates, feature changes, styling adjustments, configuration changes, etc.
   - If multiple logical groupings exist, create separate commits for each logical unit
   - If changes are cohesive and represent a single logical unit, create one commit

4. **Determine commit message approach**:
   - If arguments contain a custom message: Use it directly
   - If arguments contain "verbose": Use comprehensive format
   - Default or "brief": Use specific conventional format with defined types

5. **Stage and commit changes strategically**:
   - If single logical unit: Stage all relevant changes with `git add` and create one commit
   - If multiple logical units: Use `git add` with specific file paths to stage related changes separately, creating multiple focused commits
   - Generate appropriate commit message(s) based on selected format

6. **Save working state**:
   - After committing, verify saved state with `git status`
   - Document any intentionally uncommitted files

## Brief Commit Format (default):
```
type: concise description of change

Optional single-line explanation if needed.
```

**Brief Examples:**
```
feat: add user authentication system
dev: configure TypeScript build pipeline  
chore: update dependencies to latest versions
docs: update memory bank with API patterns
```

## Verbose Commit Format (when using "verbose"):
```
type: implement [feature/system] with [architectural pattern]

Architectural Decisions:
- Chose [pattern/approach] because [reasoning]
- Implemented [component] using [technology/pattern] to achieve [goal]
- Structured [module] to support [future capability]

Technical Rationale:
- [Decision 1]: [Why it matters for the system]
- [Decision 2]: [Trade-offs considered]

This establishes [pattern/convention] for future [components/features].
Next steps include [what comes next].
```

## Commit Message Guidelines:
- Use conventional commit format: type: description
- Keep first line under 50 characters when possible
- Use present tense, imperative mood ("add feature" not "added feature")
- Reference specific components, patterns, or systems affected
- For verbose commits, include architectural reasoning and context

## Final Output:
Return a concise summary of:
1. What changes were committed (list each commit if multiple were created)
2. The commit message(s) used
3. Current repository state
4. Any files intentionally left uncommitted
5. Rationale for commit splitting strategy (if multiple commits were created)

Arguments provided: $ARGUMENTS
```

## Implementation

Use the Task tool to launch the checkpoint subagent with the comprehensive instructions above, passing through any user arguments for commit message customization.

Arguments: $ARGUMENTS