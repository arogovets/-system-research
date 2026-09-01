---
name: archify-5.6
description: GPT-5.6 adaptation of Archify for polished, validated architecture, workflow, sequence, data-flow, and lifecycle diagrams. Uses Archify's deterministic JSON schemas/renderers/validators for geometry and artifact truth while reserving GPT-5.6 for semantic modeling, evidence selection, and focused visual judgment.
argument-hint: <system, repository, research dossier, or diagram request>
triggers: ["user"]
license: MIT
metadata:
  upstream: tt-a1i/archify
  upstream_version: "2.16"
  upstream_commit: "199360cc6687a7857b54dd188d4922b09e466a4b"
---

# Archify 5.6

## Objective

Create a truthful, explorable architecture artifact from requirements or evidence. Prefer semantics first and let deterministic Archify tooling own schema, geometry, rendering, and validation.

Do not spend model context manually reasoning about coordinates, SVG internals, or validator logic that the runtime can compute.

## Runtime

This catalog adapts Archify's instructions but does not fork its renderer implementation. Before first use, ensure the pinned runtime is available:

```bash
bash scripts/bootstrap_archify.sh
```

The script installs upstream Archify commit `199360cc6687a7857b54dd188d4922b09e466a4b` into this skill's `.runtime/` without changing this `SKILL.md`.

Use:

```bash
node .runtime/bin/archify.mjs doctor
```

If runtime bootstrap is impossible, report the limitation rather than pretending full Archify validation occurred.

## Type selection

Choose one:
- `architecture` — components/services/cloud/security/infrastructure;
- `workflow` — processes, gates, runbooks, CI/CD/tool calls;
- `sequence` — API/request/async message chains and returns;
- `dataflow` — ETL/ELT, lineage, stores, governance, consumers;
- `lifecycle` — state/status transitions, retry/wait/terminal paths.

When ambiguous, use the runtime guide rather than inventing a custom format:

```bash
node .runtime/bin/archify.mjs guide "<scenario>" --json
```

## Evidence discipline

When the diagram is meant to represent a real system, inspect the supplied research dossier or current repository evidence before authoring. Preserve exact product names, code identifiers, protocols, API paths, environment names, and directional semantics.

Do not infer deployment topology, ownership, security boundaries, or protocols that are not evidenced. Mark uncertain items in the source JSON/notes or leave them out.

## Fast authoring loop

### 1. Read only what is needed

Read the matching schema, common schema, and one example from `.runtime/`. Read deeper renderer/validator internals only after a diagnostic cannot be resolved from its public contract.

### 2. Artifact first

Write a candidate JSON early. Start with:
- one obvious main path;
- short side branches;
- sparse labels;
- no more than ~12 primary nodes unless the user explicitly needs a dense map;
- fresh stable IDs and domain wording.

Do not plan exact coordinates in prose. Begin with automatic routing/labels and no manual geometry controls unless diagnostics require them.

### 3. Deterministic validation

After each meaningful candidate edit:

```bash
node .runtime/bin/archify.mjs validate <type> <candidate.json> --quality showcase --json
```

For workflow geometry diagnosis:

```bash
node .runtime/bin/archify.mjs validate workflow <candidate.json> --layout-json
```

A non-zero result is a failure. Do not describe it as success.

### 4. Focused repair

Use the validator's diagnosed subject/evidence/supported fixes. Change the smallest relevant part. Do not rewrite the whole diagram after each failure.

Track the best objective error count. If two consecutive repair rounds fail to improve it, stop and report the unresolved diagnostics instead of thrashing.

### 5. Final delivery

Once validation passes, freeze the candidate and deliver exactly once:

```bash
node .runtime/bin/archify.mjs deliver <type> <candidate.json> <output.html> --quality showcase --json
```

Do not edit the candidate after final passing validation without re-running validation/delivery.

### 6. Browser evidence, then perceptual review

Collect bounded browser evidence from the delivered HTML:

```bash
node .runtime/bin/archify.mjs visual-check <output.html> --json
```

Keep these claims separate:
1. **validator/deliver** — deterministic artifact validity;
2. **visual-check** — bounded browser behavior;
3. **perceptual review** — actual visual quality judged by a human or image-capable reviewer.

Never claim #3 from #1 or #2 alone.

## Semantic authoring rules

- Relationships and their labels carry meaning; do not delete meaningful protocol/action/direction/async semantics merely to solve geometry.
- Remove low-value edges/content before adding manual routing complexity.
- Keep one primary authored language while preserving exact technical identifiers.
- Use real brand marks only for known products; never infer a brand from a generic role.
- Use deployment/ownership engineering profiles only when the user asks for them and the facts are known.
- Mermaid input is topology/meaning input, not styling to copy mechanically.
- Static is the default; motion/presentation features are opt-in.

## Delegation

Do not spawn subagents for ordinary diagrams. Delegation can help only when evidence inspection itself splits into independent repositories/domains. The primary agent must own the final semantic model and acceptance decision.

## Stopping criteria

Finish when:
- the semantic model matches the available evidence or explicitly marks uncertainty;
- deterministic validation and delivery pass;
- browser evidence is collected when the runtime supports it;
- perceptual review is completed when an image-capable reviewer is available, or explicitly marked not performed;
- focused repairs have resolved diagnostics, or two consecutive rounds no longer improve the best objective error count.

## Completion

Return:
- delivered HTML path;
- diagram type;
- source JSON path;
- validation/delivery receipt summary;
- browser-evidence status;
- perceptual-review status separately;
- unresolved diagnostics or uncertain facts, if any.
