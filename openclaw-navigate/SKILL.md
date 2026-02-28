---
name: openclaw-env
description: OpenClaw environment map for coding agents (Claude Code, Cursor, Windsurf, etc.). Use when a coding agent needs to navigate or modify an OpenClaw installation — where config, logs, cron jobs, sessions, skills, workspaces, and docs live. Triggers on questions like "where are cron jobs stored?", "where are session logs?", "how does the workspace work?", "where is the OpenClaw config?", or any task that requires understanding the OpenClaw file system structure.
---

# OpenClaw Environment

Full reference: [references/environment.md](references/environment.md)

Read it before navigating the file system. It covers:
- How to locate the OpenClaw docs on any OS (`npm root -g` method)
- `~/.openclaw/` directory layout
- Agent workspace location and bootstrap files
- Session transcript paths
- Cron job format and CLI
- Skills loading priority
- Gateway daemon management
- ACP bridge for IDE integrations
- All log file locations
- CLI quick reference

## Key facts

| What | Where |
|---|---|
| Config | `~/.openclaw/openclaw.json` |
| Gateway log | `~/.openclaw/logs/gateway.log` |
| Cron jobs | `~/.openclaw/cron/jobs.json` |
| Sessions | `~/.openclaw/agents/<agentId>/sessions/<sessionId>.jsonl` |
| Default workspace | `~/.openclaw/workspace` |
| User skills | `~/.openclaw/skills/` |
| Bundled docs | `$(npm root -g)/openclaw/docs/` |
| Online docs | https://docs.openclaw.ai |

## Common tasks

**Modify config** → edit `~/.openclaw/openclaw.json`, then `openclaw gateway restart`

**Add cron job** → `openclaw cron add --schedule "..." --task "..."`

**Install a skill** → drop `.skill` file into `~/.openclaw/skills/`

**Diagnose issues** → `openclaw doctor` or `tail -f ~/.openclaw/logs/gateway.log`
