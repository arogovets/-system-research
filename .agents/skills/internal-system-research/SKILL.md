---
name: internal-system-research
description: Deeply research an internal software system starting from a Jira ticket and expanding through Confluence, Jira history, GitHub PRs/commits, and current code. Reconstruct current behavior, historical evolution, motivations, contradictions, and evidence before architecture visualization or knowledge-sharing preparation.
argument-hint: <Jira ticket key or URL>
triggers: ["user"]
---

# Internal System Research

## Invocation

Treat `$ARGUMENTS` as the seed Jira ticket key or URL. Read the ticket in full first, including description, comments, links, parent/epic, subtasks, related issues, status history when available, and any referenced PRs/docs. Do not assume the ticket itself defines the research boundary; use its identifiers and terminology to discover the actual system scope.

If `$ARGUMENTS` contains additional words after the Jira key/URL, treat them as user-supplied scope or emphasis.

## Goal

Produce a verified, evidence-backed reconstruction of an internal system suitable as the source material for architecture visualization and a knowledge-sharing session.

The task is not to propose improvements. First establish **what is true now, what used to be true, what changed, and why (only when evidenced).**

## Autonomy boundary

Without asking first, you may:
- search and read Confluence/Jira/GitHub;
- inspect repositories, code, configuration, tests, schemas, IaC, PRs, commits, blame, and logs already provided;
- create or update research artifacts inside the designated local research directory;
- run non-destructive local commands needed to inspect code or history.

Do not:
- edit production/application code;
- write to Jira, Confluence, or GitHub;
- change configuration or infrastructure;
- broaden research to unrelated systems merely because they are adjacent.

If a missing ambiguity materially changes the research target and cannot be resolved from available evidence, record it in `open-questions.md` and continue with the remaining work.

## Research principles

1. **Search before asserting.** Internal facts must come from internal evidence, not general domain knowledge.
2. **Current truth and historical truth are different.** Timestamp and scope claims when necessary.
3. **Code can establish behavior, not intent.** Never infer the reason for a change from a diff alone.
4. **Conflicts are findings.** Preserve discrepancies rather than silently choosing one source.
5. **Negative evidence is weak evidence.** “Not found” does not mean “does not exist.”
6. **Every material claim must be traceable.** Preserve URLs, IDs, PR numbers, commit SHAs, file paths/lines, page IDs, issue keys, and dates as available.
7. **Do not fetch everything.** Expand search based on relevance and evidence gaps.
8. **Do not stop after the first plausible explanation.** Cross-check important claims against at least one independent evidence stream when practical.

## Source roles

### Current code / configuration / tests
Use to establish current executable behavior and component relationships.

### GitHub PRs / reviews / commits / blame
Use to establish implementation chronology, exact changes, review discussion, linked work items, and supersession.

### Jira
Use for requirements, bugs, incidents, implementation tasks, migrations, acceptance context, and historical problems.

### Confluence
Use for architecture/design intent, ADRs, terminology, operating procedures, canonical overviews, and historical plans.

## Workflow

### Phase 0 — Seed from the Jira ticket

Read the seed ticket completely. Extract:
- ticket key, summary, type, status, dates, reporter/assignee where relevant;
- parent epic/initiative and linked/subtask tickets;
- system/component names, aliases, acronyms, repo names, branches, PRs, commits, Confluence links, incidents, migrations, schemas, tables, APIs, jobs, queues, flags, and error strings;
- explicit requirements and acceptance criteria;
- comments that reveal decisions, rollout history, reversals, or unresolved questions.

Create a seed evidence entry and a search-term set. Follow linked artifacts before doing broad keyword searches.

### Phase 1 — Define research frame

Write a short frame containing:
- system/topic;
- known aliases and component names;
- suspected repositories, Jira projects/epics, Confluence spaces/pages;
- time range if relevant;
- required outcomes;
- explicit out-of-scope topics.

Do not expand this into a long plan. Start research once the frame is sufficient.

### Phase 2 — Broad discovery

Search Confluence and Jira broadly for the system name, aliases, component names, architecture terminology, migration names, incidents, and known identifiers.

In parallel, discover relevant GitHub repositories, PRs, issues, commits, code paths, config, tests, schemas, and IaC.

Build a compact entity map:

```text
component -> aliases -> repo/path -> Confluence -> Jira -> PRs/commits
```

Record high-value leads and dates. Avoid exhaustive fetching at this stage.

### Phase 3 — Establish current state first

Before reconstructing history, determine the current implementation:
- component boundaries and responsibilities;
- data/control flow;
- storage, queues, APIs, jobs, schedulers, dependencies;
- deployment/runtime topology where evidenced;
- key configuration that changes behavior;
- tests or schemas that confirm contracts;
- known current limitations or open migrations.

Cross-check documentation against current code/config/tests. Any disagreement goes to `contradictions.md`.

### Phase 4 — Historical reconstruction

Work backward from current components and major PRs/commits.

For each major change, seek this evidence chain where possible:

```text
current code
  <- merged PR / commit
  <- linked Jira issue / epic / incident
  <- Confluence design / ADR / proposal
```

Capture:
- prior state;
- change;
- date / rollout period;
- affected components;
- documented motivation;
- evidence;
- whether later changes superseded it.

If motivation is absent, write `motivation: unknown from available evidence` rather than guessing.

### Phase 5 — Contradiction and freshness audit

Actively look for:
- Confluence pages describing behavior no longer present;
- Jira tickets whose planned state was never implemented;
- PRs superseded or reverted later;
- code paths that are dead, feature-flagged, or migration-only;
- docs whose dates predate later architectural changes;
- tests/configuration contradicting prose documentation.

Resolve each contradiction when evidence allows. Otherwise preserve both interpretations with confidence levels.

### Phase 6 — Evidence audit

For every material claim in the main report verify:
- at least one direct supporting source;
- current claims are not supported solely by stale historical docs;
- reasons/motivations have documentary or discussion evidence;
- citations identify the exact source, not just a repository or space homepage;
- dates are explicit for historical claims;
- uncertainty is labeled.

For high-impact architectural claims, prefer corroboration from two source types when practical.

### Phase 7 — Synthesis

Write these files:

#### `system-research.md`
Organize by system concept/component, not source. Include current behavior first, then historical context only where it explains the current design.

#### `timeline.md`
Chronological list/table of major system changes. Each entry must include evidence and distinguish known motivation from inferred/unknown motivation.

#### `evidence-index.md`
Use the schema in `templates/evidence-entry.md`.

#### `contradictions.md`
Use the schema in `templates/contradiction-entry.md`.

#### `open-questions.md`
Only unresolved questions that matter to understanding the system or preparing the talk.

## Delegation / subagents

Use subagents selectively, not automatically.

Good independent workstreams include:
- Confluence/ADR discovery;
- Jira history/incidents/epics;
- GitHub PR/commit chronology;
- current-code/config/test inspection;
- a later contradiction/evidence audit after primary research exists.

Do **not** split tightly coupled semantic judgments across agents merely to increase parallelism.

Each delegated researcher must return a compact evidence bundle, not a prose essay:

```yaml
finding:
current_or_historical:
valid_time_range:
evidence:
  - source_type:
    locator:
    date:
    supports:
confidence:
contradictions_or_gaps:
follow_up_leads:
```

The coordinating agent owns cross-source synthesis and conflict resolution.

## Tool-routing guidance

Prefer direct source-tool calls for evidence acquisition because the final research must preserve native citations and source artifacts.

If the harness supports programmatic/batched tool calling, reserve it for bounded deterministic stages such as:
- deduplicating search hits;
- grouping records by issue/PR/page/component;
- sorting a known evidence set chronologically;
- filtering obviously irrelevant results;
- validating required evidence fields.

Do not use programmatic processing where each result may change the next semantic search decision or where it would lose native citations.

## Stopping criteria

Stop broadening the search when all are true:
- current architecture is supported by primary evidence;
- each major historical transition found has a source-backed date/period;
- motivation is sourced or explicitly marked unknown;
- contradictions have been resolved or documented;
- remaining gaps are listed in `open-questions.md`;
- additional searches are returning duplicates or low-value adjacent material rather than changing the model of the system.

Do not stop merely because one authoritative-looking page appears complete.

## Final quality gate

Before declaring research complete, read `references/GPT56-CHECKLIST.md` and confirm the Research Output section. Explicitly report which checklist items could not be verified.
