# Plan Feature

Review the current codebase, analyze the user's request, and create a concise implementation plan.

**Task:** $ARGUMENTS

**Context Intelligence**: In the absence of explicit arguments, consider recent conversation history as context for guiding plan direction. For example, if recent messages discussed switching from alacritty to a simpler terminal launcher, receiving `/plan` with no args should convey: execute something like `/plan my previous instruction which was to reconfigure i3 to use simple term launcher instead of the newer alacritty launcher which has turned out buggier than hoped`.

## Instructions

1. **Quick Code Review**: Briefly examine relevant files to understand current implementation
2. **Request Analysis**: Parse the user's feature request to identify core requirements
3. **Simple Understanding**: Reflect back a clear, concise summary of what needs to be built
4. **File Structure Plan**: Output a readable ASCII tree showing files to create, modify, or delete
5. **Execution Tasks**: Provide a numbered list of specific tasks to execute in order

## Output Format

Present the plan in a conversational, fluid format that naturally weaves together:
- A clear understanding of what needs to be built (2-3 sentences)
- A readable ASCII tree showing the file changes
- A numbered list of specific execution tasks

Avoid rigid section headers like "File Changes" or "Execution Tasks". Instead, flow naturally from understanding → visual structure → concrete steps.

**Example structure:**

```
I'll build [brief description of what's being built]. This involves [key aspects]. Here's how the codebase will change:

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

Here's how we'll execute this:

1. First specific task to complete
2. Second specific task to complete
3. Third specific task to complete
[...continue with numbered, actionable tasks]
```

## Legend
- [C] = Create new file
- [M] = Modify existing file
- [D] = Delete file

Keep descriptions to one line. Focus on the essential file changes and provide clear, actionable execution steps.
