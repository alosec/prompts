---
name: Ideaflow Standup
description: Generate daily standup entry in team format. Activate when user mentions standup, stand-up, daily update, status update, or asks to update standup. Reviews memory-bank files and git history to create accurate standup following team conventions.
allowed-tools: Read, Bash, Edit
---

# Ideaflow Standup Skill

Generate daily standup entries following Ideaflow team's established format.

## Format Requirements

The standup must follow this exact structure:

```
Committed to Previously:
[Items from previous standups - mostly :white_large_square: showing ongoing work]
[Completed items from past get :white_check_mark:]

Today:
[What was done today]
[Use :white_check_mark: for completed items]
[Use :fish_cake: for blockers/in-progress items]

--
Committing to Next:
[Future commitments - next days/week]
[Use :white_large_square:]

---

# Previous: Daily Standup - [Previous Date]
[Keep previous standup for reference]
```

## Emoji Key

| Emoji | Slack Code | Meaning |
|-------|------------|---------|
| ⬜ | `:white_large_square:` | Not started / committed to |
| ✅ | `:white_check_mark:` | Completed |
| 🍥 | `:fish_cake:` | In progress / blocked / needs attention |

## Content Guidelines

### Tone
- **Concise and technical** - Focus on what shipped and what's blocked
- **Specific** - Name actual files, features, and issues
- **Objective** - Report facts, not speculation
- **Action-oriented** - Every item should be concrete and measurable

### What to Include

**Committed to Previously:**
- Long-running commitments from past standups that are NOT yet complete
- Keep open items as `:white_large_square:` to show continuity
- **Remove items that were marked :white_check_mark: in previous standup** - completed items don't carry forward

**Today:**
- What was actually done today - concrete accomplishments with specifics
- Example: "Added E2E test flows: landing page, settings navigation, enable autocomplete"
- NOT: "Worked on tests"
- Include infrastructure work, bug fixes, feature implementations
- Use `:white_check_mark:` for completed items
- Use `:fish_cake:` for blockers with clear description of what's stuck

**Committing to Next:**
- Clear commitments for upcoming work (tomorrow and beyond)
- Should flow naturally from completing "Today" items
- Keep focused (3-5 items max)
- Use `:white_large_square:` for items not yet started

### What to Avoid
- Vague descriptions ("work on feature", "investigate issue")
- Over-promising on scope
- Omitting blockers or challenges
- Speculation about future without concrete plan

## Team Feedback (from Jacob)

> "The most important elements are stuff you've committed to yesterday, stuff you've committed to today, and stuff you might be planning to commit to tomorrow. If you've gotten something done, change it from an open square to a green checkbox. It's not a big deal if you don't actually get something done that you committed to. I just want to track it."

This means:
- **Track commitments across time** - they persist until completed or explicitly dropped
- **Change status as work progresses** - `:white_large_square:` → `:white_check_mark:`
- **Don't hide incomplete items** - keep them visible for continuity
- **Focus on tracking, not perfection** - the goal is visibility, not pressure
- **Completed items disappear** - Once marked `:white_check_mark:`, they don't carry forward to next standup

## Example Standup

```
Committed to Previously:
:white_large_square: Mew documentation update (doc/ PR)
:white_large_square: Investigate #1557 (504 timeout on /api/layer/initial)

Today:
:white_check_mark: Shipped Mew CLI bash wrapper (PR #78 merged to mew-mcp)
:white_check_mark: Built Unix-like tools: `mew ls`, `mew cat`, `mew tree`, `mew find`, `mew edit`
:white_check_mark: Mew Slack bot now has full access to GitHub, Linear, Mew knowledge graph
:white_check_mark: Local staging environment operational (Docker + Postgres)
:fish_cake: PR #1559 (autocomplete fix) - approved, awaiting merge

--
Committing to Next:
:white_large_square: Merge PR #1559 after approval
:white_large_square: Deep dive into #1557 (504 timeout) - add logging, inspect browser state
:white_large_square: Submit Mew documentation PR

---
```

## Information Sources

Review these in order:

1. **memory-bank/02-active/currentWork.md** - Current focus and context
2. **memory-bank/standup.md** - Previous standup for continuity
3. **Git history** - Commits since last standup
   ```bash
   git log --since="YYYY-MM-DD" --pretty=format:"%h - %s" --no-merges
   ```
4. **Linear/Beads issues** - Check for context on active work

## Related

- Linear: ABG-48 (recurring standup task)
- Mew repo: `.claude/skills/standup/SKILL.md` (authoritative source)
- ag-work-log: GitHub issues for daily standup tracking
