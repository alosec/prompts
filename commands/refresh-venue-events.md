---
name: Refresh Venue Events
description: Scrape current events for pedicab512 venue dataset. Query venues by capacity, search web for events, update Supabase.
---

# Refresh Venue Events

Update pedicab512 events dataset by scraping current events for Austin venues.

## Workflow

1. **List venues by priority**
   ```bash
   export SUPABASE_ACCESS_TOKEN=$(cat ~/code/agent-tools/supabase-tools/.env | grep SUPABASE_ACCESS_TOKEN | cut -d= -f2)
   npx supabase db execute -p jhqgctrqhvytujcvitym \
     "SELECT id, name, capacity, events_url FROM venues ORDER BY capacity DESC NULLS LAST"
   ```

2. **For each venue** (biggest first):
   - Search web: `browser-search.js "<venue> events <month> <year>" --content`
   - If venue has events_url, visit it: `browser-nav.js <url>` then `browser-content.js`
   - Extract: event name, date, expected attendance

3. **Update Supabase**
   ```bash
   npx supabase db execute -p jhqgctrqhvytujcvitym \
     "INSERT INTO events (venue_id, name, date, expected_attendance) VALUES (...)"
   ```

## Priority Venues

| Venue | Notes |
|-------|-------|
| Zilker Park | Trail of Lights (Dec), ACL Fest (Oct) |
| Circuit of the Americas | F1, MotoGP, concerts |
| Moody Center | UT arena, major concerts |
| ACL Live | Moody Theater |
| Stubb's | Outdoor concerts |

## December 2025 Focus

- Trail of Lights at Zilker (runs through Dec 23)
- Holiday events downtown
- NYE events

## Browser Setup

```bash
# Ensure Chrome running in tmux
tmux new-session -d -s browser 'DISPLAY=:9 browser-start.js --profile'
```

## Example Session

```bash
# 1. Search for Zilker events
browser-search.js "Zilker Park Trail of Lights December 2025" --content | head -50

# 2. Visit official page
browser-nav.js "https://austintrailoflights.org"
browser-content.js | head -100

# 3. Extract dates, capacity, tickets
# ... parse and insert to Supabase
```

## Related

- ABG-168: Refresh pedicab512 venue events dataset
- ~/code/pedicab512/
- Supabase project: jhqgctrqhvytujcvitym
