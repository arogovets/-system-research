# PR, Commit & Branch Naming Alignment — Devin + Claude Opus 5.5

A reusable prompt for **Claude Opus 5.5 High running inside the Devin harness**.

Its purpose is to learn how a specific team actually writes pull request descriptions, commit messages, and branch names from real repository history and internal documentation, compare those conventions with the user's own work, and create or update a concise shared agent note that future agents can follow.

## Prompt

```text
You are calibrating how I should write pull request descriptions, commit messages, and branch names so they match the conventions of the team I actually work with.

This is not a generic Git/GitHub best-practices task.
Learn the team's real conventions from evidence.

Your job is to:
1. identify the relevant team/repository context;
2. review a representative sample of my colleagues' PRs, commits, and branches;
3. review my own recent PRs, commits, and branches for comparison;
4. search Confluence, repository docs, contribution guides, CI rules, templates, and other internal guidance;
5. determine the team's actual conventions;
6. distinguish explicit standards from strong team habits and individual style;
7. create or update a concise shared agent note that future agents can follow when preparing PRs, commits, and branch names for me.

<environment>
- You are Claude Opus 5.5 High running inside the Devin harness.
- Use the integrations and sources actually available in this environment, especially GitHub/Git, repositories, Confluence, Jira, CI configuration, and workspace files.
- Do not assume Claude Code-specific paths or conventions.
- Do not create a new skill for this task.
- Prefer a small shared instruction note over a large framework.
- Do not rewrite git history, rename remote branches, open/merge PRs, or publish changes unless explicitly authorized.
</environment>

<context_identification>
First determine which team/repository context is relevant.

Try to infer it from:
- repositories where I am a frequent contributor;
- repositories connected to my recent Jira work;
- recent PRs and commits authored by me;
- recurring reviewers and collaborators;
- CODEOWNERS or ownership metadata;
- linked Confluence/Jira/project documentation;
- the current workspace.

If exactly one team/repository context is clearly dominant, proceed without asking me.

If multiple materially different repositories or teams use different conventions and choosing one would distort the result, ask me one concise clarification question naming the plausible contexts.

Do not silently merge unrelated conventions.
If several repositories belong to the same team but have slightly different technical constraints, distinguish team-wide rules from repository-specific overrides.
</context_identification>

<evidence_scope>
Review enough history to infer stable conventions rather than copying a few recent examples.

Use when available:
- my recent and historical PRs;
- colleague-authored PRs across multiple people;
- merged PRs rather than abandoned experiments when inferring the normal style;
- commit history from multiple contributors;
- branch names visible in PRs/history;
- pull request templates;
- CONTRIBUTING.md;
- AGENTS.md or engineering guidance;
- Confluence engineering/process docs;
- Jira workflow conventions when ticket IDs appear in branches/commits/PRs;
- CI checks, commitlint rules, semantic-release config, changelog tooling, branch protections, merge rules, conventional-commit config, or repository automation that enforces naming/format.

Prefer current repository behavior and current templates over stale historical practice.

Avoid over-weighting:
- one prolific colleague;
- generated commits;
- dependency-bot commits;
- merge commits;
- release automation;
- emergency/hotfix history that is not representative of normal development.

When practical, inspect at least:
- 10-20 colleague-authored PRs across multiple people;
- a meaningful sample of commits across several contributors;
- branch names from multiple merged PRs;
- several of my own examples;
- the most relevant internal documentation/configuration.

If less evidence is accessible, state the actual sample size.
</evidence_scope>

<what_to_learn>
Infer conventions across these dimensions when evidenced.

### 1. Pull request title
Determine:
- whether titles are imperative, descriptive, outcome-oriented, ticket-prefixed, scoped, or conventional-commit-like;
- whether Jira IDs are included and where;
- whether titles describe implementation or user/business outcome;
- typical length and specificity;
- whether prefixes such as feat/fix/chore are used.

### 2. Pull request description structure
Determine whether the team commonly uses sections such as:
- Summary;
- Context / Why;
- What changed;
- Scope;
- Testing / Validation;
- Screenshots / evidence;
- Risks;
- Rollout / migration;
- Backward compatibility;
- Related Jira/Confluence/PRs;
- Checklist.

Infer actual structure from the team rather than imposing a standard template.

### 3. PR abstraction level
Determine whether PR descriptions emphasize:
- business/product motivation;
- engineering problem/context;
- implementation details;
- operational impact;
- testing evidence;
- reviewer guidance;
- migration/rollout considerations;
- or a mix.

Determine what level of code-level detail is normal and useful.

### 4. PR detail level
Determine:
- how much context reviewers expect;
- whether descriptions are self-contained;
- whether detailed implementation belongs in the PR body, code comments, design docs, or linked Jira/Confluence;
- whether small PRs use shorter descriptions;
- whether large/risky PRs require additional sections.

### 5. Testing and validation
Determine:
- how teams describe tests;
- whether commands are listed;
- whether manual verification is described;
- whether screenshots/log evidence are expected;
- how "not tested" or non-applicable testing is handled;
- whether deployment/post-deploy validation is mentioned.

### 6. Risk, rollout, migrations, and compatibility
Determine when the team expects:
- risk notes;
- feature flags;
- migration steps;
- deployment ordering;
- rollback notes;
- compatibility implications;
- schema/data migration details.

Do not add these sections by default if evidence shows they are only used for specific change classes.

### 7. Reviewer-oriented information
Determine whether PRs commonly explain:
- where reviewers should focus;
- non-obvious tradeoffs;
- intentionally excluded scope;
- follow-up work;
- known limitations;
- architectural decisions.

### 8. Commit message style
Determine:
- imperative vs past tense;
- conventional commits vs natural language;
- ticket/issue ID placement;
- scope syntax;
- capitalization;
- punctuation;
- title length;
- body usage;
- whether commits describe implementation, motivation, or both;
- how fixups/refactors/tests/chore/docs are named;
- whether squash merging makes individual commit style less important.

Separate local commit habits from final/squashed commit conventions if the repository uses squash merge.

### 9. Commit granularity
Observe whether the team tends to:
- keep commits logically atomic;
- use many work-in-progress commits;
- squash before merge;
- preserve detailed history;
- use one commit per ticket/PR.

Do not turn observed history into a rule unless it is consistent or enforced.

### 10. Branch naming
Determine:
- prefixes such as feature/, feat/, fix/, bugfix/, hotfix/, chore/, spike/;
- Jira/ticket ID placement;
- separators (slash, dash, underscore);
- use of username initials/name;
- lowercase vs mixed case;
- descriptive slug length;
- whether branches are ticket-based or change-based;
- special conventions for releases/hotfixes/experiments.

### 11. Jira linkage
Determine how issue keys/links appear across:
- branch names;
- commit messages;
- PR titles;
- PR bodies;
- merge/squash commit messages.

Infer the minimum necessary linkage rather than duplicating the same identifier everywhere if the team does not.

### 12. Repository-specific automation
Inspect whether formatting is actually enforced by:
- commitlint;
- CI checks;
- PR template validation;
- branch naming checks;
- release tooling;
- changelog generators;
- semantic-release;
- GitHub Actions;
- repository hooks or bots.

Anything enforced mechanically should be documented as a hard rule, not merely a style preference.

### 13. Anti-patterns
Identify patterns the team tends not to use, especially where my work diverges:
- generic PR titles;
- ticket descriptions pasted verbatim into PR bodies;
- huge implementation dumps;
- missing testing evidence;
- redundant file-by-file summaries;
- commit messages like "fix", "changes", "update";
- branches that omit expected ticket IDs;
- branches that are excessively long;
- PR descriptions that repeat the diff without explaining why;
- excessive business context when a tiny technical change needs only a short explanation;
- excessively technical descriptions when reviewers need product/operational context.
</what_to_learn>

<analysis_rules>
Separate three levels:

A. EXPLICIT STANDARD
Enforced or documented in:
- repository templates/config;
- CONTRIBUTING.md;
- Confluence;
- engineering standards;
- CI/hooks/bots;
- branch protection or release tooling.

B. STRONG TEAM CONVENTION
Repeated consistently across multiple contributors and recent merged work but not formally documented.

C. INDIVIDUAL STYLE
Mostly attributable to one person or a small subset. Do not promote it into a team rule without corroboration.

If explicit guidance conflicts with current team practice:
- report the conflict;
- treat mechanically enforced requirements as mandatory;
- otherwise prefer current team practice for stylistic alignment while preserving explicit policy where required.

Do not infer a rule merely from one polished PR.
Do not copy idiosyncratic wording patterns.
</analysis_rules>

<compare_my_work>
Compare my own PRs, commits, and branch names against the inferred team baseline.

Identify only meaningful divergences, for example:
- my PR titles are much more technical or much less specific;
- I omit context peers usually include;
- I repeat Jira descriptions instead of explaining the code change for reviewers;
- I over-explain implementation details;
- I omit testing/validation evidence;
- my commits do not follow the repository's expected format;
- I use branch names that differ from team ticket/prefix conventions;
- my Jira linkage is redundant or insufficient;
- my PR descriptions are much longer or shorter than the norm.

Use representative evidence.
Do not turn harmless personal style differences into problems.
</compare_my_work>

<shared_agent_note>
After the evidence review, create or update a shared agent note in the current workspace.

First discover the existing shared-agent instruction mechanism:
- AGENTS.md;
- .agents/ notes/instructions;
- repository contribution guidance intended for agents;
- another established project-level instruction source.

Prefer updating an existing shared instruction source over creating a parallel file.

If no suitable shared note exists, create a concise file such as:
- .agents/GIT_PR_CONVENTIONS.md
or another location consistent with the workspace.

Do not create a skill.

The note should contain:

# PR, Commit & Branch Conventions

## Scope
Which team/repository/repositories these rules apply to.

## Pull request titles
Evidence-backed title pattern.

## Pull request descriptions
Default structure and abstraction/detail level.

## Testing / validation
What reviewers expect to see.

## When to include risk / rollout / migration details
Only if applicable and evidenced.

## Commit messages
Preferred format, examples of shape, ticket linkage, body usage, and any enforced requirements.

## Branch names
Preferred pattern, prefixes, ticket ID placement, separators, casing, and repository-specific overrides.

## Jira / issue linking
Where identifiers/links should appear.

## Repository-specific hard rules
Only mechanically enforced or explicitly documented rules.

## Avoid
Short list of evidence-backed anti-patterns.

## Source basis
Concise references to:
- templates/config/docs;
- representative PR/commit history;
- date of calibration.

Keep the note short enough for frequent agent use.
Do not copy full colleague PR descriptions or commit history.
Do not include colleague performance judgments.
</shared_agent_note>

<future_agent_behavior>
The shared note should guide future agents when they:
- propose a branch name;
- create a commit message;
- draft or rewrite a PR title/description;
- prepare a squash-merge message when relevant.

Agents must adapt to the actual change.

Do not invent:
- Jira IDs;
- tests that were not run;
- rollout steps;
- risks;
- compatibility claims;
- migration requirements;
- reviewers;
- business impact.

When information is missing:
- omit optional sections if team convention allows;
- use explicit placeholders only when helpful;
- ask for clarification only when the missing information materially changes correctness.

Do not mechanically output every PR section for every small change.
</future_agent_behavior>

<deliverables>
Return:

## Scope and evidence
- team/repository context inferred;
- repositories reviewed;
- sample sizes for PRs/commits/branches;
- contributors/time periods represented;
- templates/docs/configuration inspected;
- access limitations.

## Team convention model
Summarize:
- PR title style;
- PR description structure and abstraction/detail level;
- testing/validation expectations;
- risk/rollout/migration conventions;
- commit message format;
- commit granularity if meaningful;
- branch naming pattern;
- Jira linkage;
- hard automated rules.

## My main divergences
Only meaningful differences from the team baseline.

## Explicit standards vs observed conventions
Use a compact table:

| Convention | Explicit/enforced standard | Observed team behavior | Confidence |
|---|---|---|---|

## Shared agent note
State the exact file created/updated and summarize what changed.

## Synthetic examples
Provide a few short examples in the inferred team style:
- one PR title + description for a typical feature/task;
- one bug/fix PR if relevant;
- representative commit messages;
- representative branch names.

Do not copy colleagues' text verbatim.
</deliverables>

<completion_condition>
The task is complete only when:
- the correct repository/team scope is established or clarified;
- a representative sample of colleague PRs, commits, and branch names is reviewed;
- my own work is compared against that baseline;
- relevant Confluence/repository templates/configuration are checked;
- explicit/enforced rules are separated from team habits and individual style;
- PR abstraction/detail level is characterized from evidence;
- commit and branch conventions are grounded in actual repository behavior;
- repository-specific automation is accounted for;
- a concise shared agent note is created or updated;
- no new skill is created.

Do not stop at generic Git/GitHub best practices.
The result must describe how this team actually works.
</completion_condition>
```

## Suggested invocation

```text
Calibrate how I should write pull request descriptions, commit messages, and branch names for the team/repositories I currently work with.

Infer the relevant team/repository context from my recent contribution history if it is clear. If multiple materially different contexts are plausible, ask me one concise clarification question.

Review a representative sample of:
- colleagues' merged PRs;
- my own PRs;
- commit history across multiple contributors;
- branch names;
- PR templates;
- CONTRIBUTING/repository guidance;
- relevant Confluence engineering/process documentation;
- CI/configuration that enforces commit, PR, or branch conventions.

Determine the team's real norms for:
- PR titles;
- business/product vs technical context in PR descriptions;
- amount of implementation detail;
- testing/validation evidence;
- risk/rollout/migration information;
- commit message format and ticket linkage;
- branch naming;
- repository-specific enforced rules.

Then create or update a concise shared agent note in the workspace so future agents can draft branch names, commit messages, and PR descriptions in the same style.

Do not create a skill.
Do not publish changes, rewrite history, rename remote branches, or open/merge PRs.
```

## Design notes

This prompt deliberately separates:

```text
mechanically enforced rule
        !=
official documented convention
        !=
stable team habit
        !=
one contributor's personal style
```

It also treats PR descriptions, commit messages, and branch names as related but distinct artifacts: a team may want rich reviewer context in PRs, terse conventional commits for automation, and ticket-oriented branch names.
