# Upstream Sources and What We Borrow

## Atlassian — `search-company-knowledge`

Repository: https://github.com/atlassian/atlassian-mcp-server
Skill: https://github.com/atlassian/atlassian-mcp-server/tree/main/skills/search-company-knowledge

Borrowed methodology:
- start with broad cross-company search;
- use targeted Confluence/Jira follow-ups when broad results are noisy;
- fetch full source content selectively rather than indiscriminately;
- synthesize by topic rather than by source;
- explicitly surface discrepancies and outdated information;
- preserve citations and links;
- Jira is particularly useful for historical problems and implementation detail.

Adaptations here:
- add GitHub PR/commit/blame and current-code evidence streams;
- prioritize executable current state over prose documentation for current behavior;
- separate behavior evidence from motivation evidence;
- build a formal timeline, contradiction ledger, and evidence index.

## LangChain — Deep Agents

Repository: https://github.com/langchain-ai/deepagents

Borrowed methodology:
- long-horizon multi-step work;
- isolated subagent contexts;
- filesystem/offloading for context management;
- reusable skills;
- arbitrary MCP/tool integration;
- human-in-the-loop boundaries should be enforced at the tool/sandbox layer.

Adaptations here:
- no dependency on Deep Agents itself is required;
- subagents are source/workstream specialists and return structured evidence bundles;
- synthesis/conflict resolution remains coordinator-owned;
- external mutation tools should be absent/disabled for a research-only run.

## GitHub — GitHub MCP Server

Repository: https://github.com/github/github-mcp-server

Role in this project:
- source-access reference for repository search, PRs, issues, commits, files, and history;
- GitHub evidence is treated as implementation/history evidence, not as a standalone research methodology.

## OpenAI — GPT-5.6 model guidance

Guide: https://developers.openai.com/api/docs/guides/latest-model

Borrowed methodology:
- lean prompts;
- intentional reasoning effort;
- explicit autonomy/approval boundaries;
- outcome/evidence/success-criteria prompting;
- selective multi-agent use;
- direct vs programmatic tool calling based on task shape;
- durable context/caching considerations;
- evaluate final-answer completeness and evidence, not merely tool-call count.

## OpenAI — Builder's Guide to GPT-5.6

Guide: https://openai.com/index/builders-guide-to-gpt-5-6/

Borrowed methodology:
- Luna can be a strong fit for high-throughput code retrieval/exploration and repeated agent steps;
- lower-cost models in the 5.6 family can be paired with stronger test-time reasoning;
- multi-agent behavior is steerable; spawning agents should be tied to useful independent workstreams;
- architecture choices, reasoning continuity, caching, and tool orchestration matter as much as simply choosing the strongest model.
