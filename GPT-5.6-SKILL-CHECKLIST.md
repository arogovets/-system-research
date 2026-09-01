# GPT-5.6 Skill Adaptation Checklist

This checklist is a **pre-push gate** for every `*-5.6` skill in this catalog. It is based on OpenAI's GPT-5.6 model guidance and Builder's Guide (reviewed 2026-09-01).

## Model/harness principles

- [ ] **Keep the harness stable unless change is justified.** Adapt the skill instructions, not the surrounding agent runtime unnecessarily.
- [ ] **Do not encode “use maximum reasoning” as repeated prompt boilerplate.** Reasoning effort belongs to the caller/harness. The skill specifies outcomes, evidence, constraints, and validation.
- [ ] **Use Luna/Terra/Sol as a harness decision.** Smaller GPT-5.6 models can be strong for high-volume retrieval/repeated steps; this catalog does not hard-code model switching.

## Prompt design

- [ ] **Single source of truth.** No duplicated instruction blocks that say the same thing in different wording.
- [ ] **Outcome-first.** State objective, scope, deliverables, success criteria, and stopping criteria explicitly.
- [ ] **Lean instructions.** Remove motivational prose, repeated warnings, and examples that do not change behavior.
- [ ] **No chain-of-thought solicitation.** Ask for artifacts, evidence, receipts, decisions, and concise rationale—not hidden reasoning.
- [ ] **Uncertainty is explicit.** Missing evidence must be marked unknown rather than guessed.

## Tool use and context efficiency

- [ ] **Move deterministic work to code/tools.** Validation, filtering, sorting, deduplication, rendering, geometry checks, file conversion, and schema checks should be programmatic when available.
- [ ] **Reserve model judgment for semantic work.** Interpretation, prioritization, conflict resolution, narrative decisions, and visual judgment stay with the model.
- [ ] **Direct source retrieval when citations/artifacts matter.** Do not hide primary evidence behind lossy aggregation.
- [ ] **Durable artifacts for long work.** Persist plans/evidence/results in files instead of relying on conversational memory.
- [ ] **Bounded reads.** Read only the references/runtime files needed for the current stage.

## Parallelism / multi-agent

- [ ] **Parallelize only cleanly independent workstreams.** Do not spawn subagents merely because the task is large.
- [ ] **Specify when delegation helps.** The skill gives concrete examples of independent workstreams.
- [ ] **Coordinator owns synthesis.** Cross-source conflict resolution, final narrative, or final artifact acceptance stays centralized.
- [ ] **Subagent returns are compact and structured** when delegation is used.

## Verification and stopping

- [ ] **Artifact-first where possible.** Produce a concrete candidate early, then inspect/validate it.
- [ ] **Use deterministic validators before subjective review.** Do not ask the model to eyeball what a validator can prove.
- [ ] **Use perceptual review where deterministic checks are insufficient.** Keep automated validity and human/image-model visual quality as separate claims.
- [ ] **Focused repair loop.** Change only diagnosed problems; avoid full rewrites after each failure.
- [ ] **Explicit stop condition.** Stop when success criteria are met or when further retries no longer improve objective diagnostics.
- [ ] **Truthful completion.** Never claim a check, source review, render, or inspection that did not happen.

## Portability and provenance

- [ ] **Devin-ready path/name.** Skill is directly installable under `.agents/skills/<name>/SKILL.md` and the frontmatter name includes `5.6`.
- [ ] **No unnecessary vendor lock-in.** External generators/services from upstream are optional unless fundamental to the skill.
- [ ] **Upstream attribution and pinned version/commit are recorded.** Runtime bootstrap, if needed, is pinned and must not overwrite the adapted `SKILL.md`.
- [ ] **Destructive/external writes have explicit boundaries.** Research/analysis skills default read-only unless the user asks otherwise.
