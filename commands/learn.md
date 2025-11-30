# Learn from Chat History

Search Claude Code's own chat history database to extract workflow insights and patterns from previous sessions.

## Database Location
`/home/user/.local/share/cafe-db/claude_code.db`

## Instructions

Use SQLite to query the chat history database for relevant information based on the current context or specific keywords. This command helps recover important workflow insights, deployment patterns, and technical solutions from previous conversations.

## Query Strategies

### Targeted Keyword Search
When looking for specific information:
- Search message content for exact terms (e.g., "Cloudflare Pages", "deployment", "wrangler")
- Filter by recent conversations for current workflows
- Look for command patterns and technical solutions

### Breadth-First Discovery
When exploring general patterns:
- Query recent conversations for common workflows
- Identify frequently used commands and tools
- Extract deployment and development patterns

## Database Schema
Examine the database structure first to understand available tables and columns, then craft appropriate queries to find:
- Deployment workflows and commands
- Configuration patterns
- Problem-solving approaches
- Tool usage patterns

## Purpose
This command exists because valuable workflow insights often emerge during active development sessions. Many effective patterns and solutions exist in previous conversations but become lost without systematic retrieval. The goal is to surface latent knowledge and maintain continuity of effective workflows across sessions.

## Usage Context
Particularly useful for:
- Recovering deployment procedures
- Finding previously working command sequences
- Understanding project evolution and decisions
- Maintaining workflow consistency across sessions