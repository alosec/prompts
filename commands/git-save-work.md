# Git Save Work Command

Review the current git status and prepare to save the working state with a commit message tailored to the specified detail level.

**Usage**: `/git-save-work [brief|verbose]`
- `brief`: Generate concise, conventional commit messages
- `verbose`: Generate comprehensive commit messages with architectural documentation
- Default: `verbose` (maintains backward compatibility)

## Steps to execute:

1. **Review current changes**:
   - Run `git status` to see all modified and untracked files
   - Run `git diff` to review all unstaged changes
   - Run `git diff --staged` to review any staged changes

2. **Analyze recent work**:
   - Run `git log --oneline -10` to see recent commit history
   - Identify the changes and their scope
   - Note any significant technical choices made

3. **Determine commit message style based on arguments**:
   - If `$ARGUMENTS` contains "brief": Use concise format
   - If `$ARGUMENTS` contains "verbose" or is empty: Use comprehensive format

4. **Stage changes and commit**:
   - Stage all relevant changes with `git add`
   - Generate appropriate commit message based on selected format

5. **Save working state**:
   - After committing, verify saved state with `git status`
   - Document any intentionally uncommitted files

## Brief Commit Format (when using "brief"):
```
type(scope): concise description of change

Optional single-line explanation if needed.
```

**Brief Examples:**
```
fix: resolve EventBlock boundary spillover
feat: add user authentication system
refactor: simplify data validation logic
```

## Verbose Commit Format (when using "verbose" or default):
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

Arguments: $ARGUMENTS