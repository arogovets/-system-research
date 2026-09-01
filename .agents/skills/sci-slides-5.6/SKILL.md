---
name: sci-slides-5.6
description: GPT-5.6 adaptation of K-Dense scientific-slides for evidence-backed technical, scientific, and internal knowledge-sharing talks. Converts a trusted research dossier into a story-driven deck with timing, citations, diagrams/figures, speaker guidance, and explicit visual/structural validation without requiring a specific image-generation vendor.
argument-hint: <research dossier, topic, talk length, audience, and desired output format>
triggers: ["user"]
license: MIT
metadata:
  upstream: K-Dense-AI/scientific-agent-skills/skills/scientific-slides
  upstream_version: "1.7"
  upstream_commit: "1dd0fccf46fc3c9855c4a0c313a0c57fe4319883"
---

# Scientific Slides 5.6

## Objective

Turn trusted source material into a presentation people can follow and remember. Optimize for oral communication, evidence fidelity, and visual hierarchy—not document density.

For internal-system talks, the research dossier is the source of truth. Do not independently invent architecture/history to make the story smoother; surface missing evidence instead.

## Inputs to resolve

Use the user's supplied values when present; infer only low-risk defaults:
- audience and their likely prior knowledge;
- talk type/purpose;
- allotted time;
- desired format (`pptx`, PDF/Beamer, HTML, or slide plan);
- available research dossier, diagrams, figures, data, logos/template;
- required depth and Q&A expectations.

If a missing value would materially change the deck, record the assumption explicitly and continue with a reasonable default rather than blocking the whole task.

## Durable artifacts

Create and maintain:
- `deck-plan.md` — narrative spine and slide-by-slide intent;
- `source-map.md` — each important slide claim → exact source/figure;
- `speaker-notes.md` — what must be spoken rather than crowded onto slides;
- final presentation artifact(s);
- `review.md` — structural, factual, timing, and visual review findings.

## Workflow

### 1. Verify source readiness

Before designing slides, inspect the research material and identify:
- 3–7 audience takeaways;
- current-state facts vs historical context;
- strongest diagrams/figures/data already available;
- claims requiring citations;
- unresolved contradictions/open questions that should not be presented as settled fact.

Do not launch broad research unless the user asked for it; upstream research should already be completed for an internal-system session.

### 2. Build the narrative spine

Define a compact arc appropriate to the talk. For an internal-system knowledge share, default to:

```text
Why this system exists
→ mental model / current architecture
→ one concrete end-to-end flow
→ important design/evolution decisions
→ operational realities / edge cases
→ what the audience should remember
→ Q&A / backup material
```

Do not organize the deck by source document or chronology unless chronology itself is the teaching objective.

### 3. Budget time before slide count

Allocate time by section, leaving room for transitions and Q&A if applicable. Derive slide count from pacing rather than a rigid formula.

Slides that introduce a new mental model or complex diagram need more speaking time than title/transition slides.

### 4. Plan every slide before production

For each slide record:
- **purpose** — one sentence;
- **audience takeaway** — one sentence;
- **content** — only what must be visible;
- **visual** — diagram/chart/figure/example/layout;
- **source(s)** — exact evidence locator(s);
- **speaker note** — explanation kept off-slide;
- **estimated time**.

Prefer one main idea per slide. Split when two ideas compete for attention.

### 5. Reuse real evidence before generating visuals

Search the supplied workspace for existing architecture diagrams, plots, screenshots, tables, and figures before generating replacements.

For system architecture, prefer an already validated Archify artifact when available. For results/data, preserve the real numbers and labels; visual generation must not redraw data inaccurately.

Image/visual generation is optional and tool-agnostic. Use whatever approved image/visual capability exists in the harness; do not require a specific external generation provider merely because upstream examples used one.

### 6. Produce the deck

#### PPTX
Use the available PPTX/slide creation toolchain and keep text editable when practical. Generated images are supporting visuals, not a substitute for editable text/data unless the user explicitly wants image-based slides.

#### PDF / Beamer
Use a Beamer template or equivalent only when PDF/LaTeX is desired. Keep references and figure attribution legible.

#### HTML
Use only when the user wants web-native delivery.

Maintain a consistent design system across the deck: typography, spacing, backgrounds, accents, title placement, figure treatment, and citation style.

## Content and design invariants

- Slides are prompts for the speaker, not paragraphs from the research report.
- Prefer meaningful diagrams/figures/examples over decorative imagery.
- Preserve exact system/component/API/table/topic names where they matter.
- Keep citations close enough to claims/figures to remain traceable.
- Avoid tiny text, crowded multi-panel layouts, low-contrast labels, and screenshots that cannot be read at presentation distance.
- Do not fabricate metrics, diagrams, screenshots, customer/user quotes, or architectural relationships.
- Historical claims should include date/period when it prevents confusion with current behavior.
- If a contradiction remains unresolved, present it as uncertainty or omit the claim; do not choose the prettier story.

## Efficient tool use

Use code/tools for deterministic work:
- extracting known metadata from source artifacts;
- sorting citations;
- converting slides to images/PDF;
- checking file/page/slide counts;
- overflow/layout validators;
- assembling contact sheets/thumbnails.

Reserve model judgment for:
- narrative structure;
- what to omit;
- slide-level teaching objective;
- semantic simplification;
- perceptual visual review;
- likely audience questions.

## Delegation

For an ordinary deck, keep one coordinator. Use subagents only for independent tasks such as:
- citation/source-map audit;
- separate visual asset discovery across large directories;
- independent factual review of different system domains;
- final Q&A/back-up-slide research.

Do not delegate individual slides to many agents without a shared narrative/design system; that usually creates inconsistency. The coordinator owns the final deck and source map.

## Validation loop

Run four separate checks:

### A. Factual/source check
Every material claim/figure is supported by `source-map.md`. Current vs historical state is not conflated.

### B. Structural check
The audience can answer: Why does this matter? What is the mental model? How does one real flow work? What should I remember?

### C. Timing check
Sum slide estimates, account for transitions/demos, and fit the requested talk length with a small buffer.

### D. Visual check
Render/export slides to images and inspect them. Look for overflow, unreadable text, accidental repetition, inconsistent hierarchy, distorted figures, weak contrast, and slides that are understandable only by reading speaker notes.

Automated layout validation and perceptual review are different claims. Report both truthfully.

Repair only diagnosed problems. Avoid redesigning the entire deck after each review round unless the narrative itself fails.

## Q&A preparation

Create a short list of likely questions, especially around:
- boundaries and ownership;
- failure modes/retries;
- why major design choices were made;
- known limitations;
- historical migrations;
- data consistency/security/operability where relevant.

Answers must point back to the research evidence. Unknowns remain unknown.

## Stopping criteria

Finish when:
- the narrative has a clear audience outcome;
- every important slide claim is sourced;
- timing fits;
- deterministic format/layout checks pass where available;
- rendered slides received an actual visual review;
- critical visual/factual issues are fixed or explicitly documented;
- the deck has speaker notes and a Q&A preparation section when useful.

## Completion

Return paths to the deck, `deck-plan.md`, `source-map.md`, `speaker-notes.md`, and `review.md`, plus a short truthful summary of factual, timing, automated-layout, and perceptual-review status.
