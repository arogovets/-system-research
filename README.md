# Internal System Research

A reusable **Devin Agent Skill** for reconstructing an internal software system from **Confluence, Jira, GitHub history, and current code** before producing architecture diagrams or a knowledge-sharing deck.

Designed for a quality-first run with **GPT-5.6 Luna + max reasoning**, while keeping the prompt lean and evidence-driven.

## Intended pipeline

```text
Confluence ─┐
Jira ───────┼──> internal-system-research ──> verified research dossier
GitHub ─────┤                                  │
Current code┘                                  ├──> Archify
                                               └──> K-Dense scientific-slides
```

## Devin installation

Connect this repository to Devin. Devin discovers the skill at:

```text
.agents/skills/internal-system-research/SKILL.md
```

Invoke it explicitly from a Devin session:

```text
@skills:internal-system-research PROJECT-123
```

or with a Jira URL:

```text
@skills:internal-system-research https://your-company.atlassian.net/browse/PROJECT-123
```

The Jira ticket is treated as the **research seed, not the research boundary**. The skill follows linked issues, Confluence pages, PRs/commits, repositories, aliases, current code/config/tests, and historical evidence until the system model is sufficiently supported.

## Required Devin access

For the complete workflow, Devin should have read access to:

- Jira
- Confluence
- relevant GitHub repositories
- current code/config/tests in its workspace

The skill is intentionally research-only: it may create local research artifacts but must not modify Jira, Confluence, GitHub, application code, configuration, or infrastructure.

## Skill structure

```text
.agents/
└── skills/
    └── internal-system-research/
        ├── SKILL.md
        ├── references/
        │   ├── GPT56-CHECKLIST.md
        │   └── UPSTREAM-SOURCES.md
        └── templates/
            ├── contradiction-entry.md
            ├── contradictions.md
            ├── evidence-entry.md
            ├── evidence-index.md
            ├── open-questions.md
            ├── subagent-evidence-bundle.yaml
            ├── system-research.md
            └── timeline.md
```

## What a research run produces

- `system-research.md` — verified current-state explanation organized by system concerns rather than source.
- `timeline.md` — major changes in chronological order with evidence and known motivation.
- `evidence-index.md` — claim-to-source mapping with confidence and validity period.
- `contradictions.md` — conflicts among docs, tickets, PRs, commits, tests, configs, and current code.
- `open-questions.md` — unresolved gaps that must not be guessed.

## Core source hierarchy

For **current behavior**, prefer evidence in this order unless specific evidence warrants otherwise:

1. Executable current code, configuration, schemas, infrastructure definitions, and tests.
2. Recently merged PRs and their review/discussion context.
3. Current canonical Confluence documentation / ADRs.
4. Jira issues describing implementation, incidents, bugs, or migrations.
5. Older documentation and tickets as historical evidence only.

For **why a change happened**, never infer motivation from code alone. Trace backward through PR discussion, linked Jira, ADRs, Confluence design pages, and incident context.

## GPT-5.6 methodology

The skill includes a recommendation-to-implementation checklist based on:

- OpenAI latest model guide: https://developers.openai.com/api/docs/guides/latest-model
- OpenAI Builder's Guide to GPT-5.6: https://openai.com/index/builders-guide-to-gpt-5-6/

See:

`.agents/skills/internal-system-research/references/GPT56-CHECKLIST.md`

It covers lean prompting, intentional `max` reasoning, autonomy boundaries, selective subagents, centralized synthesis, direct-vs-programmatic tool routing, durable research state, evidence requirements, and stopping criteria.

## Upstream methodologies

This skill adapts ideas from:

- Atlassian `search-company-knowledge`: https://github.com/atlassian/atlassian-mcp-server/tree/main/skills/search-company-knowledge
- LangChain Deep Agents: https://github.com/langchain-ai/deepagents
- GitHub MCP Server: https://github.com/github/github-mcp-server
- OpenAI GPT-5.6 guidance above

See `.agents/skills/internal-system-research/references/UPSTREAM-SOURCES.md` for the exact methodology mapping.

## Recommended Devin task prompt

The reusable methodology belongs in the skill, so the task prompt can stay short:

```text
@skills:internal-system-research PROJECT-123

Deeply research the internal system represented by this Jira ticket.
Treat the ticket as the starting point, not the research boundary.
Follow the skill through current-state verification, historical reconstruction,
contradiction/evidence audit, and all required research artifacts.

This is read-only research. Do not implement or modify the system.
Before finishing, run the included GPT-5.6 quality checklist and report any
items that could not be verified.
```
