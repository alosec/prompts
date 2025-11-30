# Act Command

Execute the plan or insights that have been developed in the current conversation.

**Usage**: `/act [specific-focus]`

## Instructions:
When the user runs `/act`, immediately begin implementing the plan or acting on the insights discovered during the conversation. This transitions from planning to execution mode.

Key behaviors:
1. **Read the conversation context** - Review any plans, decisions, or insights from recent messages
2. **Use TodoWrite tool** - Create a todo list based on the plan if one doesn't exist
3. **Begin implementation** - Start making the actual code changes, file modifications, or other actions
4. **Work systematically** - Follow the plan step-by-step, marking todos as in_progress/completed
5. **Stay focused** - Don't ask for additional clarification unless absolutely necessary

If no clear plan exists in the conversation, briefly summarize what you understand needs to be done and then proceed with implementation.

Arguments: $ARGUMENTS (use this to focus on specific aspects of the plan or provide additional context)