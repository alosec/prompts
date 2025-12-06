---
name: Linear CLI (linearis)
description: Linear issue tracking via CLI. Use workspace-specific aliases.
---

# Linear CLI Usage

## Multi-Workspace Setup

Alex has multiple Linear workspaces. **Always use workspace-specific aliases:**

| Alias | Workspace | Use For |
|-------|-----------|---------|
| `linearis-abg` | ABG-personal | Personal tracking, canonical issue system |
| `linearis-work` | Ideaflow | Work/contract tasks |
| `linearis-psyt` | PsyTexas | PsyTexas org tasks |

**Bare `linearis` will prompt for workspace selection** - it does not default to any workspace.

## Workflow Philosophy

- **ABG is canonical**: Most issues live in ABG-personal
- **Mirror to project workspace**: Create corresponding issues in project-specific workspaces when needed
- **Cross-reference**: Link issues across workspaces in descriptions

## Common Commands

```bash
# List issues
linearis-abg issues list

# Create issue (team required)
linearis-abg issues create "Title" -d "Description" -p 2 --team c656e080-8191-44ba-9912-f45688a1ec5f

# Read issue details
linearis-abg issues read ABG-40

# Update issue
linearis-abg issues update ABG-40 --state Done
linearis-abg issues update ABG-40 --title "New title" -p 1

# Search
linearis-abg issues search "linear api"

# Add comment
linearis-abg comments create ABG-40 --body "Resolution notes here"

# List teams (to get team IDs)
linearis-abg teams list

# List projects
linearis-abg projects list
```

## Team IDs (ABG-personal)

- Abg-personal: `c656e080-8191-44ba-9912-f45688a1ec5f`

## Priority Levels

1 = Urgent, 2 = High, 3 = Medium, 4 = Low, 0 = None

## Issue States

Common states: `Backlog`, `Todo`, `In Progress`, `Done`, `Canceled`

## Linear Tools (Supplements linearis)

For mutations linearis doesn't support, use `~/code/agent-tools/linear-tools/`:

```bash
# Project CRUD
linear-project-create.js "Name" --team <id>
linear-project-list.js
linear-project-read.js <id>
linear-project-update.js <id> --name "New name"
linear-project-delete.js <id>

# Document CRUD
linear-docs-create.js "Title" --content "..."
linear-docs-list.js
linear-docs-read.js <id>
linear-docs-update.js <id> --content "..."
linear-docs-delete.js <id>
```

## Token Configuration

Tokens stored in `/etc/linear/tokens.env`. Both `alex` and `alex-work` users source this file.

**Mew bot uses its own token** via `.env` in the project directory - separate from these CLI aliases.

## GraphQL Introspection

To discover API fields:
```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Authorization: $LINEAR_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"query": "{ __type(name: \"IssueCreateInput\") { inputFields { name description } } }"}' | jq
```
