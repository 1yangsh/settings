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

# 5. 추가 skill
skill firecrawl/anydoc --skill convert-documents-to-markdown
mkdir -p ~/.claude/skills && cp -r "$(dirname "$0")/skills/." ~/.claude/skills/   # 직접 만든 skill

# 6. Plugins (marketplace 등록 → 설치)
for repo in anthropics/claude-plugins-official DietrichGebert/ponytail pleaseai/claude-code-plugins thedotmack/claude-mem epoko77-ai/im-not-ai; do
  claude plugin marketplace add "$repo" || true   # 이미 등록돼 있으면 통과
done
for p in \
  claude-code-setup@claude-plugins-official claude-md-management@claude-plugins-official \
  code-review@claude-plugins-official code-simplifier@claude-plugins-official \
  context7@claude-plugins-official github@claude-plugins-official \
  microsoft-docs@claude-plugins-official skill-creator@claude-plugins-official \
  superpowers@claude-plugins-official \
  ponytail@ponytail graphify@pleaseai claude-mem@thedotmack humanize-korean@im-not-ai; do
  claude plugin install "$p" -s user -y
done

echo "완료. Claude Code를 재시작하세요."
