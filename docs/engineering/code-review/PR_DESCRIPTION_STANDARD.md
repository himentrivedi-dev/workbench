# Pull Request Description Standard

## Purpose

A pull request (PR) description is the change's review brief. It must help a reviewer understand the context, intent, implementation, verification, and risk without reconstructing the story from the diff.

This standard applies to human-written and AI-generated PR descriptions in this repository.

## Source principles

- [GitHub: Creating a pull request template for your repository](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository) is the authority for template locations and GitHub behaviour.
- [Google Engineering Practices: Writing good CL descriptions](https://google.github.io/eng-practices/review/developer/cl-descriptions.html) informs the writing principles: concise, informative titles; clear context and motivation; explanation of the change; and relevant limitations.
- Repository writing guidance: [Writing Principles](../../../agent-tooling/standards/WRITING_PRINCIPLES.md).

## 1. Write a useful title

The title must describe the change in a specific, concise, standalone way. Prefer an action and the affected capability or behaviour.

Good:
- Add availability filtering to activity search
- Fix hotel ranking for location preferences
- Prevent duplicate booking requests during retries

Avoid:
- Bug fix
- Updates
- Changes
- Miscellaneous improvements

Do not claim more than the change delivers.

## 2. Explain the change for the reviewer

Where relevant, answer these questions:

1. **What changed?** State the observable behaviour or capability.
2. **Why was it needed?** Explain the problem, requirement, or motivation.
3. **How was it changed?** Summarise the important implementation and contracts.
4. **Why this approach?** Explain non-obvious decisions and meaningful trade-offs.
5. **How was it verified?** Name tests, commands, environments, and evidence.
6. **What remains?** State known limitations, risks, and follow-up work.

Do not repeat the diff line by line. Explain information that the code alone does not make clear.

## 3. Keep claims evidence-based

- Separate confirmed facts from assumptions and proposals.
- Do not say tests passed unless they were run and passed.
- Identify checks that were not run or could not be run.
- Link relevant issues, incidents, designs, and operational evidence.
- Keep sensitive data, credentials, and customer personal data out of descriptions and logs.
- Prefer a concise answer over an empty section or boilerplate.

## 4. Adapt to the change type

Use the matching template when the PR is a feature, bugfix, or hotfix:

- Feature: scope, motivation, contracts, design choices, rollout, and coverage.
- Bugfix: reproduction, root cause, corrective change, regression coverage, and side effects.
- Hotfix: incident impact, minimal mitigation, verification, rollback, and follow-up.

Use the root-level default template for other changes.

## 5. Reviewer-readiness check

- [ ] The title is specific and understandable without opening the PR.
- [ ] The problem or motivation is clear.
- [ ] The summary matches the actual diff.
- [ ] Non-obvious design decisions and trade-offs are explained.
- [ ] API, schema, configuration, and compatibility impacts are identified.
- [ ] Tests and verification evidence are accurate.
- [ ] Risks, limitations, rollout, and rollback are covered where relevant.
- [ ] Links point to useful source-of-truth material.
- [ ] The description is concise and contains no unsupported claims.

## 6. GitHub template selection

GitHub discovers repository pull request templates from `.github/PULL_REQUEST_TEMPLATE/` and the root `.github/pull_request_template.md` default template.

For a specialised template, use GitHub's supported `template` query parameter on the compare/PR URL, for example: `?template=feature.md`, `?template=bugfix.md`, or `?template=hotfix.md`.

The template files must be available on the repository's default branch. See the GitHub documentation above for current behaviour and URL details.
