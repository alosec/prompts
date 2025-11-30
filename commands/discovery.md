# Analyze and Plan Command

You are tasked with comprehensive analysis and planning for a feature request. Use 1-4 subagents to thoroughly examine the codebase and develop implementation strategy.

## Input Parameters
- **Feature Request**: $ARGUMENTS (first part - the feature to implement)
- **Analysis Dimensions**: $ARGUMENTS (second part - areas of codebase to examine)

## Task Execution

### Phase 1: Analysis
Deploy subagents to analyze relevant codebase dimensions:
- Architecture patterns and existing implementations
- Related components, utilities, and data structures  
- Integration points and dependencies
- Technical constraints and considerations

### Phase 2: Planning
Based on analysis findings, develop comprehensive implementation plan:
- Break down feature into specific tasks
- Identify required changes and new components
- Plan integration with existing systems
- Consider testing and validation requirements

## Execution Notes
- Use Task tool for comprehensive codebase analysis
- Deploy multiple subagents when examining complex systems
- Focus on understanding before planning
- If feature request or analysis dimensions are ambiguous, ask for clarification in Next Action section

## Response Format

Structure your response exactly as:

## Understanding
- Clear interpretation of the feature request
- Key requirements and acceptance criteria
- Potential ambiguities or clarification needs
- Scope boundaries and assumptions

## Context
Present relevant files as a tree structure showing:
- File paths and their relationships
- Brief description of each file's role
- How each relates to the planned implementation
- Priority order for implementation work

## Next Action
- Specific next steps to begin implementation
- Immediate tasks and their sequence
- Files to create or modify first
- Any clarifications needed before proceeding