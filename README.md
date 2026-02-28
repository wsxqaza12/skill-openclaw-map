# skill-openclaw-navigate

An [OpenClaw](https://openclaw.ai) skill that gives coding agents (Claude Code, Cursor, Windsurf, etc.) a navigation map of the OpenClaw environment — so they know where config, logs, cron jobs, sessions, skills, and docs live without having to explore from scratch.

## Who is this for

Anyone connecting a coding agent to OpenClaw via the [ACP bridge](https://docs.openclaw.ai/cli/acp). When the agent needs to modify or debug OpenClaw, this skill tells it where everything is.

## Install

```bash
cp -r openclaw-navigate/ ~/.openclaw/skills/
```

Restart your OpenClaw session to pick it up.

## What it covers

- `~/.openclaw/` directory layout
- Agent workspace + bootstrap files (`AGENTS.md`, `SOUL.md`, etc.)
- Session transcript paths
- Cron job format and CLI commands
- Skills loading priority
- Gateway daemon management
- ACP bridge setup
- All log file locations
- How to find local OpenClaw docs on any OS

## Maintenance

Content is static. When OpenClaw ships breaking changes to its file structure, update `openclaw-navigate/references/environment.md` and open a PR.
