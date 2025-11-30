---
name: Quiet Deploy
description: Use filtered deploy command to reduce context usage. Activate when deploying to Cloudflare Pages, publishing the site, or pushing to production.
allowed-tools: Bash
---

# Quiet Deploy

## When to Use
Activate whenever the user asks to:
- Deploy the project
- Publish to Cloudflare Pages
- Push to production
- Run wrangler deploy
- Deploy the build

## Instructions

Always use the quiet deploy command pattern that filters output to show only essential information:

```bash
wrangler pages deploy dist/ 2>&1 | grep -E "(https://.*\.pages\.dev|Deployment complete|Success)"
```

### Why This Matters
- Reduces context usage significantly
- Shows only deployment URL and success status
- Prevents context window pollution with verbose upload logs
- Maintains fast response times
- Makes it easy to see the deployed URL

### What Gets Shown
- Deployment URL (https://*.pages.dev)
- Completion confirmation
- Success messages
- Upload summary

### What Gets Filtered
- Individual file upload progress
- Detailed asset processing logs
- Non-critical informational messages
- Verbose wrangler output

## Timeout
Always set a 120000ms (2 minute) timeout for deploy commands.

## Note on Feature Branch Deployments
When deploying from a feature branch, Cloudflare Pages creates:
- A unique hash URL: `https://[hash].your-project.pages.dev`
- A branch alias: `https://feature-[branch-name].your-project.pages.dev`

The quiet command will show the hash URL in the filtered output.
