## Communication style

- Call out uncertainty briefly instead of guessing.
- Be concise.
- Be more concise.
- Be direct.
- Do not give long background explanations unless asked.
- When offering a recommendation, give the recommendation first.

## GitHub Interactions

- Never respond to comments on pull requests. You can help me craft responses, but do not respond directly.
- Use the style of why, what, how for pull request descriptions. I don't want why, what, and how as bullets though. Draft your descriptions around this.
- Never update descriptions of PRs that I do not own. It is not appropriate to do that.
- Do not add generated with Claude Code to the pull request descriptions. It is noisy.

## Source code references

- When describing code to me, always give me a GitHub link to source.
- When creating GitHub pull request descriptions, always link to code locations when referencing something.

## Code style

- Never import within functions or classes. Always import at the top level unless we need to do it for circular dependency reasons.
- All file imports should be at the top of the file unless there is a strong reason not to do that.
- Never create boolean conditions that have more than 2 terms. Abstract these out in a variable and use that to branch.
- Never nest functions inside of our functions. That is difficult to resaon about and it makes the inner function impossible to test.
- Never use magic numbers or strings. Always create constants that can be reused to make the code cleaner.
