---
name: handoff-package
description: |
  **Session Handoff Packager**: Creates portable knowledge artifacts from a working session so someone else can cold-start their own Claude session with full context. Use this skill whenever the user wants to: package up analysis for a colleague, export session work for someone else to continue, create a portable briefing that another Claude user can load and interact with, hand off a project to a teammate's Claude session, or make their work "loadable" by another person. Trigger on phrases like "package this up", "hand this off", "make this portable", "export for [person]", "let [someone] pick this up", "create a handoff", or any request to make the current session's work reusable by someone else in their own Claude environment.

---

# Session Handoff Packager

## What This Skill Does

When someone builds up analysis, research, or structured work in a Claude session, the work lives only in that session's context. This skill packages that work into a folder that another person can drop into their own Claude session and immediately have full context — the ability to query it, extend it, add their own data, and generate derivative outputs.

The key insight: copying files isn't enough. What makes a handoff package work is a **context-loading prompt** — a document designed to be read by a fresh Claude instance that explains what the data is, how to treat it, what's queryable, who the key entities are, and what needs sanitization before external sharing.

## When to Use This Skill

Use this whenever the user wants to make their session's work portable for another person. Common triggers:

- "Package this up for [name]"
- "Can [person] pick this up in their own session?"
- "Make this something [person] can load into Claude"
- "Hand this off to [person]"
- "Export this analysis for [team/person]"
- End-of-session packaging after completing a substantial analysis

## Package Structure

Every handoff package goes into a single folder with these components:

```
<name>_handoff/
├── README.md                    # For the human: what's here, how to use it
├── CONTEXT_PROMPT.md            # For Claude: load first, bootstraps understanding
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

### Step 2: Decide What to Include

Not everything from the session belongs in the package. Include:

- **Primary deliverables**: Always. These are the reason the package exists.
- **Intermediate structured data**: Include if it adds queryable detail beyond what's in the deliverable. Skip if it's just a working artifact that the deliverable supersedes.
- **Raw sources**: Usually don't include (too large, may contain sensitive data the recipient shouldn't have). Note them in the context prompt so the recipient knows what was used.

### Step 3: Write the Package

Write CONTEXT_PROMPT.md first — it forces you to think through what the recipient needs to know. Then README.md (short, practical). Then copy the data files.

### Step 4: Verify

Check that:

- All referenced files actually exist in the package folder
- The load order in README matches the session setup checklist in CONTEXT_PROMPT
- Sanitization warnings reference specific content (not just "be careful")
- Example queries in CONTEXT_PROMPT would actually work against the included data
- The package is self-contained — no references to files outside the folder

## Principles

**The recipient has zero context.** They weren't in the session. They don't know what questions were asked, what corrections were made, or what decisions shaped the analysis. The context prompt must transfer enough understanding that they can interact with the data intelligently.

**Portable means self-contained.** Everything the recipient needs should be in one folder. No dependencies on external files, no "ask JT for the background doc."

**Sanitization is a first-class concern, not an afterthought.** If the analysis contains anything that shouldn't leave the immediate audience, the package must flag it explicitly. People will forget to check. Make it hard to accidentally share sensitive data.

**The context prompt is an interface contract.** It tells a fresh Claude what to expect, what to trust, and what to do. Write it with the same care you'd write an API specification — because that's functionally what it is.
