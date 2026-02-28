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
├── logs/
│   ├── gateway.log        # Gateway stdout (primary runtime log)
│   ├── gateway.err.log    # Gateway stderr
│   └── commands.log       # CLI command history
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
Override via `agents.defaults.workspace` in `openclaw.json`.

Bootstrap files (injected into agent context every session):
- `AGENTS.md` — operating instructions + memory
- `SOUL.md` — persona and tone
- `TOOLS.md` — tool notes (camera names, SSH hosts, etc.)
- `IDENTITY.md` — agent name, emoji, vibe
- `USER.md` — user profile
- `BOOTSTRAP.md` — one-time first-run ritual (agent deletes after)

Common conventions:
- `MEMORY.md` — long-term curated memory
- `HEARTBEAT.md` — periodic check tasks
- `memory/YYYY-MM-DD.md` — daily session logs
- `skills/` — workspace-scoped skills (highest priority)
- `state/` — runtime state files

## Sessions

```
~/.openclaw/agents/<agentId>/sessions/<sessionId>.jsonl
```

Main session: agentId = `main`

## Cron jobs

Definitions: `~/.openclaw/cron/jobs.json`

```json
{
  "id": "<uuid>",
  "label": "human-readable label",
  "schedule": { "kind": "cron", "expr": "30 7 * * *", "tz": "Asia/Taipei" },
  "task": "prompt to send to the agent",
  "agentId": "main",
  "model": "anthropic/claude-sonnet-4-6"
}
```

Run logs: `~/.openclaw/cron/runs/<jobId>.jsonl`

```bash
openclaw cron list
openclaw cron add --schedule "0 9 * * *" --task "Check emails"
openclaw cron remove <id>
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
Log: `~/.openclaw/logs/gateway.log`
Config: `openclaw.json` → `gateway` key

## openclaw.json top-level keys

`agents` · `tools` · `channels` · `skills` · `gateway` · `auth` · `hooks` · `bindings`

Edit interactively: `openclaw configure` (restart gateway to apply changes)

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
| Gateway runtime | `~/.openclaw/logs/gateway.log` |
| Gateway errors | `~/.openclaw/logs/gateway.err.log` |
| CLI commands | `~/.openclaw/logs/commands.log` |
| Cron runs | `~/.openclaw/cron/runs/<jobId>.jsonl` |
| Config audit | `~/.openclaw/logs/config-audit.jsonl` |
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
