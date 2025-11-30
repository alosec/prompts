# Update CLAUDE.md

Update CLAUDE.md files with current context, patterns, and development insights.

## Scope Detection

The command automatically detects which CLAUDE.md file to update based on context:

- **Project-specific**: Update `.claude/CLAUDE.md` or `CLAUDE.md` in project root
- **Global**: Update `~/.claude/CLAUDE.md` (user-wide configuration)
- **Explicit**: Use `$ARGUMENTS` to specify scope (e.g., "global" or "project")

## Instructions

Review and update the appropriate CLAUDE.md file to reflect:

1. **Current Project State**: Update architecture, file structure, and component organization
2. **Development Patterns**: Document new patterns discovered during development
3. **Technical Decisions**: Record important technical choices and their rationale
4. **Workflow Updates**: Refresh deployment flows, testing procedures, and development practices
5. **Known Issues**: Document current bugs, limitations, or areas needing attention
6. **Dependencies**: Update library versions, new tools, or configuration changes

## Update Process

1. **Determine Scope**: Check $ARGUMENTS for "global" or detect project context
2. **Read Existing File**: Load current CLAUDE.md content from appropriate location
3. **Analyze Changes**: Review recent developments in project or global workflows  
4. **Update Content**: Reflect current reality in relevant sections
5. **Add New Sections**: Document emerging patterns or tools
6. **Remove Outdated Info**: Clean up obsolete information
7. **Ensure Clarity**: Make file useful for future development

## Focus Areas

### For Project-Specific CLAUDE.md:
- Architecture and component structure
- Development workflow and deployment process
- Technical decisions and their reasoning
- Known issues and workarounds
- Dependencies and configuration
- Project-specific patterns and conventions

### For Global CLAUDE.md:
- Universal development principles
- Cross-project workflows and standards
- Global tool configurations
- General coding standards and practices
- Memory bank structure and usage
- Agent and command management

## Usage Examples

```bash
# Update project-specific CLAUDE.md
/update-claude-md

# Update global CLAUDE.md explicitly  
/update-claude-md global

# Update project CLAUDE.md with specific focus
/update-claude-md project focus on recent architecture changes
```

The command makes the appropriate file a useful reference for understanding current state and development approach.