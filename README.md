# skill-openclaw-map

An [OpenClaw](https://openclaw.ai) skill that gives coding agents a map of the OpenClaw environment — so they know where config, logs, cron jobs, sessions, skills, and docs live without having to explore from scratch.

## Who is this for

Anyone using a coding agent (GitHub Copilot, Claude Code, Cursor, Windsurf, etc.) to modify or debug an OpenClaw installation. This skill is a static knowledge pack — install it into your coding agent and it instantly knows the full OpenClaw file structure.

## Install

1. **Clone this repo**

   ```bash
   git clone https://github.com/wsxqaza12/skill-openclaw-map
   ```

2. **Add the skill to your coding agent**

   Each agent has its own way to load skills / custom instructions. Place or reference this skill folder according to your agent's docs:

   | Agent | Docs |
   |---|---|
   | GitHub Copilot (VS Code) | [Custom Instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot) |
   | Claude Code | [Custom Instructions](https://docs.anthropic.com/en/docs/claude-code/settings#settings-files-and-format) |
   | Cursor | [Rules](https://docs.cursor.com/context/rules-for-ai) |
   | Windsurf | [Rules](https://docs.windsurf.com/windsurf/customize#rules) |

3. **Open `~/.openclaw/` in your coding agent and start working**

   用 coding agent 打開 `~/.openclaw/`，agent 會根據 skill 提供的地圖知道所有東西在哪。

## What it covers

- `~/.openclaw/` directory layout
- Agent workspace + bootstrap files (`AGENTS.md`, `SOUL.md`, etc.)
- Session transcript paths
- Cron job format and CLI commands
- Skills loading priority
- Gateway daemon management
- All log file locations
- How to find local OpenClaw docs on any OS

## Maintenance

Content is static. When OpenClaw ships breaking changes to its file structure, update `references/environment.md` and open a PR.
