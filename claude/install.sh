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
skill remotion-dev/skills   # Remotion 영상 제작 스킬 묶음
mkdir -p ~/.claude/skills && cp -r "$(dirname "$0")/skills/." ~/.claude/skills/   # 직접 만든 skill

# 6. bun (claude-mem 의존성 설치에 필요. npm 11은 postinstall 허용 플래그 필요)
npm i -g --allow-scripts=bun bun

# 7. Plugins (marketplace 등록 → 설치)
for repo in anthropics/claude-plugins-official DietrichGebert/ponytail pleaseai/claude-code-plugins thedotmack/claude-mem epoko77-ai/im-not-ai google/elephant-goldfish-model#v0.1.1 \n            heygen-com/hyperframes pbakaus/impeccable f/prompts.chat affaan-m/everything-claude-code; do
  claude plugin marketplace add "$repo" || true   # 이미 등록돼 있으면 통과
done
for p in \
  claude-code-setup@claude-plugins-official claude-md-management@claude-plugins-official \
  code-review@claude-plugins-official code-simplifier@claude-plugins-official \
  context7@claude-plugins-official github@claude-plugins-official \
  microsoft-docs@claude-plugins-official skill-creator@claude-plugins-official \
  superpowers@claude-plugins-official \
  ponytail@ponytail graphify@pleaseai claude-mem@thedotmack humanize-korean@im-not-ai egm@egm \n  hyperframes@hyperframes impeccable@impeccable prompts.chat@prompts.chat ecc@ecc; do
  claude plugin install "$p" -s user -y
done

# 8. Craft Anything (데스크톱 앱/CLI, OS별 릴리스 다운로드 + SHA256 검증)
#    설치 위치: ~/.local/opt/craft-anything. Claude Code 연결은 수동: craft-anything-cli setup --client claude_code
CA_VER=0.6.1
CA_DIR="$HOME/.local/opt/craft-anything"
case "$(uname -s)-$(uname -m)" in
  Darwin-*)                    CA_FILE="craft-anything-cli-$CA_VER-macos-universal.zip" ;;  # 앱은 .dmg 수동 설치
  Linux-x86_64)                CA_FILE="craft-anything-$CA_VER-linux-x86_64.tar.gz" ;;
  Linux-aarch64|Linux-arm64)   CA_FILE="craft-anything-$CA_VER-linux-aarch64.tar.gz" ;;
  MINGW*-x86_64|MSYS*-x86_64)  CA_FILE="craft-anything-$CA_VER-windows-x64-portable.zip" ;;
  MINGW*-aarch64|MSYS*-aarch64) CA_FILE="craft-anything-$CA_VER-windows-arm64-portable.zip" ;;
  *) CA_FILE="" ; echo "Craft Anything: 지원하지 않는 OS, 건너뜀" ;;
esac
if [ -n "$CA_FILE" ]; then
  CA_URL="https://github.com/storytold/craft-anything/releases/download/v$CA_VER"
  CA_TMP=$(mktemp -d)
  curl -fsSL "$CA_URL/$CA_FILE" -o "$CA_TMP/$CA_FILE"
  curl -fsSL "$CA_URL/SHA256SUMS.txt" -o "$CA_TMP/SHA256SUMS.txt"
  (cd "$CA_TMP" && grep "  $CA_FILE$" SHA256SUMS.txt | { command -v sha256sum >/dev/null && sha256sum -c - || shasum -a 256 -c -; })
  mkdir -p "$CA_DIR"
  case "$CA_FILE" in
    *.zip)    if command -v ditto >/dev/null; then ditto -x -k "$CA_TMP/$CA_FILE" "$CA_DIR"; else unzip -oq "$CA_TMP/$CA_FILE" -d "$CA_DIR"; fi ;;
    *.tar.gz) tar -xzf "$CA_TMP/$CA_FILE" -C "$CA_DIR" ;;
  esac
  rm -rf "$CA_TMP"
  echo "Craft Anything 설치: $CA_DIR"
fi

# 9. Python CLI (uv tool): MarkItDown, Agent-Reach
if ! command -v uv >/dev/null; then
  case "$(uname -s)" in
    MINGW*|MSYS*) powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex" ;;
    *)            curl -LsSf https://astral.sh/uv/install.sh | sh ;;
  esac
  export PATH="$HOME/.local/bin:$PATH"
fi
uv tool install 'markitdown[all]'
# PyPI의 agent-reach는 다른 프로젝트 → 반드시 GitHub 릴리스로 설치
uv tool install https://github.com/Panniantong/Agent-Reach/releases/latest/download/agent-reach.zip
"$(uv tool dir --bin)/agent-reach" setup >/dev/null   # 기본 채널 + Claude 스킬 등록 (JSON 출력 생략)

echo "완료. Claude Code를 재시작하세요."
