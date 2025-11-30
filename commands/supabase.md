# Supabase Project Management

Manage both pedicalendar_v2 and events-manager Supabase projects using MCP server integration for database operations, schema management, and development workflow.

## Usage
`/supabase [operation] [args]`

## Project Context Detection

The command automatically detects the current project and adapts operations accordingly:

- **pedicalendar_v2**: Calendar events for Austin pedicab drivers
  - Project ID: `jhqgctrqhvytujcvitym`
  - Database: Simple events/venues schema (single-tenant)
  - ~351 events, ~21 venues
  
- **events-manager**: Business intelligence for Example Org
  - Project ID: [Auto-detected from project]
  - Database: Single-tenant business events for Example Org
  - Business focus: Non-profit LLC event management

## Available Operations

### Project Setup
```bash
# Check current project status
/supabase status

# List all projects
/supabase projects

# Get current project details
/supabase project

# Switch project context (if needed)
/supabase context [pedicalendar_v2|events-manager]
```

### Database Management
```bash
# List all tables
/supabase tables

# Show table schema
/supabase schema [table_name]

# Run SQL query (context-aware)
/supabase sql "SELECT * FROM events LIMIT 10"

# Apply migration
/supabase migrate [migration_name]
```

### Development Workflow
```bash
# Set up database schema from memory-bank
/supabase setup-schema

# Create sample data for testing
/supabase seed-data

# Generate TypeScript types
/supabase generate-types

# Check database health
/supabase health-check
```

### Data Operations

#### Pedicalendar_v2 Context
```bash
# List events by date
/supabase sql "SELECT title, date, venue FROM events WHERE date >= CURRENT_DATE ORDER BY date LIMIT 10"

# Check venue statistics
/supabase sql "SELECT venue, COUNT(*) as event_count FROM events GROUP BY venue ORDER BY event_count DESC LIMIT 10"

# Get upcoming events
/supabase sql "SELECT e.title, e.date, e.venue, v.priority FROM events e LEFT JOIN venues v ON e.venue = v.title WHERE e.date >= CURRENT_DATE ORDER BY e.date"
```

#### Events-Manager Context
```bash
# List Example Org events
/supabase sql "SELECT title, start_time, category FROM events WHERE start_time >= CURRENT_DATE ORDER BY start_time LIMIT 10"

# Check event categories
/supabase sql "SELECT category, COUNT(*) as event_count FROM events GROUP BY category ORDER BY event_count DESC"

# Get business analytics
/supabase sql "SELECT DATE_TRUNC('month', start_time) as month, COUNT(*) as events FROM events GROUP BY month ORDER BY month"
```

### Schema Operations
```bash
# Apply full schema from memory-bank
/supabase apply-schema

# Create missing tables
/supabase create-tables

# Set up indexes for performance
/supabase create-indexes

# Validate schema integrity
/supabase validate-schema
```

## MCP Integration Notes

This command leverages the Supabase MCP server configured in `.mcp.json` to:
- Execute SQL queries with project-specific context
- Manage database schema and migrations
- Generate TypeScript types from schema
- Validate data integrity and performance
- Handle project-specific business logic

## Project-Specific Features

### Pedicalendar_v2
- **Single-tenant calendar**: Events and venues for Austin pedicab drivers
- **No business_id scoping**: Direct table access
- **Schema focus**: Events, venues, time calculations
- **Key queries**: Date ranges, venue statistics, shift timeframes

### Events-Manager  
- **Single-tenant business**: Example Org non-profit event management
- **No multi-tenant architecture**: Direct business data access
- **Schema focus**: Events, categories, business intelligence
- **Key queries**: Event analytics, category breakdowns, business metrics

## Security Reminders

- Use read-only mode for exploration
- Validate queries before execution
- Check project context before operations
- Backup before schema changes

## Context-Aware Examples

### Auto-Detection Usage
```bash
# The command detects your current project automatically
cd /home/user/code/repos/pedicalendar_v2
/supabase sql "SELECT COUNT(*) FROM events"  # Uses pedicalendar_v2 project

cd /home/user/code/repos/events-manager  
/supabase sql "SELECT COUNT(*) FROM events"  # Uses events-manager project
```

### Common Operations
```bash
# Set up complete database schema for current project
/supabase apply-schema

# Health check for current project
/supabase health-check

# Generate TypeScript types for current project
/supabase generate-types

# Quick event overview for current project
/supabase sql "SELECT title, date FROM events WHERE date >= CURRENT_DATE ORDER BY date LIMIT 5"
```

## Troubleshooting

- **Project not detected**: Check you're in the correct project directory
- **Connection issues**: Verify MCP server configuration in `.mcp.json`
- **Schema errors**: Ensure memory-bank/schema.md exists and is current
- **Permission errors**: Check Supabase project permissions and API keys