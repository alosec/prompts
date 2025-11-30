# Conversation History Review Command

Analyze conversation history from Claude Code's SQLite database to understand context, track decisions, and identify patterns across sessions.

## Database Context
- **Location**: `~/.local/share/cafe-db/claude_code.db`
- **Key Tables**: sessions, messages, tool_uses, tool_use_results, attachments
- **Purpose**: Track conversation evolution, decisions, and development patterns

## Command Usage

### Basic Patterns:
- `/history-review keywords [terms]` - Search for specific keywords across conversations
- `/history-review recent [number]` - Review recent sessions (default: 3)
- `/history-review session [session-id]` - Deep dive into specific session
- `/history-review pattern [topic]` - Track evolution of specific topics/features
- `/history-review decisions [timeframe]` - Extract key decisions and their context

### Advanced Analysis:
- `/history-review compare sessions [id1] [id2]` - Compare approaches across sessions
- `/history-review timeline [topic]` - Show chronological development of features  
- `/history-review context [current-task]` - Find relevant past context for current work

## Instructions for Claude

When this command is invoked:

1. **Parse Arguments**: Determine search type and parameters from user input
2. **Database Query**: Use sqlite3 to query `~/.local/share/cafe-db/claude_code.db`
3. **Context Analysis**: Extract relevant conversations, decisions, and patterns
4. **Synthesize Findings**: Provide actionable insights for current development

### Query Patterns:

**Keyword Search:**
```sql
SELECT sessionId, userText, assistantText, timestamp 
FROM messages 
WHERE (userText LIKE '%keyword%' OR assistantText LIKE '%keyword%')
ORDER BY timestamp DESC;
```

**Recent Sessions:**
```sql
SELECT sessionId, sessionPath, created 
FROM sessions 
ORDER BY created DESC 
LIMIT [number];
```

**Session Deep Dive:**
```sql
SELECT userText, assistantText, timestamp, type
FROM messages 
WHERE sessionId = '[session-id]'
ORDER BY timestamp;
```

**Pattern Tracking:**
```sql
SELECT sessionId, userText, assistantText, timestamp
FROM messages 
WHERE (userText LIKE '%[pattern]%' OR assistantText LIKE '%[pattern]%')
ORDER BY timestamp;
```

### Output Format:

Provide structured analysis:

1. **Summary**: Brief overview of findings
2. **Key Insights**: Important decisions or patterns discovered  
3. **Relevant Context**: Specific conversations/decisions relevant to current work
4. **Recommendations**: How past insights should inform current development
5. **Timeline**: If applicable, show evolution of topics over time

### Examples:

**`/history-review keywords emoji mosaic`**
- Search all conversations mentioning "emoji" or "mosaic"
- Identify design decisions and user feedback
- Track evolution from original vision to current implementation

**`/history-review recent 5`**  
- Review last 5 conversation sessions
- Summarize key activities and decisions
- Highlight any unfinished tasks or ongoing themes

**`/history-review pattern theme-system`**
- Track all conversations about theme system development
- Show progression from initial dropdown to current 8-theme system
- Identify user preferences and technical decisions

## Important Notes:

- Always respect privacy - analyze patterns, not personal details
- Focus on development decisions, technical choices, and feature evolution
- Provide actionable insights that inform current development
- If database is unavailable or queries fail, explain limitations clearly
- Use findings to prevent repeating past mistakes or rediscovering solutions

This command enables systematic analysis of conversation history to make better-informed development decisions based on past context and user feedback patterns.