---
name: Feature Planning
description: Create implementation plans for features. Activate when user asks to plan, analyze requirements, design implementation, create a plan, or think through how to build something. Also activate when user provides feature request and wants to understand approach before coding.
allowed-tools: Read, Grep, Glob, Bash
---

# Feature Planning Skill

## When to Use

Activate whenever the user asks to:
- Plan a feature or implementation
- Analyze requirements before coding
- Think through how to build something
- Create an implementation plan
- Review what needs to be done
- Understand the approach for a task
- Design the structure of a feature

## Planning Workflow

### Step 1: Quick Code Review

Briefly examine relevant files to understand current implementation patterns:
- Use Grep to find related code
- Use Read to examine key files
- Identify existing patterns to follow
- Note integration points

**Keep this focused** - spend 2-3 minutes orienting, not hours exploring.

### Step 2: Analyze the Request

Parse the user's feature request to identify:
- Core functionality needed
- User-facing changes
- Backend/API changes
- Data model changes
- Integration points with existing code

### Step 3: Simple Understanding

Reflect back a clear, concise summary (2-3 sentences) of what needs to be built:
- What is the feature?
- Why does it matter?
- What are the key aspects?

### Step 4: File Structure Plan

Output a readable ASCII tree showing files to create, modify, or delete:

```
project-root/
├── src/
│   ├── components/
│   │   ├── [C] NewComponent.tsx - Brief description
│   │   └── [M] ExistingComponent.tsx - Changes needed
│   ├── services/
│   │   └── [M] api.service.ts - API updates
│   └── [D] deprecated/
│       └── OldFile.tsx - Removing obsolete code
└── tests/
    └── [C] NewComponent.test.tsx - Test coverage
```

**Legend:**
- [C] = Create new file
- [M] = Modify existing file
- [D] = Delete file

**Keep descriptions to one line.** Focus on essential changes.

### Step 5: Execution Tasks

Provide a numbered list of specific, actionable tasks to execute in order:

1. First specific task to complete
2. Second specific task to complete
3. Third specific task to complete
[...continue with numbered tasks]

**Make tasks concrete** - not "update the component" but "add dark mode toggle button to SettingsPanel.tsx"

## Output Format

Present the plan in a **conversational, fluid format** that naturally weaves together understanding → visual structure → concrete steps.

**Avoid rigid section headers** like "File Changes" or "Execution Tasks".

**Example:**

```
I'll build a dark mode toggle for the settings page. This involves adding
state management for theme preference, updating the UI with a toggle component,
and applying theme styles across existing components. Here's how the codebase
will change:

src/
├── components/
│   ├── settings/
│   │   ├── [C] DarkModeToggle.tsx - Toggle switch component
│   │   └── [M] SettingsPanel.tsx - Integrate toggle
│   └── [M] Layout.tsx - Apply theme classes
├── context/
│   └── [C] ThemeContext.tsx - Theme state management
└── styles/
    └── [M] globals.css - Dark mode variables

Here's how we'll execute this:

1. Create ThemeContext with light/dark state and localStorage persistence
2. Build DarkModeToggle component with switch UI
3. Integrate toggle into SettingsPanel
4. Update Layout to consume theme context and apply CSS classes
5. Add dark mode CSS variables to globals.css
6. Test theme switching and persistence across page reloads
```

## Best Practices

1. **Context Efficiency**: Don't read entire codebases - use targeted searches
2. **Follow Patterns**: Identify and follow existing architectural patterns
3. **Be Specific**: "Add login form" → "Create LoginForm.tsx with email/password fields and validation"
4. **One-Line Descriptions**: Keep file change descriptions concise
5. **Actionable Tasks**: Each task should be a concrete action, not a vague goal
6. **Natural Flow**: Write plans conversationally, not as rigid templates

## Context Intelligence

If user provides no arguments but recent conversation discussed a task, use that context:
- Review recent messages for implied intent
- Plan based on the most recent feature discussion
- Confirm understanding before diving into details

## Integration with Other Skills

This skill works together with:
- **Coding workflows**: Plans feed into implementation
- **Testing workflows**: Plans should include test tasks
- **Memory Bank**: Plans reference architectural docs when available

## Important Notes

- **Don't over-research**: 2-3 minutes of code review is enough
- **Don't over-plan**: Keep plans concise and actionable
- **Don't guess**: If requirements are unclear, ask before planning
- **Do follow patterns**: Consistency with existing code matters
