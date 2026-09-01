# GPT-5.6 Recommendations → Application Checklist

This checklist translates the current OpenAI GPT-5.6 guidance into concrete rules for this research skill.

Sources:
- https://developers.openai.com/api/docs/guides/latest-model
- https://openai.com/index/builders-guide-to-gpt-5-6/

## Model / reasoning

| Recommendation | How we apply it | Check |
|---|---|---|
| Choose model by workload; Luna is for efficient/high-volume work. | Use GPT-5.6 Luna for the repeated retrieval, code exploration, and research loop. | [ ] |
| Set reasoning effort intentionally; `max` is for hardest quality-first workloads and should normally be compared with `xhigh`. | This project intentionally runs Luna at `max` because the user prioritizes research quality. Document that this is a deliberate choice, not a universal default. If evaluating later, compare against `xhigh` on the same research questions. | [ ] |
| Do not rely on “think harder” prompt wording. | The skill specifies goal, evidence, source hierarchy, stopping rules, uncertainty, and validation instead of requesting hidden reasoning behavior. | [ ] |

## Lean prompting

| Recommendation | How we apply it | Check |
|---|---|---|
| Favor leaner prompts; remove repeated instructions/examples/tool descriptions. | Keep one canonical `SKILL.md`; do not duplicate its rules in the user goal, AGENTS.md, and subagent prompts. | [ ] |
| State each instruction once. | Source hierarchy, autonomy boundary, evidence policy, and stopping rules each live in one section. | [ ] |
| Expose only relevant tools with concise descriptions. | Research run should expose read/search tools for Atlassian, GitHub, filesystem/code inspection; omit mutation/deployment tools where possible. | [ ] |
| Track context growth. | Persist evidence and timeline to files; do not keep large fetched documents repeatedly in conversational context. | [ ] |

## Intent, boundaries, and success criteria

| Recommendation | How we apply it | Check |
|---|---|---|
| Provide domain context, hard constraints, approval boundaries, success criteria. | Research frame defines system scope; `SKILL.md` defines reads as autonomous and external writes as forbidden; stopping criteria define completion. | [ ] |
| Define autonomy explicitly to avoid unnecessary pauses. | Agent can search/read/inspect and write local research artifacts without asking. It must not write to Jira/Confluence/GitHub or change product code. | [ ] |
| Ask only when an ambiguity is materially blocking. | First try resolving ambiguity from evidence; otherwise record it in `open-questions.md` and continue independent work. | [ ] |

## Multi-agent

| Recommendation | How we apply it | Check |
|---|---|---|
| GPT-5.6 is strong at orchestration, but subagent spawning is steerable. | Skill provides explicit good workstreams rather than forcing a fixed number of agents. | [ ] |
| Use parallel agents when the task divides cleanly into independent workstreams. | Confluence, Jira, GitHub history, and current-code inspection may run independently during discovery. | [ ] |
| Avoid extra subagents when token cost will not improve outcome. | Coordinator may research directly when evidence volume is small or tightly coupled. | [ ] |
| Keep synthesis centralized. | Source agents return structured evidence bundles; coordinator resolves chronology, conflicts, and final claims. | [ ] |

## Programmatic tool calling / batching

| Recommendation | How we apply it | Check |
|---|---|---|
| PTC is best for bounded filtering/joining/ranking/dedup/validation. | Use batching/programmatic processing only for deterministic evidence reduction and validation if the harness supports it. | [ ] |
| Prefer direct calls if each result may change the next decision. | Semantic source discovery and follow-up searches remain direct/model-guided. | [ ] |
| Prefer direct calls when final output must preserve citations/native artifacts. | Primary Jira, Confluence, PR, commit, and file evidence retrieval remains direct so locators survive. | [ ] |
| Define concurrency/retry/stopping rules for bounded stages. | Any batch helper must define inputs, output schema, retry cap, and stop condition; it must not perform mutations. | [ ] |

## Reasoning continuity / long context

| Recommendation | How we apply it | Check |
|---|---|---|
| Persisted reasoning can help stable multi-turn work. | If the harness exposes GPT-5.6 reasoning continuity, keep it across the stable research run. | [ ] |
| Do not depend solely on model-internal continuity. | Durable research state is explicit in `system-research.md`, `timeline.md`, and `evidence-index.md`, so compaction/restarts do not erase findings. | [ ] |
| Luna has a very large context, but long prompts still cost more and can accumulate duplication. | Fetch selectively, summarize evidence into structured bundles, and avoid repeatedly injecting full source documents. | [ ] |

## Prompt caching

| Recommendation | How we apply it | Check |
|---|---|---|
| Stable prefixes and cache keys/breakpoints can improve reuse. | If the harness/API exposes caching, put stable skill instructions/source taxonomy before dynamic system/query details. | [ ] |
| Measure actual cache economics. | Treat cache configuration as harness optimization, not a research-quality assumption. Track cache metrics if available. | [ ] |

## Response shape

| Recommendation | How we apply it | Check |
|---|---|---|
| GPT-5.6 is concise by default; specify what must survive rather than just saying “be verbose.” | Required artifacts and evidence schemas define necessary detail. Avoid generic verbosity instructions. | [ ] |
| Preserve conclusion, evidence, caveats, next actions in shorter outputs. | Research summaries lead with current-state conclusions but always retain evidence, contradictions, uncertainty, and open questions. | [ ] |

## Research output quality gate

Before research is considered complete:

- [ ] Current-state claims are grounded in current code/config/tests or other primary current evidence.
- [ ] Historical pages/tickets are not accidentally presented as current truth.
- [ ] Every major change has an explicit date or bounded period.
- [ ] Every stated motivation is supported by PR/Jira/ADR/Confluence discussion; otherwise marked unknown.
- [ ] Major architectural claims have corroboration from a second source type when practical.
- [ ] PRs/reverts/superseding changes have been checked before relying on old implementation evidence.
- [ ] Conflicting sources are recorded rather than silently reconciled.
- [ ] Missing evidence is labeled as missing; absence of search results is not treated as proof.
- [ ] Evidence locators are precise: page/issue/PR/commit/file+line when available.
- [ ] Search expansion has stopped because new queries are duplicative/low-value, not because the first plausible answer was found.
- [ ] `system-research.md`, `timeline.md`, `evidence-index.md`, `contradictions.md`, and `open-questions.md` are internally consistent.
