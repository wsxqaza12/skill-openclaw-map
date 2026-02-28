# skill-openclaw-map

An [OpenClaw](https://openclaw.ai) skill that gives coding agents (Claude Code, Cursor, Windsurf, etc.) a map of the OpenClaw environment — so they know where config, logs, cron jobs, sessions, skills, and docs live without having to explore from scratch.

## Who is this for

Anyone connecting a coding agent to OpenClaw via the [ACP bridge](https://docs.openclaw.ai/cli/acp). When the agent needs to modify or debug OpenClaw, this skill tells it where everything is.

## Install

```bash
# Option 1: clone directly into skills dir
git clone https://github.com/<owner>/skill-openclaw-map ~/.openclaw/skills/openclaw-map

# Option 2: copy skill files only
mkdir -p ~/.openclaw/skills/openclaw-map
cp SKILL.md ~/.openclaw/skills/openclaw-map/
cp -r references/ ~/.openclaw/skills/openclaw-map/
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

Content is static. When OpenClaw ships breaking changes to its file structure, update `references/environment.md` and open a PR.
