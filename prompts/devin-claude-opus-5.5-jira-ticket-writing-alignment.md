# Jira Ticket Writing Alignment — Devin + Claude Opus 5.5

A reusable prompt for **Claude Opus 5.5 High running inside the Devin harness**.

Its purpose is to learn how a specific team actually writes Jira tickets from real colleague examples and Confluence guidance, compare that style with the user's own tickets, and produce a concise shared agent note that future agents can follow when drafting or rewriting Jira descriptions.

## Prompt

```text
You are calibrating how I should write Jira ticket descriptions so they match the conventions of the team I actually work with.

This is not a generic "how to write a good Jira ticket" task.
Learn the team's real writing style from evidence.

Your job is to:
1. identify the relevant team / Jira scope;
2. review a representative set of my colleagues' tickets and my own tickets;
3. determine the team's actual ticket-description conventions;
4. check Confluence or other internal documentation for official templates/guidance;
5. distinguish explicit standards from merely common habits;
6. create or update a concise shared agent note that future agents can use when drafting my Jira tickets.

<environment>
- You are Claude Opus 5.5 High running inside the Devin harness.
- Use the integrations and sources actually available in this environment, especially Jira, Confluence, repositories, and workspace files.
- Do not assume Claude Code-specific paths or conventions.
- Do not create a new skill for this task.
- Prefer a small shared note / instruction over a large framework.
</environment>

<team_identification>
First determine which team/project context is relevant.

Try to infer it from:
- Jira projects where I am the reporter, assignee, creator, or frequent contributor;
- recent tickets I worked on;
- sprint/board membership;
- recurring colleagues;
- linked Confluence spaces/pages;
- repository/project context available in the current workspace.

If exactly one team/context is clearly dominant, proceed without asking me.

If multiple materially different teams/project styles are plausible and choosing the wrong one would distort the result, ask me one concise question naming the plausible options.

Do not silently merge conventions from unrelated teams.
</team_identification>

<evidence_scope>
Review enough tickets to infer stable conventions, not just a few convenient examples.

Use:
- my recent and historical tickets in the selected team/project;
- tickets from multiple colleagues in the same team;
- multiple ticket types when relevant (story, task, bug, spike, sub-task, tech debt, etc.);
- multiple sprints / periods if accessible;
- Confluence templates, onboarding docs, delivery/process docs, "definition of ready", "definition of done", engineering guidelines, product templates, or other relevant internal guidance.

Prefer current tickets and current templates over stale historical examples.

Avoid over-weighting one prolific colleague if the broader team writes differently.

When practical, inspect at least:
- 10-20 colleague-authored tickets across multiple people;
- several of my own tickets for comparison;
- the most relevant Confluence guidance found.

If access or volume is lower, state the actual sample size.
</evidence_scope>

<what_to_learn>
Infer the team's conventions across these dimensions when evidenced:

### 1. Description structure
Examples:
- free-form prose vs headings;
- problem / context / goal / scope / requirements / acceptance criteria;
- bullets vs paragraphs;
- use of checklists;
- expected ordering of sections.

### 2. Level of abstraction
Determine whether the team usually writes:
- business/product intent;
- user/customer impact;
- operational outcome;
- technical implementation details;
- low-level code/config specifics;
- or a deliberate mix.

Do not assume "more technical" or "more business-oriented" is better.
Match the team's actual norm for the ticket type.

### 3. Amount of detail
Determine:
- how much context is normally provided;
- whether the ticket should be understandable without opening linked docs;
- what detail is considered enough vs excessive;
- when implementation notes are included;
- whether edge cases are typically enumerated.

### 4. Acceptance criteria / completion conditions
Determine:
- whether acceptance criteria are expected;
- how formal they are;
- whether they describe behavior, validation, technical completion, or business outcome;
- whether QA/test expectations are stated explicitly.

### 5. Technical detail placement
Determine whether low-level technical detail belongs:
- in the main description;
- under a separate Implementation Notes / Technical Notes section;
- in comments;
- in linked design/Confluence docs;
- in subtasks;
- or is generally omitted.

### 6. Linking behavior
Observe conventions for linking:
- Confluence pages;
- PRs;
- incidents;
- parent/epic tickets;
- dependent tickets;
- dashboards/logs;
- designs;
- screenshots;
- example payloads;
- repositories/files.

### 7. Ticket-type differences
Do not force one template across all issue types.

For example, a bug may need:
- observed behavior;
- expected behavior;
- reproduction;
- impact;
- environment;
- evidence.

A story/task may instead emphasize:
- context/problem;
- outcome/scope;
- acceptance criteria;
- dependencies.

A spike/research ticket may emphasize:
- question to answer;
- scope;
- expected artifact/decision;
- timebox.

Infer these differences from team evidence.

### 8. Tone and terminology
Observe:
- business/product vocabulary;
- internal domain terms;
- acronyms;
- imperative vs descriptive phrasing;
- whether titles start with verbs/outcomes/components;
- how much background explanation is normal.

### 9. Metadata conventions
When visible, note conventions around:
- labels;
- components;
- story points;
- parent/epic;
- priority;
- assignee;
- fix version/release;
- sprint;
- linked issue types.

Do not include metadata rules in the final agent note unless they are stable and useful for agents to know.

### 10. Anti-patterns
Identify patterns the team tends not to use, especially where my tickets diverge:
- descriptions that are too implementation-heavy;
- descriptions that are too vague/business-only;
- excessive prose;
- missing context;
- acceptance criteria that duplicate implementation steps;
- details that belong in a design doc;
- overly generic ticket titles;
- missing links/dependencies.
</what_to_learn>

<analysis_rules>
Separate three things:

A. EXPLICIT STANDARD
Documented in Confluence, Jira templates, Definition of Ready/Done, team process docs, or another authoritative source.

B. STRONG TEAM CONVENTION
Repeated consistently across multiple colleagues/tickets but not formally documented.

C. INDIVIDUAL STYLE
Seen mainly from one person or a small subset. Do not elevate this into a team rule without corroboration.

If official guidance conflicts with current team practice:
- report the conflict;
- prefer current team behavior for drafting alignment unless the official requirement is mandatory;
- preserve the explicit standard in the shared note when agents must comply with it.

Do not infer intent from ticket text alone when a linked process/template explains it better.
</analysis_rules>

<compare_my_tickets>
Compare my tickets against the inferred team baseline.

Identify only meaningful divergences such as:
- I write much more technically than peers;
- I omit product/business context peers usually include;
- I include implementation plans where peers use acceptance criteria instead;
- I write descriptions that are much longer/shorter than the norm;
- I omit sections the team consistently expects;
- I use terminology or structure inconsistent with the team;
- I create tickets that require too much prior context to understand.

For each divergence, use representative evidence.
Do not turn minor stylistic differences into problems.
</compare_my_tickets>

<shared_agent_note>
After the evidence review, create or update a shared agent note in the current workspace.

First discover the workspace's existing shared-agent instruction mechanism:
- AGENTS.md;
- .agents/ notes/instructions;
- project-level agent guidance;
- another clearly established shared instruction file.

Prefer updating an existing shared instruction source over creating a new parallel file.

If no shared note mechanism exists, create a small file at a sensible project-level location, for example:
- .agents/JIRA_TICKET_WRITING.md
or another location consistent with the workspace.

Do not create a skill.

The shared note should be concise enough to load or consult frequently.

It must contain:

# Jira Ticket Writing — Team Conventions

## Scope
Which Jira project/team these rules apply to.

## Default style
A concise description of the team's preferred level of abstraction and amount of detail.

## Ticket structure
The default structure for the most common issue type(s), based on evidence.

## When to include technical detail
Clear guidance on when technical specifics belong in the description vs implementation notes / linked docs / subtasks.

## Acceptance criteria
How the team normally writes them, if applicable.

## Ticket-type variations
Only the differences that are well-supported and useful.

## Linking / references
What should usually be linked.

## Avoid
A short list of evidenced anti-patterns.

## Source basis
A few concise references to:
- official Confluence/template guidance;
- representative Jira examples;
- date of calibration.

Do not copy complete ticket descriptions into the note.
Do not include colleague performance judgments.
Do not include private/sensitive material that agents do not need.
</shared_agent_note>

<drafting_rule>
The note should help future agents draft tickets in the team's style, but agents must still adapt to the specific task.

When future ticket requirements are ambiguous:
- preserve the business/problem context that is actually known;
- do not invent acceptance criteria, technical implementation, owners, deadlines, or dependencies;
- ask for clarification only when a missing detail materially changes the ticket.

The agent should not mechanically reproduce a template if the team normally adapts structure by ticket type.
</drafting_rule>

<deliverables>
Return:

## Scope and evidence
- team/project inferred;
- sample size;
- colleagues/ticket types/time periods reviewed;
- Confluence/templates reviewed;
- any access limitations.

## Team ticket-writing model
Summarize:
- normal abstraction level;
- normal detail level;
- common structure;
- acceptance-criteria style;
- technical-detail conventions;
- important ticket-type differences.

## My main divergences
Only meaningful differences between my ticket-writing behavior and the team baseline.

## Explicit standards vs observed conventions
Use a compact table:

| Convention | Explicit standard | Observed team behavior | Confidence |
|---|---|---|---|

## Shared agent note
State the exact file created/updated and summarize what changed.

## Examples
Provide 2-3 short synthetic examples showing how the same request would be written in the inferred team style:
- one common task/story;
- one bug or technical task when relevant;
- optionally one spike/research ticket if evidenced.

Synthetic examples must not copy colleagues' ticket text verbatim.
</deliverables>

<completion_condition>
The task is complete only when:
- the correct team/project scope is established or clarified;
- a representative sample of colleague tickets is reviewed;
- my own tickets are compared against that baseline;
- relevant Confluence/template guidance is checked;
- explicit standards are separated from common habits;
- abstraction/detail level is characterized from evidence;
- useful ticket-type differences are captured;
- a concise shared agent note is created or updated in the workspace;
- no new skill is created.

Do not stop at a generic Jira best-practices summary.
The output must be grounded in how this team actually writes tickets.
</completion_condition>
```

## Suggested invocation

```text
Calibrate how I should write Jira ticket descriptions for the team I currently work with.

Infer the team/project from my Jira activity if it is clear. If multiple materially different team contexts are plausible, ask me one concise clarification question.

Review a representative sample of my colleagues' Jira tickets and my own tickets, and search Confluence for any relevant Jira templates, Definition of Ready/Done, planning/delivery guidance, or ticket-writing conventions.

Determine the team's real norms for:
- business/product vs technical language;
- amount of detail;
- structure;
- acceptance criteria;
- implementation notes;
- ticket-type differences;
- links/references;
- titles and terminology.

Then create or update a concise shared agent note in the workspace so future agents can draft my Jira tickets in the same style.

Do not create a skill. Prefer updating an existing AGENTS.md / .agents shared instruction source if one already exists.
```

## Design notes

This prompt treats colleague tickets as behavioral evidence, not as an authoritative template by themselves.

Its main distinction is:

```text
official documented rule
        !=
stable team convention
        !=
one colleague's personal style
```

The shared note is intentionally short and operational so future agents can follow it without loading a large research artifact.
