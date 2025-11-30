---
name: Timesheet
description: Update Ideaflow timesheet hours. Activate when user mentions timesheet, hours, billing, work log, submit hours, end of month, mid month, or time tracking.
---

# Timesheet Skill

Update and manage Ideaflow contractor timesheets.

## Key Locations

- **Timesheet JSON files:** `/home/user/code/ag-work-log/timesheets/`
  - `2025-11-mid-month.json` - First half of month (1st-15th)
  - `2025-11-end-month.json` - Second half of month (16th-end)
- **Timesheet viewer:** `/home/user/code/work-log-site/src/pages/timesheet/[period].astro`
- **Template reference:** `/home/user/code/ag-work-log/memory-bank/timesheet-template.md`

## JSON Structure

```json
{
  "period": "November 2025 (End-Month)",
  "submittedOn": "2025-11-29",
  "employee": {
    "name": "Alexander Garcia",
    "businessEntity": "N/A",
    "email": "user@example.com",
    "address": "1507 Canterbury St, Austin, TX 78702"
  },
  "dates": [
    {
      "date": "2025-11-18",
      "day": "Mon",
      "project": "Mew",
      "hours": 4,
      "notes": "Description of work"
    }
  ],
  "billingRate": 35.00
}
```

## Commit Sources for Hour Estimation

Check these repos for work evidence:

```bash
# Main Mew repo
cd ~/code/ideaflow/mew && git log --since="DATE" --format="%ai | %s"

# Mew MCP tools
cd ~/code/ideaflow/mew-mcp && git log --since="DATE" --format="%ai | %s"

# Slack bot work (work-user user)
sudo -u work-user git -C /home/work-user/code/pi-mono log --since="DATE" --format="%ai | %an | %s" | grep -i alex

# Slack MCP server
sudo -u work-user git -C /home/work-user/code/slack-mcp-server log --since="DATE" --format="%ai | %an | %s"
```

## Timezone Note

Commits in UTC. Late night UTC (e.g., 05:00 UTC) = previous day US time.

## Submission

- **Email:** redacted@ideaflow.io
- **Deadline:** Mid-month before 12pm PST
- **View rendered:** `work-log-site` generates printable timesheet pages

## Workflow

1. Check commit history across repos to estimate hours
2. Ask user to confirm/correct hours for days without commits
3. Update the appropriate JSON file in `ag-work-log/timesheets/`
4. Update `submittedOn` date when finalizing
