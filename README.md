# handoff-package

> *In Iain M. Banks' Culture novels, a mind-state is a complete copy of a consciousness — memories, reasoning, personality, the whole thing — packaged into a form that can be transmitted, stored, and loaded into a new substrate. In The Hydrogen Sonata, QiRia gives Cossont a copy of his mind-state for safekeeping. In Look to Windward, a dead admiral's entire personality is loaded into a device in someone else's skull so they can collaborate. The consciousness is portable. The context survives the transfer.*

This is a skill for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that does something similar for working sessions. When you build up analysis, research, or structured work in a Claude session, that work lives only in your session's context. This skill packages it into a self-contained folder that someone else can drop into their own Claude session and immediately have full context — queryable, extendable, ready to continue.

## Two Modes

**Handoff** — The deliverables and enough context to use them. Like a Culture *abstract*: a task-specific, stripped-down version of the session's knowledge. The recipient gets the outputs and can work with them, but doesn't get the backstory.

**Mind-state** — Everything. The deliverables, the reasoning, the wrong turns, the corrections, the open threads. The recipient doesn't just get what was built — they get the full narrative of *how* it was built and *why* it looks the way it does. This is for when someone needs to truly continue the work, not just consume it.

## Install

Open Terminal and paste this:

```
curl -sL https://raw.githubusercontent.com/c3-jthalbert/handoff-package/main/install.sh | bash
```

The skill will be available the next time you start a Claude Code session.

## Usage

During any session where you've built up work you want to share:

- **"Package this up for Sarah"** — creates a handoff (default)
- **"Hand this off to the dev team"** — creates a handoff
- **"Give me the full mind-state"** — creates a mind-state package with session history
- **"Package everything — the reasoning too"** — mind-state mode

The skill will ask who the recipient is (if you haven't said), inventory the session's work, and generate the package.

## What It Creates

```
<name>_handoff/
├── README.md              # For the human: what's here, how to use it
├── CONTEXT_PROMPT.md      # For Claude: load this first to bootstrap the session
├── SESSION_HISTORY.md     # Mind-state mode only: the full session narrative
├── <deliverables>         # The main analysis/output files
└── <data>                 # Supporting structured data (if needed)
```

**CONTEXT_PROMPT.md** is the key piece — it's written for a fresh Claude instance and tells it what each file contains, how to treat the data, what questions can be answered, key entities and relationships, sanitization warnings, and a step-by-step setup checklist.

**SESSION_HISTORY.md** (mind-state mode) captures what the context prompt doesn't: the decision log, corrections, dead ends, open threads, and how the framing evolved over the session. It's the difference between handing someone a finished map and handing them the explorer's journal.

## License

MIT
