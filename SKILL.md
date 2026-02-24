---
name: handoff-package
description: |
  **Session Handoff Packager**: Creates portable knowledge artifacts from a working session so someone else can cold-start their own Claude session with full context. Operates in two modes: **handoff** (deliverables + usage context) or **mind-state** (full session history including reasoning, corrections, and open threads). Use this skill whenever the user wants to: package up analysis for a colleague, export session work for someone else to continue, create a portable briefing that another Claude user can load and interact with, hand off a project to a teammate's Claude session, or make their work "loadable" by another person. Trigger on phrases like "package this up", "hand this off", "make this portable", "export for [person]", "let [someone] pick this up", "create a handoff", "give me the full mind-state", or any request to make the current session's work reusable by someone else in their own Claude environment.

---

# Session Handoff Packager

## What This Skill Does

When someone builds up analysis, research, or structured work in a Claude session, the work lives only in that session's context. This skill packages that work into a folder that another person can drop into their own Claude session and immediately have full context — the ability to query it, extend it, add their own data, and generate derivative outputs.

The key insight: copying files isn't enough. What makes a handoff package work is a **context-loading prompt** — a document designed to be read by a fresh Claude instance that explains what the data is, how to treat it, what's queryable, who the key entities are, and what needs sanitization before external sharing.

## Two Modes

This skill operates in two modes. Ask the user which they want, or infer from context.

### Handoff Mode (default)

Packages the **deliverables and enough context to use them**. The recipient gets the outputs, knows what they are, and can query or extend them. This is the right mode when the work product speaks for itself and the recipient just needs to pick it up and run.

### Mind-State Mode

Packages **everything** — deliverables, context, and the full session history: the questions that were asked, the wrong turns, the corrections, the reasoning that shaped the analysis, and the threads left open. The recipient doesn't just get the outputs — they get the journey. This is the right mode when the reasoning matters as much as the result, when someone needs to continue the work (not just use it), or when the session involved complex judgment calls the recipient should understand.

Triggers for mind-state mode:
- "Give me the full mind-state"
- "I want the whole history"
- "Package everything — the reasoning too"
- "They need to understand how we got here"
- "Make it so they can continue this work"
- The work involved significant corrections, pivots, or judgment calls that would be lost in a clean handoff

## When to Use This Skill

Use this whenever the user wants to make their session's work portable for another person. Common triggers:

- "Package this up for [name]"
- "Can [person] pick this up in their own session?"
- "Make this something [person] can load into Claude"
- "Hand this off to [person]"
- "Export this analysis for [team/person]"
- End-of-session packaging after completing a substantial analysis

## Package Structure

### Handoff Mode

```
<name>_handoff/
├── README.md                    # For the human: what's here, how to use it
├── CONTEXT_PROMPT.md            # For Claude: load first, bootstraps understanding
├── <primary_deliverable(s)>     # The main analysis/output files
└── <intermediate_data>          # Supporting structured data (optional)
```

### Mind-State Mode

```
<name>_handoff/
├── README.md                    # For the human: what's here, how to use it
├── CONTEXT_PROMPT.md            # For Claude: load first, bootstraps understanding
├── SESSION_HISTORY.md           # The full session narrative
├── <primary_deliverable(s)>     # The main analysis/output files
└── <intermediate_data>          # Supporting structured data (optional)
```

### Component Details

**README.md** — Short (under 50 lines). Written for the human recipient. Covers:

- What's in the folder (file table with load order)
- How to start a session with it (step-by-step)
- What they can add (their own data, emails, docs)
- What to watch out for before sharing externally (brief pointer to sanitization section in CONTEXT_PROMPT)

Keep it practical. The recipient is a Claude user, not a developer reading API docs.

**CONTEXT_PROMPT.md** — The critical piece. Written for a fresh Claude instance. This is what the recipient loads first. It must contain:

1. **What You Have** — List each file with a description of its contents and structure. Be specific enough that Claude can answer questions about the data without guessing.

2. **How to Treat This Data** — Framing instructions: what's authoritative, what's provisional, what accountability model applies (joint? one-sided?), what level of candor the analysis uses.

3. **What You Can Do With It** — Concrete example queries organized by category:
   - Querying the existing data ("What happened during X?", "Summarize Y")
   - Adding new data ("Drop additional files and ask Claude to integrate them")
   - Generating derivatives ("Write a 1-page summary for [audience]", "Create talking points for [meeting]")
   - Scenario planning ("If X happens by [date], what's the path to Y?")

4. **Key Entities** — Table of people, organizations, systems, or other entities that appear in the data. Include role/relationship context so Claude can reason about who did what and why.

5. **Sanitization Warnings** — Anything that must be redacted before the work goes outside the immediate audience. Organize by severity:
   - MUST REDACT: internal financials, credentials, personal data
   - REFRAME: sections written with internal candor that need tone adjustment for external audiences
   - HANDLE WITH CARE: items that are factually correct but diplomatically sensitive

6. **Source Materials** — What the analysis was built from (even if the raw sources aren't included). Helps the recipient understand coverage and gaps.

7. **Session Setup Checklist** — Numbered steps: load this file first, then load X, optionally load Y, then tell Claude what you want.

**SESSION_HISTORY.md** (mind-state mode only) — The narrative of the session itself. Written in chronological order. Must contain:

1. **Starting Point** — What the user came in with. What they asked for initially. What raw materials were provided.

2. **Decision Log** — Key questions asked, alternatives considered, and why one path was chosen over another. Not every micro-decision — focus on the ones that shaped the final output.

3. **Corrections and Pivots** — Where the analysis was wrong, where the user pushed back, where assumptions were revised. This is the most valuable part for someone continuing the work — it tells them which mistakes are easy to make and which framings were rejected.

4. **Dead Ends** — Approaches that were tried and abandoned. Why they didn't work. This prevents the recipient from re-exploring paths that have already been ruled out.

5. **Open Threads** — Questions that came up but weren't pursued. Data that would be useful but wasn't available. Analyses that were deferred. These are the natural starting points for someone picking up the work.

6. **Framing Evolution** — How the user's understanding or framing of the problem shifted during the session. The recipient should understand not just the final framing but the earlier framings that were superseded and why.

### Writing the Session History Well

The session history is a narrative, not a transcript. Don't reproduce the conversation verbatim — distill it. The recipient needs to understand the *shape* of the session: where it started, what changed, and why.

- Focus on decisions and pivots, not on routine queries that produced expected results.
- Quote the user when their exact words reveal intent or framing that matters. "The user said 'I don't trust the Parsons timeline' — which shifted the analysis from reconciliation to independent verification" is useful.
- Be honest about where the analysis was wrong or incomplete. The whole point of mind-state mode is to transfer the full picture, including the rough parts.
- Open threads should be specific enough that someone could pick one up and start working on it immediately.

### Writing the Context Prompt Well

The context prompt is doing a specific job: it's a bootstrap document for an AI that has zero prior context. Write it with that in mind.

- Be concrete about data structures. Don't say "the analysis contains a timeline." Say "the analysis contains a 9-phase chronological narrative covering Sept 2025 – Feb 2026, with a blocker attribution table (9 categories), a request tracker (30 items, both directions), and an appendix with 60+ dated events."
- Include enough entity context that Claude can reason about relationships. "Kevin Daly — Parsons primary POC, controls deployment decisions" is useful. "Kevin Daly — Parsons" is not.
- Example queries should be realistic and specific to the actual data, not generic placeholders.
- Sanitization warnings should quote or reference the specific content that needs attention, not just warn abstractly.

## Process

### Step 1: Inventory the Session

Before writing anything, inventory what's been built in the current session:

- What are the primary deliverables? (analysis docs, reports, structured data)
- What intermediate artifacts exist? (extracted data, reconciliation tables, indexes, working notes)
- What raw sources were used? (emails, documents, chat logs — note these even if not included)
- Who is the recipient and what will they do with it?
- What's sensitive? (internal financials, personal data, candid assessments that need reframing)

If the user hasn't specified the recipient or purpose, ask. The context prompt needs to be written for a specific audience.

### Step 2: Choose the Mode

Ask the user: **handoff or mind-state?**

- **Handoff**: "Here are the deliverables and how to use them." Best when the work product is self-explanatory and the recipient just needs to pick it up.
- **Mind-state**: "Here's everything — the deliverables, the reasoning, the wrong turns, and the open questions." Best when someone needs to continue the work, or when the journey matters as much as the destination.

If the user has already indicated a mode (e.g., "give me the full mind-state" or "just package the deliverables"), skip the question.

### Step 3: Decide What to Include

Not everything from the session belongs in the package. Include:

- **Primary deliverables**: Always. These are the reason the package exists.
- **Intermediate structured data**: Include if it adds queryable detail beyond what's in the deliverable. Skip if it's just a working artifact that the deliverable supersedes.
- **Raw sources**: Usually don't include (too large, may contain sensitive data the recipient shouldn't have). Note them in the context prompt so the recipient knows what was used.
- **Session history** (mind-state mode): Include the decision log, corrections, dead ends, and open threads. Distill, don't transcribe.

### Step 4: Write the Package

Write CONTEXT_PROMPT.md first — it forces you to think through what the recipient needs to know. In mind-state mode, write SESSION_HISTORY.md next. Then README.md (short, practical). Then copy the data files.

### Step 5: Verify

Check that:

- All referenced files actually exist in the package folder
- The load order in README matches the session setup checklist in CONTEXT_PROMPT
- Sanitization warnings reference specific content (not just "be careful")
- Example queries in CONTEXT_PROMPT would actually work against the included data
- The package is self-contained — no references to files outside the folder
- (Mind-state mode) SESSION_HISTORY covers the key decisions and pivots, not just a summary of outputs
- (Mind-state mode) Open threads are specific enough to act on

## Principles

**The recipient has zero context.** They weren't in the session. They don't know what questions were asked, what corrections were made, or what decisions shaped the analysis. The context prompt must transfer enough understanding that they can interact with the data intelligently.

**Portable means self-contained.** Everything the recipient needs should be in one folder. No dependencies on external files, no "ask JT for the background doc."

**Sanitization is a first-class concern, not an afterthought.** If the analysis contains anything that shouldn't leave the immediate audience, the package must flag it explicitly. People will forget to check. Make it hard to accidentally share sensitive data.

**The context prompt is an interface contract.** It tells a fresh Claude what to expect, what to trust, and what to do. Write it with the same care you'd write an API specification — because that's functionally what it is.

**Mind-state means the whole picture.** When someone asks for the mind-state, they want the reasoning, the mistakes, and the open questions — not just a clean summary. The mess is the point. It's what lets someone truly continue the work rather than just consume the output.
