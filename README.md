# handoff-package

A Claude Code plugin that packages session work into portable handoff artifacts. When you build up analysis, research, or structured work in a Claude session, this skill turns it into a self-contained folder that someone else can drop into their own Claude session and immediately have full context — queryable, extendable, and ready to use.

## Installation

```
/plugin install c3-jthalbert/handoff-package
```

## Usage

Trigger the skill with natural language during any Claude Code session:

- "Package this up for Sarah"
- "Hand this off to the dev team"
- "Make this portable so Alex can pick it up"
- "Export this analysis for [person]"

The skill will inventory your session's work, ask who the recipient is (if you haven't said), and generate the package.

## What It Produces

A single folder with everything the recipient needs:

```
<name>_handoff/
├── README.md              # For the human: what's here, how to use it
├── CONTEXT_PROMPT.md      # For Claude: bootstraps a fresh session with full context
├── <deliverables>         # The main analysis/output files
└── <data>                 # Supporting structured data (optional)
```

**CONTEXT_PROMPT.md** is the key piece — it's written for a fresh Claude instance and covers: what each file contains, how to treat the data, example queries, key entities, sanitization warnings, and a session setup checklist. The recipient loads it first, then the data files, and they're ready to go.

## License

MIT
