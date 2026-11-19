#!/usr/bin/env bash
# Claude Code skills / MCP 일괄 설치 (macOS, Linux, Windows Git Bash)
# 필요: Node.js 18+, npm, claude CLI
set -euo pipefail

skill() { npx -y skills add "$@" -g -a claude-code -y; }

# 1. Skills (~/.claude/skills 에 설치)
skill vercel-labs/skills --skill find-skills
skill anthropics/skills --skill mcp-builder
skill leonxlnx/taste-skill --skill design-taste-frontend
skill vercel-labs/agent-browser

# 2. agent-browser CLI + 브라우저 (npm 11은 postinstall을 막으므로 허용 플래그 필요)
npm i -g --allow-scripts=agent-browser agent-browser
AB=$(command -v agent-browser || echo "$(npm prefix -g)/agent-browser.cmd")  # Windows: %APPDATA%\npm 가 PATH에 없을 때
"$AB" install

# 3. GSD (get-shit-done) — 상태줄(statusline) 설정도 덮어씀
npx -y get-shit-done-cc@latest --claude --global

# 4. MCP: chrome-devtools
claude mcp add chrome-devtools --scope user -- npx -y chrome-devtools-mcp@latest

echo "완료. Claude Code를 재시작하세요."
