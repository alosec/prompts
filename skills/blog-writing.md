---
name: Blog Writing
description: Write blog posts for your-blog.com. Activate when user mentions blog, blog post, write article, publish post, your-blog, or wants to document/share a technical pattern.
allowed-tools: Read, Write, Edit, Glob, Bash
---

# Blog Writing for your-blog.com

Write technical blog posts in a minimalist, direct style for Your personal blog.

## Blog Location

```
~/code/your-blog/src/content/blog/
```

## Post Format

All posts use MDX with YAML frontmatter:

```mdx
---
title: "Your Post Title"
description: "Brief 1-2 sentence description"
pubDate: 2025-11-22  # YYYY-MM-DD format
tags: ["tag1", "tag2", "tag3"]
draft: true  # Set false when ready to publish
---

Content here...
```

## File Naming

Use kebab-case slug that matches the topic:
- `vnc-playwright-oauth-bypass.mdx`
- `claude-code-workflow-commands.mdx`
- `supabase-edge-function-debugging.mdx`

## Writing Style

**This blog has an austere minimalism aesthetic. Follow these guidelines:**

### Tone
- Direct and practical, not fluffy
- Technical but accessible
- First person when sharing experience
- No excessive enthusiasm or marketing speak

### Structure
- **Hook first** - Start with the problem or insight
- **Show the solution** - Code, diagrams, concrete examples
- **Explain why** - The reasoning behind the approach
- **Acknowledge limits** - What doesn't work, edge cases
- **Short conclusion** - Key takeaway, not a recap

### Formatting
- Short paragraphs (2-4 sentences)
- Liberal use of code blocks with syntax highlighting
- ASCII diagrams for architecture (no images unless necessary)
- Bullet points for lists, not numbered unless order matters
- Use `inline code` for technical terms, commands, file paths

### What to Avoid
- Long introductions explaining why the topic matters
- "In this post, we will..."
- Excessive headers/subheaders
- Marketing language ("game-changer", "revolutionary")
- Over-explaining basics (assume technical reader)

## Components Available

### WikiTooltip
For inline term explanations:

```mdx
<WikiTooltip term="CDP" info="Chrome DevTools Protocol - the interface Playwright uses to control browsers" url="https://chromedevtools.github.io/devtools-protocol/" />
```

## Workflow

### Creating a New Post

```bash
# Copy template
cp ~/code/your-blog/src/content/blog/_template.mdx ~/code/your-blog/src/content/blog/your-post-slug.mdx

# Or just create fresh file with proper frontmatter
```

### Preview Locally

```bash
cd ~/code/your-blog
npm run dev
# Opens at localhost:4321
```

### Publishing

1. Set `draft: false` in frontmatter
2. Commit and push
3. Site auto-deploys (Cloudflare Pages or similar)

## Common Tags

Use existing tags when possible:
- `claude-code` - Claude Code features, workflows
- `playwright` - Browser automation
- `automation` - General automation patterns
- `supabase` - Supabase-related
- `astro` - Astro framework
- `devtools` - Developer tooling

## Example Post Structure

```mdx
---
title: "Solving X with Y"
description: "How to do X when Y is your constraint."
pubDate: 2025-11-22
tags: ["relevant", "tags"]
draft: true
---

## The Problem

[2-3 sentences on what you're trying to solve]

## The Solution

[Core insight or approach in 1-2 sentences]

### Setup

[Code/steps to get started]

### The Workflow

[Main content with examples]

## Why This Works

[Brief explanation of underlying mechanics]

## The Limits

[Honest assessment of edge cases, what doesn't work]

## Conclusion

[One key takeaway - single sentence or short paragraph]
```
