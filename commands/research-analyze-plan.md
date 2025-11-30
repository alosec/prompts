# Research-Analyze-Plan Command

Execute comprehensive research, codebase analysis, and plan formation through consecutive specialized agents to produce actionable development insights.

**Task:** $ARGUMENTS

## Command Flow

This command orchestrates three consecutive agent phases:

### Phase 1: Research Agent
**Web Research Workflow:**
- Deploy 2-3 specialized subagents for parallel investigation
- Use WebSearch and web scraping tools to gather information
- Search for: current best practices, existing solutions, technical approaches, implementation patterns
- Focus areas: technology choices, architecture patterns, performance considerations, security implications
- Validate findings across multiple authoritative sources
- **Input**: User's request/topic
- **Output**: Structured findings with specific URLs, key insights, and technology recommendations

**Research Agent Instructions:**
```
1. Break down the topic into 2-3 research angles
2. Deploy Task agents with WebSearch capabilities
3. Search for: "[topic] best practices", "[topic] implementation guide", "[topic] architecture patterns"
4. Gather information from: official documentation, technical blogs, GitHub repos, Stack Overflow
5. Consolidate findings into structured format with actual URLs
6. Focus on: What technologies to use, How to implement, Common pitfalls to avoid
```

### Phase 2: Analysis Agent  
**Codebase Analysis Workflow:**
- Examine existing codebase structure and patterns
- Use Read, Glob, and Grep tools to understand current implementation
- Identify relevant files, modules, and architectural decisions
- Map research findings to existing code structure and identify integration points
- Assess current capabilities and gaps that need to be filled
- **Input**: Research results + user's request focus
- **Output**: Technical analysis of current state and integration approach

**Analysis Agent Instructions:**
```
1. Use Glob to find relevant files matching the topic (e.g., "**/*auth*", "**/*api*")
2. Use Grep to search for existing implementations related to the topic
3. Read key configuration files and main modules to understand architecture
4. Identify: Current patterns, Existing dependencies, Integration points, Architectural constraints
5. Map research recommendations to existing codebase structure
6. Highlight: What already exists, What needs to be added, What needs to be modified
```

### Phase 3: Planning Agent
- Synthesizes research and analysis into actionable plan
- Uses `/plan` output format for consistency
- Produces concrete file changes and implementation steps
- **Input**: Research insights + codebase analysis
- **Output**: Implementation plan with Understanding and File Changes

## Agent Orchestration

Launch three consecutive Task agents with these specific prompts:

### 1. Research Agent Prompt:
```
You are a technical research specialist. Research "$ARGUMENTS" to gather current best practices and implementation approaches.

WORKFLOW:
1. Break the topic into 2-3 research angles (e.g., implementation approaches, technology choices, security considerations)
2. Use WebSearch to find: official documentation, technical articles, implementation guides, GitHub examples
3. Search terms: "[topic] best practices", "[topic] implementation", "[topic] architecture patterns"
4. Focus on: What technologies to use, How to implement, Common pitfalls, Performance considerations

OUTPUT FORMAT:
# Research: $ARGUMENTS
## Key Findings
- [Finding 1 with source URL]
- [Finding 2 with source URL]  
- [Finding 3 with source URL]
## Technology Recommendations
- [Recommended tech/approach and why]
## Implementation Approaches
- [Approach 1: description]
- [Approach 2: description]
## Sources
- [Actual URL 1]
- [Actual URL 2]
```

### 2. Analysis Agent Prompt:
```
You are a codebase analysis specialist. Analyze the current codebase to understand how to implement "$ARGUMENTS" within the existing architecture.

Use the research findings from the previous agent to inform your analysis.

WORKFLOW:
1. Use Glob to find files related to the topic (e.g., "**/*[keyword]*")
2. Use Grep to search for existing patterns/implementations  
3. Read key files to understand current architecture
4. Identify integration points and existing capabilities

OUTPUT FORMAT:
# Codebase Analysis: $ARGUMENTS
## Current Architecture
- [Current pattern/structure relevant to the topic]
## Existing Capabilities  
- [What already exists that can be leveraged]
## Integration Points
- [Where new implementation should connect]
## Gaps to Fill
- [What needs to be built/added]
## Files Under Review
[Tree structure of relevant files examined]
```

### 3. Planning Agent Prompt:
```
You are an implementation planning specialist. Create a concrete plan for "$ARGUMENTS" based on research findings and codebase analysis from previous agents.

WORKFLOW:
1. Review research recommendations and codebase analysis
2. Design implementation approach that fits existing architecture
3. Break down into specific file changes
4. Prioritize changes for logical implementation order

OUTPUT FORMAT:
## Understanding  
[2-3 sentences describing what will be built, incorporating research insights]

## File Changes
```
project/
├── [C] new-file.js - Brief description based on research recommendations
├── [M] existing-file.js - Specific changes needed for integration
└── [M] config.json - Configuration updates required
```
```

## Final Output Format

```
## Understanding
[2-3 sentences summarizing what will be built, informed by research and analysis]

## File Changes
```
path/to/file.ext
├── [C] NewComponent.tsx - Brief description based on research best practices
├── [M] ExistingFile.tsx - Changes informed by current code analysis  
├── [M] config.js - Updates based on research recommendations
└── [D] OldFile.tsx - Removal justified by analysis findings
```

## Implementation Notes

- Each agent builds on the previous agent's findings
- Research informs technology choices and approach
- Analysis ensures compatibility with existing architecture
- Plan synthesizes both into concrete, actionable steps
- Final output focuses on practical implementation guidance

## Example Usage

```
/research-analyze-plan "implement real-time notifications system"
/research-analyze-plan "add user authentication with modern security practices"
/research-analyze-plan "optimize database performance for large datasets"
```

The command produces research-backed, analysis-informed plans that are both technically sound and practically implementable within the existing codebase architecture.