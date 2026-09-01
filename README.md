# GPT-5.6 Agent Skills Catalog

A **Devin-ready `.agents` skill catalog** containing proven agent methodologies adapted directly in their `SKILL.md` files for GPT-5.6.

The adaptations follow a pre-push release gate derived from:
- OpenAI model guidance: https://developers.openai.com/api/docs/guides/latest-model
- OpenAI Builder's Guide to GPT-5.6: https://openai.com/index/builders-guide-to-gpt-5-6/

The gate is not merely a skill reference: every adjusted `SKILL.md` is created locally, checked against [`GPT-5.6-SKILL-CHECKLIST.md`](GPT-5.6-SKILL-CHECKLIST.md), and only pushed after the gate passes. The executed result is in [`validation/2026-09-01-pre-push.md`](validation/2026-09-01-pre-push.md).

## Install in Devin

Download or copy this repository's **`.agents` directory** into a repository connected to Devin. Devin can then discover the skills under `.agents/skills/`.

## Catalog

| Skill | Purpose | Example invocation |
|---|---|---|
| `internal-system-research-5.6` | Start from Jira and reconstruct the current internal system plus its evidence-backed history across Confluence, GitHub and code | `@skills:internal-system-research-5.6 PROJ-123` |
| `archify-5.6` | Turn requirements/research into validated architecture, workflow, sequence, data-flow or lifecycle diagrams | `@skills:archify-5.6 <research dossier or system>` |
| `sci-slides-5.6` | Turn trusted research into a story-driven, cited, timed and visually reviewed technical/knowledge-sharing deck | `@skills:sci-slides-5.6 <research dossier + talk constraints>` |

## Recommended pipeline

```text
Jira seed
  ↓
internal-system-research-5.6
  ↓
verified research dossier
  ├────────────→ archify-5.6 ──→ validated architecture artifact
  │
  └───────────────────────────→ sci-slides-5.6
                                  ↓
                           knowledge-sharing deck
```

For your internal-system knowledge-sharing workflow, run research first, then Archify separately, then feed the verified dossier plus validated architecture into Scientific Slides.

## GPT-5.6 adaptation principles

The catalog intentionally applies the GPT-5.6 guidance rather than adding generic “think harder” instructions:

- reasoning effort is configured by the harness/caller instead of repeated in every skill;
- prompts are outcome-first with explicit deliverables, scope, stop conditions and validation;
- deterministic filtering/rendering/validation is moved into code/tools where practical;
- model context is reserved for semantic judgment, prioritization, synthesis and perceptual review;
- subagents are used only for cleanly independent workstreams, with the coordinator retaining synthesis;
- long tasks persist durable artifacts instead of relying on conversational memory;
- primary evidence is fetched directly when citations/artifacts must survive;
- automated validity and subjective/perceptual quality are reported as separate claims.

## Skill structure

```text
.agents/
└── skills/
    ├── internal-system-research-5.6/
    │   ├── SKILL.md
    │   └── UPSTREAM.md
    ├── archify-5.6/
    │   ├── SKILL.md
    │   ├── UPSTREAM.md
    │   └── scripts/bootstrap_archify.sh
    └── sci-slides-5.6/
        ├── SKILL.md
        ├── UPSTREAM.md
        └── scripts/bootstrap_upstream_support.sh
```

The adapted instructions are always the `SKILL.md` inside each `*-5.6` directory. `UPSTREAM.md` is provenance only.

### Runtime/support handling

`archify-5.6` preserves the official Archify renderer/validator rather than reimplementing it in a prompt. Its bootstrap script retrieves the **pinned** upstream runtime and never overwrites the adapted `SKILL.md`.

`sci-slides-5.6` is self-contained at the methodology level and tool-agnostic. Its optional support bootstrap retrieves K-Dense's pinned references/assets/scripts for additional implementation details; the upstream skill instructions do not replace the adapted GPT-5.6 skill.

## Model choice

These skills are optimized for the GPT-5.6 family but do not hard-code model switching or reasoning effort. If you choose **GPT-5.6 Luna + max** in your harness, the skills focus that compute on evidence and judgment instead of spending prompt tokens repeatedly instructing the model to reason harder.
