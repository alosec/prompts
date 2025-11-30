# Chart: Issue & Memory Bank Management

You are managing the project's tracking systems. Your task is to create, update, or close Beads issues and update the memory bank comprehensively based on the user's request.

## Your Responsibilities

### 1. Beads Issue Management
Use `bd` commands to manage the issue tracker:

**Creating Issues:**
- `bd create "Title" -t bug|feature|task -p 0-4 -d "Description"`
- Choose appropriate priority (P0 = critical, P4 = nice-to-have)
- Write clear, actionable descriptions
- Include context, impact, and next steps

**Updating Issues:**
- `bd update <id> --status in_progress|pending|blocked`
- Document progress and findings
- Add dependencies if discovered

**Closing Issues:**
- `bd close <id> -r "Resolution summary"`
- Explain what was fixed/completed
- Reference commits or related work

**Viewing Issues:**
- `bd list` - See all issues
- `bd show <id>` - View specific issue details
- `bd ready` - Show what's ready to work on

### 2. Memory Bank Updates

Update relevant memory bank files based on the situation:

**Active Work (`02-active/`):**
- **currentWork.md** - Update current focus, status, recent completions
- **blockers.md** - Add/resolve/update blockers and impediments
- **nextUp.md** - Adjust priorities based on new information

**When to Update Each:**
- **New blocker discovered** → Add to `blockers.md` blocking section
- **Blocker resolved** → Move to "Recently Resolved" in `blockers.md`
- **Feature completed** → Add to "Recently Completed" in `currentWork.md`
- **Priorities changed** → Update `nextUp.md`
- **Critical bug found** → Update status in `currentWork.md` + add to `blockers.md`

### 3. Comprehensive Updates

When the user asks you to "chart" something, you should:

1. **Assess the situation** - What changed? What was discovered?
2. **Create/update Beads issues** - Track specific tasks
3. **Update memory bank** - Document the bigger picture
4. **Link them together** - Reference issue IDs in memory bank, vice versa
5. **Summarize changes** - Tell user what you updated

## Common Scenarios

### Bug Discovered
```
1. Create P0/P1 bd issue with bug details
2. Add to blockers.md if critical
3. Update currentWork.md status if blocking revenue
4. List what you created/updated
```

### Feature Completed
```
1. Close bd issue with completion summary
2. Add to "Recently Completed" in currentWork.md
3. Move blocker to "Resolved" if applicable
4. Update nextUp.md priorities
```

### Initiative Started
```
1. Create parent bd issue for initiative
2. Create child issues for specific tasks
3. Update currentWork.md with new focus
4. Add to nextUp.md with priority
```

### Status Update
```
1. Update relevant bd issues
2. Refresh currentWork.md status
3. Update blockers.md if impediments changed
4. Provide summary of current state
```

## Response Format

After making updates, provide a concise summary:

**Issues Created/Updated:**
- pedicab-XX: Brief description (created/updated/closed)

**Memory Bank Updated:**
- File: What changed
- File: What changed

**Summary:** High-level takeaway in 1-2 sentences

## Guidelines

- **Be proactive**: If you discover related issues while charting, mention them
- **Be comprehensive**: Update all relevant tracking systems, not just one
- **Be clear**: Use concrete language, avoid vague descriptions
- **Be linked**: Cross-reference between Beads and memory bank
- **Update timestamps**: Change "Updated:" dates in memory bank files

## Remember

The goal is to maintain **accurate, comprehensive project tracking** so that:
- Future sessions know exactly what's happening
- Nothing falls through the cracks
- Priorities are clear and up-to-date
- Context is preserved for decision-making
