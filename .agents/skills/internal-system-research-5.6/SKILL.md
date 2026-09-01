---
name: internal-system-research-5.6
description: Evidence-backed internal-system archaeology for GPT-5.6. Start from a Jira ticket and reconstruct current behavior, architecture, historical evolution, documented motivations, contradictions, and open questions across Jira, Confluence, GitHub history, and current code.
argument-hint: <Jira ticket key or URL> [optional focus]
triggers: ["user"]
---

# Internal System Research 5.6

## Objective

Treat `$ARGUMENTS` as the seed Jira ticket. Produce a verified research dossier that can safely feed architecture visualization and a knowledge-sharing deck.

Establish, in this order:
1. what the system does **today**;
2. how its components and data/control flows fit together;
3. how it evolved;
4. why major changes happened **only when evidence states the reason**;
5. which docs/tickets are stale, contradictory, or unresolved.

This is read-only research. Do not modify application code, Jira, Confluence, GitHub, infrastructure, or configuration.

## Deliverables

Create a local research directory and maintain these durable artifacts throughout the run:

- `system-research.md` — current-state explanation, organized by system concern/component.
- `timeline.md` — major transitions with date/period, prior state, new state, evidence, and documented motivation.
- `evidence-index.md` — claim → exact source mapping with confidence/freshness.
- `contradictions.md` — unresolved or resolved conflicts among sources.
- `open-questions.md` — material gaps only; never fill them by guessing.

## Evidence roles

For **current executable truth**, prefer:
1. current code, config, schemas, IaC, tests;
2. recent merged PRs and review discussion;
3. current canonical Confluence/ADRs;
4. Jira implementation/incident/migration history;
5. older docs/tickets as historical evidence.

For **intent/motivation**, code alone is insufficient. Seek PR discussion, Jira context, ADRs, Confluence design notes, incidents, or explicit comments.

## Workflow

### 1. Expand the Jira seed

Read the ticket fully: description, comments, links, parent/epic, subtasks, related issues, dates/status history when available, referenced Confluence pages, PRs, commits, repositories, incidents, migrations, schemas, APIs, tables, jobs, queues, flags, and error strings.

Extract a compact entity/search map:

```text
component -> aliases -> repo/path -> Jira -> Confluence -> PR/commit
```

Follow explicit links first; then broaden search using discovered terminology.

### 2. Establish current state before history

Inspect the relevant repositories and current configuration/tests to determine:
- component responsibilities and boundaries;
- data/control flow;
- stores, queues, APIs, jobs/schedulers, dependencies;
- deployment/runtime topology when evidenced;
- behavior-changing configuration/feature flags;
- current limitations, migrations, or deprecated paths.

Cross-check prose documentation against executable evidence. Record disagreements immediately in `contradictions.md`.

### 3. Reconstruct history backward

For each significant current component or behavior, trace backward where possible:

```text
current code/config
  <- merged PR / commit
  <- Jira issue / epic / incident
  <- Confluence design / ADR / proposal
```

Capture prior state, change, date/rollout period, affected components, documented motivation, exact evidence, and whether later work superseded it.

If the reason is absent, write `motivation: unknown from available evidence`.

### 4. Actively test freshness and contradictions

Look for:
- old Confluence pages describing removed behavior;
- planned Jira states never implemented;
- reverted/superseded PRs;
- dead, migration-only, or feature-flagged code paths;
- tests/config contradicting prose;
- docs predating later architecture changes.

Do not silently pick a side. Resolve with stronger/fresher evidence or preserve both interpretations with confidence.

### 5. Evidence audit

Every material claim needs an exact locator: URL/issue key/page ID/PR/commit SHA/file path+line/date as available.

For high-impact architectural claims, seek a second evidence type when practical. “Not found” is not proof of nonexistence.

## Efficient tool use

Use direct Jira/Confluence/GitHub/code retrieval for evidence that must remain citable.

Use code/programmatic processing only for deterministic work such as:
- deduplicating search results;
- grouping evidence by component/issue/PR;
- sorting known evidence chronologically;
- validating required fields;
- identifying already-processed items.

Do not batch away semantic search decisions when one result should influence the next query.

## Delegation

Use subagents only when workstreams are independent enough to benefit from parallelism, for example:
- Jira history/incidents;
- Confluence/ADR discovery;
- GitHub PR/commit chronology;
- current-code/config/test inspection;
- final contradiction/evidence audit.

The coordinator owns scope, cross-source conflict resolution, timeline integration, and final claims.

Each subagent returns a compact evidence bundle:

```yaml
finding:
state: current|historical
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

## Stopping criteria

Finish when:
- current architecture/behavior is supported by primary evidence;
- major transitions have source-backed dates/periods;
- motivation is sourced or explicitly unknown;
- contradictions are resolved or documented;
- remaining material gaps are in `open-questions.md`;
- additional searches mostly return duplicates/adjacent noise rather than changing the system model.

Do not stop because one authoritative-looking page seems complete.

## Completion report

Return the research artifact paths plus a concise coverage summary: current-state confidence, historical coverage, unresolved contradictions, and open questions. Never claim a source or check was reviewed if it was not.
