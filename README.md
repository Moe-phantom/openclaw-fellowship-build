# OpenClaw Productivity Agent — Worldwide AI Science Fellowship Build Challenge

Submission for the Worldwide AI Science Fellowship "Invite to Build" challenge (April 2026). Built in ~8 hours of focused work on a tight deadline.

## What I built

A personal productivity AI agent deployed locally on Ubuntu 24, accessible from anywhere via Telegram, with custom skills for daily briefings and live arXiv research search.

**Working end-to-end:**
- 🦞 OpenClaw 2026.4.22 running as a systemd service on Ubuntu 24
- 💬 Telegram channel — chat with the agent from my phone
- 🤖 Gemini 2.5 Flash backend (free tier via Google AI Studio — no budget)
- 📦 Custom `/brief` skill — date, open task count, motivational quote (reads real data)
- 📚 Custom `/papers` skill — live arXiv search, returns 5 most recent papers on any topic with title, authors, date, ID, and abstract preview
- 🪝 Custom `/task` and `/tasks` skills — registered correctly in OpenClaw, see "What I learned" below

## Demo

📹 Loom walkthrough: https://www.loom.com/share/47ee63341f7d495381cc06bc7503e998

📸 Screenshots: see `/screenshots` folder

### Live arXiv search example
Screenshot from 2026-04-25 12-32-53.png
Screenshot from 2026-04-25 12-31-53.png





## Stack

| Layer | Tool |
|---|---|
| Agent framework | OpenClaw 2026.4.22 |
| Runtime | Node.js 22+, Ubuntu 24 |
| Model | Gemini 2.5 Flash (Google AI Studio free tier) |
| Channel | Telegram Bot API |
| Custom skills | Bash + Python3 + arXiv API |
| AI pair-programmer | Claude Code |

## Process

1. Installed OpenClaw via the official one-liner: `curl -fsSL https://openclaw.ai/install.sh | bash`
2. Onboarded with the wizard, hatched a Telegram bot
3. Hit DeepSeek free-tier billing issues on first try, pivoted to OpenRouter, then to Gemini Flash for better tool-calling and a real free tier
4. Connected Telegram via BotFather + `openclaw channels add telegram`
5. Wrote four custom skills (`task`, `tasks`, `brief`, `papers`) — paired with Claude Code on the structure, debugged registration issues by diffing against working skills
6. Diagnosed why some skills weren't being invoked despite registering as `✓ ready`

## What I learned

The interesting bug: `/task` and `/tasks` registered correctly in OpenClaw's skill registry (`openclaw skills list` shows them as `✓ ready`), but the model consistently chose to respond conversationally rather than invoke the skill. I confirmed this by checking that `tasks.jsonl` was never written — despite the bot replying "task added." This held across DeepSeek V3.2, an OpenRouter free model, and Gemini 2.5 Flash.

Working hypothesis: the skill descriptions are being treated by the model as documentation rather than as binding tool-call triggers. The fix likely lives in either (a) sharper SKILL.md trigger language with explicit "MUST invoke" patterns, (b) a system-prompt directive that forces deterministic skill routing for slash-prefixed input, or (c) OpenClaw's tool-routing logic itself. With more time I'd diff against OpenClaw's bundled `apple-reminders` skill, which presumably handles the same shape of invocation reliably.

`/brief` and `/papers` work because their script logic doesn't depend on the LLM choosing to write a file — they fetch and format. The standalone scripts are 100% reliable; the LLM-side routing is the loose layer.

## What I'd build next

- Fix the `/task` invocation issue with sharper trigger patterns and end-to-end tests
- Tech opportunity scout — daily digest of relevant fellowships, hackathons, and grants from RSS feeds
- Google Calendar integration so `/brief` includes today's events
- Scheduled morning briefings via cron + `openclaw message send`
- Move from local laptop to a small VPS so the agent stays online when my laptop sleeps


## Honest reflection

I'd never used OpenClaw before this challenge. First time writing OpenClaw skills, first time pairing with Claude Code on a deadline this tight. The 80/20 of what I learned: getting an agent talking is easy now; getting it to *reliably do things on your behalf* is where the real engineering still lives — registration, tool routing, and model selection all matter and none of them are automatic.

It was a tough week in the uni and I had to give limited time to each so I started this challenge late. That's on me. But shipping what works honestly beats not shipping at all, so here we are.
overally in this last 24 hours I learned countless amount of information.
- Mohamed Alwathiq
