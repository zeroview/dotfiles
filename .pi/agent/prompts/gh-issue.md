---
description: Reads a GitHub issue from the current repository with the GitHub CLI and creates an implementation plan from the development work described in the issue.
argument-hint: "<issue-number>"
---
# GitHub Issue Plan

Use this prompt when the user wants a plan for implementing the development work described in a GitHub issue in the current repository.

The issue number argument provided to `/gh-issue` is:

```text
$ARGUMENTS
```

## Workflow

1. Read the issue number from the template arguments above.
   - Accept both `#24` and `24`.
   - If no issue number is provided, ask the user for one.
   - If multiple issue numbers are provided, ask the user which single issue to plan.

2. Fetch the issue from the current repository with `gh`:

   ```bash
   gh issue view <issue-number> --json number,title,state,url,author,labels,assignees,body,comments
   ```

   Use the current repository inferred by `gh`; do not hard-code a repository name.
   If the command fails, run these commands to verify that the GitHub CLI is usable:

   ```bash
   gh --version
   gh repo view --json nameWithOwner,url
   ```

   If either command fails, tell the user what failed and ask them to install, authenticate, or run from inside a GitHub-backed repository.

3. Read the fetched issue carefully.
   - Treat the issue body as the primary source of the requested development work.
   - Treat comments as additional context, clarifications, constraints, or later decisions.
   - Note if the issue is closed, but still create the plan unless the user asks otherwise.

4. Inspect the repository before planning.
   - Use file search, reads, and relevant package/config files to understand the existing implementation.
   - Identify likely files, components, tests, generated files, database migrations, or documentation that the work may touch.
   - Do not edit files while using this prompt unless the user explicitly asks to start implementing.

5. Create an implementation plan.
   - Start with a short issue summary including the issue number, title, URL, and state.
   - List key requirements and constraints extracted from the issue.
   - Describe the current code areas that are relevant.
   - Provide a step-by-step development plan in the order the work should be done.
   - Include a testing plan that follows the repository's existing conventions.
   - Call out open questions, ambiguities, risks, and assumptions.

6. Keep the output actionable.
   - Prefer concrete file paths and commands where possible.
   - Separate required work from optional follow-ups.
   - Do not claim that changes were made; this prompt only plans the implementation.

## Output Format

Use this structure for the final response:

```markdown
## Issue

#<number>: <title>
<url>
State: <state>

## Summary

<short summary of the requested work>

## Requirements

- <requirement>

## Relevant Code

- `<path>` — <why it matters>

## Implementation Plan

1. <step>
2. <step>
3. <step>

## Testing Plan

- <test or command>

## Open Questions / Risks

- <question, ambiguity, or risk>
```
