# Subagent Management Command

Comprehensive CRUD operations for managing Claude Code subagents in both global (`~/.claude/agents/`) and project (`.claude/agents/`) directories.

## Available Operations

### CREATE
Create new subagent with specialized configuration:
- **Name**: Agent identifier for `/launch [name]` usage
- **Description**: When this agent should be invoked
- **Tools**: Optional tool restrictions (inherits all if omitted)
- **Prompt**: Specialized system instructions

### READ
Display existing subagent configuration and capabilities.

### UPDATE
Modify existing subagent:
- Update system prompt
- Change tool access
- Modify description/trigger conditions

### DELETE
Remove subagent from directory.

### LIST
Show all available subagents in current scope with descriptions.

### MOVE
Transfer subagent between project and global scope.

## Subagent File Structure

```markdown
---
name: agent-name
description: Clear description of when this agent should be invoked
tools: tool1, tool2, tool3  # Optional - inherits all tools if omitted
---

System prompt and specialized instructions for this agent.
Include specific expertise, behavioral guidelines, and output requirements.
```

## Core Agent Definitions

The seven core agents following OODA Loop methodology:

- **analyzing** - Deep codebase analysis, pattern recognition (OBSERVE)
- **researching** - External knowledge gathering, web research (OBSERVE)  
- **documenting** - Documentation, memory management, chat history analysis (ORIENT)
- **planning** - Strategic coordination, mandatory approval gates (DECIDE)
- **versioning** - Git workflow, version control, GitHub operations (ACT)
- **testing** - Quality assurance, validation workflows (ACT)
- **coding** - Implementation execution (ACT)

## Scope Management
- **Global Agents**: `~/.claude/agents/` (available everywhere)
- **Project Agents**: `.claude/agents/` (project-specific, takes precedence)
- **Priority**: Project agents override global agents with same name

## Usage Examples

### Create New Agent
- Name: `security-audit`
- Description: "Security vulnerability analysis and recommendations"
- Tools: `Read, Grep, Glob, WebSearch`
- Prompt: Security-focused analysis instructions

### Update Existing Agent
- Modify `documenting` agent to include chat history analysis
- Add SQLite tool access for database queries
- Update prompt with specific chat history instructions

### List Available Agents
Show all agents with their descriptions and tool access.

Please specify the operation you'd like to perform and any relevant parameters.