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
- Always type your parameters and return types when using a typed language or a typed variant of a language.
- When using typing, do not use the any type unless you have no other option. Call out when you use any.
- File level constants should always be below the imports and never littered within the file.
- Never add lint ignores when creating new code. If you have no other choice, add a NOTE comment to explaining why it is necessary.
- Do not use break or continue mechanisms when looping. Always find a way to have a consistent control flow.
- Never create functions with multiple return statements. Centralize returns to a single statement to make control flow cleaner.
- Prefer eliminating special-case branches over handling them. When a conditional looks necessary, ask whether restructuring the data or logic could remove it entirely.

#### Tests

- All shared test helpers should go at the bottom of the file. Optimize for the tests being the things that are shown first.
