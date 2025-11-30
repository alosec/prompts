# Deep Web Research Command

Conduct comprehensive web research using specialized subagents equipped with Firecrawl search and scrape capabilities.

## Usage
`/research [QUERY] [DEPTH] [AGENTS] [BUDGET]`

## Parameters
- **QUERY**: Research topic or question (required)
- **DEPTH**: Search depth - `QUICK` (surface-level) or `DEEP` (comprehensive) 
- **AGENTS**: Number of subagents (1-4) for parallel investigation
- **BUDGET**: Context budget relative to query significance - `LOW`, `MEDIUM`, `HIGH`

## Research Process

### 1. Query Analysis
Break down the research query into distinct investigative angles:
- Primary research question
- Supporting sub-questions  
- Related contextual areas
- Technical/domain-specific aspects

### 2. Agent Deployment
Deploy 1-4 specialized subagents based on complexity:
- **Single Agent**: Simple, focused queries
- **Multiple Agents**: Complex topics requiring different perspectives
- Each agent assigned specific research angle

### 3. Search Strategy
**QUICK Depth:**
- Surface-level web search
- Primary sources and authoritative sites
- Recent articles and documentation
- 2-3 search iterations per agent

**DEEP Depth:**
- Comprehensive multi-source research
- Academic papers, technical documentation
- Historical context and trend analysis
- 5-8 search iterations per agent
- Cross-reference validation

### 4. Context Budget Management
**LOW Budget:**
- Essential findings only
- Concise summaries
- Key facts and conclusions

**MEDIUM Budget:**
- Balanced coverage
- Supporting details
- Multiple perspectives
- Source citations

**HIGH Budget:**
- Comprehensive analysis
- Detailed explanations
- Comparative analysis
- Full source attribution
- Related topics exploration

## Agent Capabilities
Each subagent has access to:
- `mcp__firecrawl-mcp__firecrawl_search` - Web search with scraping
- `mcp__firecrawl-mcp__firecrawl_scrape` - Direct URL content extraction
- `mcp__firecrawl-mcp__firecrawl_deep_research` - AI-powered research analysis
- `WebSearch` - General web search capabilities

## Output Format

### Structured Results Template
```
# Research: [QUERY]

## Summary
[Key findings in 2-3 sentences]

## Findings
```
├── [Focus Area 1]
│   └── [Key insight + source]
├── [Focus Area 2] 
│   └── [Key insight + source]
└── [Focus Area 3]
    └── [Key insight + source]
```

## Sources
**REQUIRED: Must include specific URLs, not placeholders**
- [Source 1 Title](https://actual-url-1.com)
- [Source 2 Title](https://actual-url-2.com) 
- [Source 3 Title](https://actual-url-3.com)

## Next Steps
- [Actionable recommendation 1]
- [Actionable recommendation 2]
```

## Example Usage
```
/research "Latest developments in quantum computing error correction" DEEP 3 HIGH
/research "Best practices for React performance optimization" QUICK 2 MEDIUM  
/research "Climate change impact on coastal cities" DEEP 4 HIGH
```

## Implementation Notes
- Create subagents using Task tool with specific research prompts
- Each agent focuses on distinct aspect of the query
- Parallel execution for efficiency
- Consolidate findings from all agents
- Validate information across sources
- **CRITICAL: Always include actual URLs in Sources section - no placeholders allowed**