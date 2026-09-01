# Internal System Research

A focused agent skill for reconstructing an internal software system from **Confluence, Jira, GitHub history, and current code** before producing architecture diagrams or a knowledge-sharing deck.

Designed for a quality-first run with **GPT-5.6 Luna + max reasoning**, while keeping the prompt lean and evidence-driven.

## Intended pipeline

```text
Confluence ─┐
Jira ───────┼──> internal-system-research ──> verified research dossier
GitHub ─────┤                                  │
Current code┘                                  ├──> Archify
                                               └──> K-Dense scientific-slides
```

## What this skill produces

- `system-research.md` — verified current-state explanation, organized by system concerns rather than source.
- `timeline.md` — major changes in chronological order, with evidence and known motivation.
- `evidence-index.md` — claim-to-source mapping with confidence and validity period.
- `contradictions.md` — conflicts among docs, tickets, PRs, commits, tests, configs, and current code.
- `open-questions.md` — unresolved gaps that must not be guessed.

## Core source hierarchy

For **current behavior**, prefer evidence in this order unless the system gives a reason to override it:

1. Executable current code, configuration, schemas, infrastructure definitions, and tests.
2. Recently merged PRs and their review/discussion context.
3. Current canonical Confluence documentation / ADRs.
4. Jira issues describing implementation, incidents, bugs, or migrations.
5. Older documentation and tickets as historical evidence only.

For **why a change happened**, do not infer motivation from code alone. Trace backward through PR discussion, linked Jira, ADRs, Confluence design pages, and incident context.

## Upstream methodologies

This repository adapts, rather than blindly copies, ideas from:

- Atlassian `search-company-knowledge` skill: https://github.com/atlassian/atlassian-mcp-server/tree/main/skills/search-company-knowledge
- LangChain Deep Agents: https://github.com/langchain-ai/deepagents
- GitHub MCP Server: https://github.com/github/github-mcp-server
- OpenAI GPT-5.6 model guidance: https://developers.openai.com/api/docs/guides/latest-model
- OpenAI Builder's Guide to GPT-5.6: https://openai.com/index/builders-guide-to-gpt-5-6/

See [`GPT56-CHECKLIST.md`](GPT56-CHECKLIST.md) for the exact recommendation-to-implementation mapping.

## Usage

Ask the agent to use `SKILL.md` and provide the internal system/topic plus any known repository/project/space hints.

Example goal:

> Reconstruct the current architecture and historical evolution of `<SYSTEM>`. Research Confluence, Jira, GitHub PR/commit history, and current code. Separate current truth from historical state, explain why major changes happened only when supported by evidence, preserve citations/IDs for every material claim, and produce the five research artifacts defined by the skill.

## Scope boundary

This is a **research skill**. It should not modify production code, Jira, Confluence, or GitHub. Read/search/fetch operations are in scope; external writes require a separate explicit request.
# -system-research
