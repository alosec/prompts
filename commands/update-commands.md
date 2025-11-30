# Custom Command Management

Handle CRUD operations for custom Claude commands in project `.claude/commands/` directory.

## Commands Directory Context
- **Project Location**: `.claude/commands/` (project-specific commands)
- **Global Location**: `~/.claude/commands/` (universal commands)
- **Format**: Markdown files containing command prompts
- **Naming**: `[command-name].md` maps to `/[command-name]` usage

## Available Operations

### CREATE
Create new command file with specified prompt content.

### READ  
Display existing command file contents.

### UPDATE
Modify existing command prompt or description.

### DELETE
Remove command file from directory.

### LIST
Show all available custom commands in current scope.

### MOVE
Move command between project and global scope.

## Command File Structure
- Filename: `[name].md`
- Content: Prompt text executed when `/[name]` is used
- Variables: Use `$ARGUMENTS` for dynamic input
- Format: Plain markdown with clear instructions

## Operation Guidelines

### For Command Files:
- **CREATE**: Requires name and prompt content
- **READ**: Display file contents for review
- **UPDATE**: Modify existing command prompts
- **DELETE**: Remove unused command files
- **LIST**: Show directory contents
- **MOVE**: Transfer between project and global directories

## Scope Management
- **Project Commands**: Located in `.claude/commands/` (project root)
- **Global Commands**: Located in `~/.claude/commands/` (user home)
- **Priority**: Project commands override global commands with same name
- **Access**: Global commands available everywhere; project commands only in project context

## User Request Processing
Based on $ARGUMENTS, determine the appropriate operation:

1. **Parse Action**: CREATE, READ, UPDATE, DELETE, LIST, or MOVE
2. **Identify Target**: Command name and parameters
3. **Determine Scope**: Project vs global directory
4. **Execute Operation**: File system operations in appropriate directory
5. **Provide Feedback**: Confirm changes and show results

Process this request: $ARGUMENTS