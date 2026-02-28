# skill-openclaw-map

[English](README.md) | **繁體中文**

給 coding agent 一張完整的 [OpenClaw](https://openclaw.ai) 環境地圖，涵蓋 config、log、cron job、session、skill、文件等，讓它不用從頭摸索就能直接上手修改。

## 適用對象

任何用 coding agent（GitHub Copilot、Claude Code、Cursor、Codex 等）來操作 OpenClaw 的人。裝好這個 skill，agent 就立刻掌握整個檔案結構。

## 安裝

本 repo 遵循 [Agent Skills](https://agentskills.io/) 開放標準。

1. **`cd` 到 OpenClaw 主目錄**

   ```bash
   cd ~/.openclaw
   ```

2. **Clone 這個 repo 到你 agent 的專案層級 skills 目錄**

   | Agent | 指令 |
   |---|---|
   | Claude Code | `git clone https://github.com/wsxqaza12/skill-openclaw-map .claude/skills/openclaw-map` |
   | Cursor | `git clone https://github.com/wsxqaza12/skill-openclaw-map .cursor/skills/openclaw-map` |
   | Codex | `git clone https://github.com/wsxqaza12/skill-openclaw-map .codex/skills/openclaw-map` |
   | GitHub Copilot | [Custom Instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot) |

3. **用 coding agent 打開 `~/.openclaw/` 開始工作**

   用 coding agent 打開 `~/.openclaw/`，它會自動發現這個 skill，並用它來定位所有需要的東西。

## 涵蓋內容

- `~/.openclaw/` 目錄結構
- Agent workspace 與 bootstrap 檔案（`AGENTS.md`、`SOUL.md` 等）
- Session 記錄路徑
- Cron job 格式與 CLI 指令
- Skills 載入優先順序
- Gateway daemon 管理
- Log 檔位置
- 如何在任何作業系統上找到 OpenClaw 內建文件

## 維護

內容為靜態。每週會有 [GitHub Action](.github/workflows/check-drift.yml) 自動檢查最新版 OpenClaw 的結構變化，發現差異時會自動開 issue。

更新流程：
1. 更新 `references/environment.md`
2. 執行 `scripts/update-baseline.sh` 更新 baseline
3. 開 PR
