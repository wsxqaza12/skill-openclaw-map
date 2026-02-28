# OpenClaw Environment Reference

## Find the docs

OpenClaw ships docs inside the package. To find them:

```bash
node -e "console.log(require.resolve('openclaw/package.json').replace('/package.json', '') + '/docs')"
# or
echo "$(npm root -g)/openclaw/docs"
```

Key reference pages (relative to docs root):
- `concepts/agent-workspace.md` — workspace layout, backup
- `concepts/agent.md` — agent runtime, bootstrap files, sessions
- `concepts/skills.md` — skills system
- `cli/acp.md` — ACP bridge (IDE integration)
- `tools/clawhub.md` — ClawHub skill registry
- `gateway/` — Gateway config, sandboxing, multi-agent
- `channels/` — messaging channel setup

Online mirror: https://docs.openclaw.ai

---

## ~/.openclaw/ layout

```
~/.openclaw/
├── openclaw.json          # Main config
├── openclaw.json.bak      # Auto-backup
├── cron/
│   ├── jobs.json          # Cron job definitions
│   └── runs/              # Per-job run logs (JSONL, named by job ID)
├── agents/
│   └── <agentId>/
│       └── sessions/      # Session transcripts (JSONL)
├── skills/                # User-installed skills
├── credentials/           # OAuth tokens and secrets
└── workspace/             # Default agent workspace
```

## Agent workspace

Default: `~/.openclaw/workspace`
Override via `agent.workspace` in `openclaw.json`.

Bootstrap files (injected into agent context every session):
- `AGENTS.md` — operating instructions + memory
- `SOUL.md` — persona and tone
- `TOOLS.md` — tool notes (camera names, SSH hosts, etc.)
- `IDENTITY.md` — agent name, emoji, vibe
- `USER.md` — user profile
- `BOOTSTRAP.md` — one-time first-run ritual (agent deletes after)

Optional workspace files:
- `HEARTBEAT.md` — periodic heartbeat check tasks
- `BOOT.md` — startup checklist executed on gateway restart (keep short)
- `MEMORY.md` — long-term curated memory
- `memory/YYYY-MM-DD.md` — daily session logs
- `skills/` — workspace-scoped skills (highest priority)
- `canvas/` — Canvas UI files for node displays
- `state/` — runtime state files

## Sessions

```
~/.openclaw/agents/<agentId>/sessions/<sessionId>.jsonl
```

Main session: agentId = `main`

## Cron jobs

Definitions: `~/.openclaw/cron/jobs.json`

One-shot (main session, system event):

```json
{
  "name": "Reminder",
  "schedule": { "kind": "at", "at": "2026-02-01T16:00:00Z" },
  "sessionTarget": "main",
  "wakeMode": "now",
  "payload": { "kind": "systemEvent", "text": "Reminder text" },
  "deleteAfterRun": true
}
```

Recurring (isolated session, with delivery):

```json
{
  "name": "Morning brief",
  "schedule": { "kind": "cron", "expr": "0 7 * * *", "tz": "America/Los_Angeles" },
  "sessionTarget": "isolated",
  "wakeMode": "next-heartbeat",
  "payload": { "kind": "agentTurn", "message": "Summarize overnight updates." },
  "delivery": { "mode": "announce", "channel": "slack", "to": "channel:C1234567890" }
}
```

Schedule kinds: `at` (one-shot ISO 8601) · `every` (interval ms) · `cron` (5-field expr + optional tz)
Session targets: `main` (system event via heartbeat) · `isolated` (dedicated agent turn)
Delivery modes: `announce` · `webhook` · `none` (default for isolated: `announce`)

Run logs: `~/.openclaw/cron/runs/<jobId>.jsonl`

```bash
openclaw cron list
openclaw cron add --name "Check emails" --cron "0 9 * * *" --session main --system-event "Check emails"
openclaw cron rm <jobId>
```

## Skills loading priority

1. `<workspace>/skills/` — highest priority
2. `~/.openclaw/skills/` — user-installed
3. `<install>/skills/` — bundled (ships with openclaw)

Install path: `$(npm root -g)/openclaw/skills/`

## Gateway

```bash
openclaw gateway status|start|stop|restart
```

Default port: `18789`
Log: `/tmp/openclaw/openclaw-YYYY-MM-DD.log` (rolling daily, JSON lines)
Config: `openclaw.json` → `gateway` key

## openclaw.json top-level keys

`agent` · `agents` · `models` · `routing` · `channels` · `messages` · `session` · `tools` · `browser` · `skills` · `audio` · `talk` · `gateway` · `hooks` · `cron` · `ui` · `logging` · `identity` · `bindings` · `discovery` · `plugins` · `env` · `web`

Edit interactively: `openclaw configure` (most changes hot-reload automatically)

## ACP bridge (IDE integration)

Connects Claude Code, Cursor, Windsurf to the OpenClaw Gateway via stdio.

```bash
openclaw acp                              # local Gateway
openclaw acp --url wss://host:18789       # remote Gateway
openclaw acp --session agent:main:main    # attach to specific session
```

## Logging

| What | Where |
|---|---|
| Gateway runtime | `/tmp/openclaw/openclaw-YYYY-MM-DD.log` (rolling daily, JSON lines) |
| Cron runs | `~/.openclaw/cron/runs/<jobId>.jsonl` |
| Sessions | `~/.openclaw/agents/<agentId>/sessions/<sessionId>.jsonl` |

## CLI quick reference

```bash
openclaw status          # health check
openclaw doctor          # diagnose common issues
openclaw configure       # interactive config wizard
openclaw setup           # initialize/repair workspace
openclaw cron list       # list cron jobs
openclaw skills list     # list available skills
openclaw sessions list   # list active sessions
openclaw gateway status  # gateway daemon status
```
