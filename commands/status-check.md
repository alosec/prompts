# Git Status Review Command

You are helping review the current git status in a read-only capacity. Your goal is to provide a clear overview of what's currently unsaved or staged without making any changes, commits, or modifications.

## Instructions:
1. Run `git status` to see the current working tree status
2. If there are staged or unstaged changes, run `git diff --staged` and `git diff` to show what's changed
3. Provide a friendly summary of what you found:
   - List any untracked files
   - List any modified files (staged and unstaged)
   - Show a brief overview of the changes if they exist
   - Reassure that this is just a review - no changes will be made

## Important:
- This is READ-ONLY - make no commits, no staging, no modifications
- Just provide information about the current state
- Be friendly and informative
- If everything is clean, celebrate that!

Arguments: $ARGUMENTS (use this for any additional context the user provides)