# Prompts

A collection of prompt templates for AI-assisted development workflows. Includes agents, commands, and skills for Claude Code and other AI coding assistants.

## Directory Structure

```
prompts/
├── agents/          # Agent role definitions (planning, testing, research, etc.)
├── commands/        # Workflow commands (/plan, /act, /chart, etc.)
├── skills/          # Domain-specific knowledge (testing, deployment, etc.)
└── legacy/          # Original claude-desktop and cline instructions
    ├── claude-desktop/
    └── cline/
```

## Agents

Role definitions for specialized tasks:

- **planning-agent** - Complex planning with codebase analysis
- **testing-agent** - E2E testing with Playwright (token-efficient)
- **coding-agent** - Implementation with isolated tracking
- **analysis-agent** - Deep multi-file investigation
- **research-agent** - Web searches for examples
- **reference-agent** - Library source code analysis

## Commands

Workflow commands for development cycles:

| Command | Purpose |
|---------|---------|
| `/prepare` | Load context (memory bank + git + issues) |
| `/plan` | Create implementation plan with file tree |
| `/elaborate` | Get file-level implementation details |
| `/act` | Execute the plan systematically |
| `/chart` | Update tracking systems (close the loop) |
| `/research` | Research a topic with web search |
| `/navigate` | Codebase navigation helper |

Plus 40+ more commands for git, GitHub issues, deployment, etc.

## Skills

Domain-specific knowledge that auto-activates based on task:

- **planning** - Feature planning with execution tasks
- **testing** - E2E testing workflow with deployment
- **quiet-build** - Filtered build output (reduces context noise)
- **quiet-deploy** - Filtered deploy output
- **playwright-cli** - Browser automation patterns
- **slack-agents** - Slack bot development
- **vnc-tunnel** - Remote GUI automation
- And more...

## Usage

Reference prompts directly in your AI assistant:

```bash
# With pi coding agent
pi @~/code/prompts/commands/plan.md "add user authentication"

# Or copy to your preferred location
cp -r prompts/* ~/.prompts/
```

## Legacy

The `legacy/` directory contains the original Claude Desktop and Cline instruction sets that informed the evolution of these patterns. Preserved for reference.

## License

MIT
