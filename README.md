# handoff-package

A skill for Claude Code that packages your session work into a portable folder someone else can load into their own Claude session with full context.

## Install

Open Terminal and paste this:

```
curl -sL https://raw.githubusercontent.com/c3-jthalbert/handoff-package/main/install.sh | bash
```

That's it. The skill will be available the next time you start a Claude Code session.

## How to Use It

During any Claude Code session where you've built up work you want to share, say something like:

- "Package this up for Sarah"
- "Hand this off to the dev team"
- "Make this portable for [person]"

Claude will ask who the recipient is (if you haven't said), inventory your session's work, and create a handoff folder.

## What It Creates

A single folder with everything the recipient needs:

```
<name>_handoff/
├── README.md              # For the human: what's here, how to use it
├── CONTEXT_PROMPT.md      # For Claude: load this first to bootstrap the session
├── <deliverables>         # The main analysis/output files
└── <data>                 # Supporting structured data (if needed)
```

The key file is **CONTEXT_PROMPT.md** — it's written specifically for a fresh Claude instance and tells it what each file contains, how to treat the data, what questions can be asked, and what needs to be sanitized before sharing externally. The recipient loads it first, then the data files, and they're up and running.

## License

MIT
