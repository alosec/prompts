---
name: Wix Payments Report
description: Download Wix payments report via Playwright automation. Activate when user mentions wix payments, wix report, psyt payments, download payments, payment export, or wix sales data.
allowed-tools: mcp__playwright__browser_navigate, mcp__playwright__browser_click, mcp__playwright__browser_snapshot, mcp__playwright__browser_wait_for, mcp__playwright__browser_run_code, Bash
---

# Wix Payments Report Automation

This skill automates downloading payment reports from Wix for the ExampleSite site.

## Prerequisites

- **Host**: your-server (DigitalOcean droplet)
- **Session state file**: `/home/user/wix-auth.json` (contains Google + Wix auth cookies)
- **VNC server** running on display :1 (`vncserver :1 -geometry 1280x800 -depth 24`)
- **Playwright MCP** configured with headed browser:
  - Must have `"env":{"DISPLAY":":1"}` in MCP config
  - Must have `--browser chrome` argument
  - Config is in `~/.bashrc` `cndsp` alias (inline `--mcp-config` overrides `~/.claude.json`)

## Site Details

- **Site ID**: `your-site-id`
- **Site Name**: ExampleSite
- **URL**: https://www.example.com/
- **Payments Dashboard**: https://manage.wix.com/dashboard/your-site-id/payments-dashboard

## VNC Setup (if needed)

```bash
# Start VNC server
vncserver :1 -geometry 1280x800 -depth 24

# SSH tunnel from local machine
ssh -L 5901:localhost:5901 user@your-server

# Connect via VNC client to localhost:5901
```

## Automation Steps

### 1. Navigate to Payments Dashboard

```
mcp__playwright__browser_navigate to:
https://manage.wix.com/dashboard/your-site-id/payments-dashboard
```

### 2. Handle Auth (if session expired)

If redirected to login:
1. User must manually complete Google OAuth in VNC
2. Save new session: `mcp__playwright__browser_run_code` with `page.context().storageState({ path: '/home/user/wix-auth.json' })`

### 3. Close Popups

Wix often shows popups on first load. Look for close buttons (X) or "Got it" buttons.

### 4. Set Date Range to "All Time"

1. Take snapshot to find current state
2. Click the date range button (shows "Today" or "All time")
3. Select "All time" from the dropdown listbox

### 5. Download Report

1. Click `button "download button"` (has download icon, ref will vary)
2. Wait for download - snapshot will show "Downloaded file payments.csv to ..."
3. File lands in: `/home/user/code/.playwright-mcp/payments.csv`

## Key Element References (refs change between sessions - always take snapshot first)

- **Date range button**: Button showing current range text ("Today", "All time", etc.)
- **All time option**: `option "All time"` in dropdown listbox
- **Download button**: `button "download button"` in toolbar area
- **Filter button**: `button "Filter"` for additional filtering
- **Close popup**: Look for `button` with X or close icon

## CSV Output

**Location**: `/home/user/code/.playwright-mcp/payments.csv`

**Key columns**:
- Payment Date, Transaction Date, Currency, Amount, Processing Fee, Net
- Transaction Status, Payment Type, Payment Provider, Payment Method
- First Name, Last Name, Email, Phone (billing)
- Order Type, Order ID, Product Name, Quantity
- Subscription fields: Billing Cycle, Frequency, Status

## Integration with example-finance-dash

The downloaded CSV can be imported to `~/code/example-finance-dash`:
- **Option A**: Playwright upload via dashboard UI
- **Option B**: Direct Supabase insert (parse CSV, call Supabase client)

## Troubleshooting

- **Browser not visible in VNC**: Check DISPLAY env is set, restart Claude Code
- **Auth redirect loop**: Session expired, re-authenticate manually via VNC
- **Download not appearing**: Check `/home/user/code/.playwright-mcp/` directory
- **Popups blocking UI**: Always snapshot first and close any modals
