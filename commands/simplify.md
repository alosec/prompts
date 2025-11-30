# Simplify Command

This command pairs with `/plan` and `/elaborate` to reduce complexity and provide streamlined implementation approaches.

**Usage**: `/simplify [context]`

## Instructions:
When the user runs `/simplify`, analyze the most recent plan or elaborate details and provide simplified alternatives that reduce complexity while maintaining core functionality.

For each suggested simplification, explain:
- What complexity can be removed or reduced
- Simpler alternative approaches or patterns
- Trade-offs and what functionality might be sacrificed
- Which files/changes could be eliminated entirely

Focus on:
- Removing unnecessary abstractions
- Consolidating similar functionality
- Using simpler patterns or existing solutions
- Reducing file count and code volume
- Eliminating edge cases or advanced features

Keep suggestions to 1-2 sentences per simplification. Be pragmatic about trade-offs.

Example format:
```
Simplification 1: Single Component Approach
- Merge Header.tsx and ViewToggle.tsx into one component, eliminating prop drilling
- Trade-off: Less reusable but simpler to maintain

Simplification 2: CSS-Only Solution  
- Replace JavaScript toggle with pure CSS media queries or :checked pseudo-class
- Trade-off: Less dynamic but no state management needed

Simplification 3: Remove Feature Entirely
- Skip multi-view toggle, use single timeline view only
- Trade-off: Less flexibility but eliminates 3 files and all toggle logic
```

Arguments: $ARGUMENTS (use this for any specific context about what should be simplified)