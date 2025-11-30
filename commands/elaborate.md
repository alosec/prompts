# Elaborate Command

This command pairs with `/plan` to provide specific file-level implementation details.

**Usage**: `/elaborate [plan-context]`

## Instructions:
When the user runs `/elaborate`, provide VERY BRIEF explanations of the specific changes needed for each file mentioned in the most recent plan. Focus on concrete modifications rather than high-level strategy.

For each file, explain:
- What specific lines/sections need modification
- What exact content gets added/removed/changed
- Key implementation details (function names, CSS properties, etc.)

Keep explanations to 1-2 sentences per file. Be concrete and actionable.

Example format:
```
src/components/Header.tsx:
- Add `showToggle: boolean` prop, conditionally render ViewToggle with `{showToggle && <ViewToggle />}`

src/styles/main.css:
- Add `.timeline-only { display: block; }` and `.multi-view { display: none; }` classes

config/settings.ts:
- Set `MULTI_VIEW_ENABLED = false` constant, export for component consumption
```

Arguments: $ARGUMENTS (use this for any specific context about the plan being elaborated)