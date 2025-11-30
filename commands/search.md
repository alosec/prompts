# Quick Search Command

Perform a quick web search using firecrawl_search and report results without content extraction.

## Usage
`/search [NUMBER] [QUERY]`

## Parameters
- **NUMBER**: Number of results to return (1-10, default: 5)
- **QUERY**: Search query string (required)

## Example Usage
```
/search 2 "astro docs"
/search 5 "react performance optimization"
/search 3 "claude code cli documentation"
```

## Implementation
Use the `mcp__firecrawl-mcp__firecrawl_search` tool directly to perform the search and return:
- **Title** of each result
- **URL** of each result
- **Brief description** (if available)

## Output Format
```
# Search Results for: [QUERY]

## Results ([NUMBER] found)

1. **[Title]**
   - URL: [URL]
   - Description: [Brief description]

2. **[Title]**
   - URL: [URL]
   - Description: [Brief description]

[...continue for all results...]
```

## Notes
- This command focuses on speed and result overview
- No content extraction or deep analysis
- Use `/research` for comprehensive investigation
- Results are limited to the specified number for quick scanning