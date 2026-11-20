# settings

새 개발 환경을 빠르게 맞추기 위한 개인 설정 모음.

| 폴더 | 내용 | 대상 OS |
|---|---|---|
| [`brew/`](brew/README.md) | Homebrew 패키지 목록 (`Brewfile`, `CompanyBrewfile`) | macOS |
| [`claude/`](claude/README.md) | Claude Code skills · plugins · MCP 일괄 설치 스크립트 | macOS · Linux · Windows |

**목차**
1. [Homebrew](#1-homebrew)
2. [zsh](#2-zsh)
3. [iTerm2 단어 단위 이동](#3-iterm2-단어-단위-이동)
4. [스크린샷 저장 폴더](#4-스크린샷-저장-폴더)
5. [Poetry](#5-poetry)
6. [Claude Code](#claude-code)

---

## macOS 초기 셋업

### 1. Homebrew

```bash
# Homebrew 설치
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Brewfile의 패키지 일괄 설치
brew bundle --file=./brew/Brewfile
```

Brewfile 갱신·정리 방법은 [`brew/README.md`](brew/README.md) 참고.

### 2. zsh

```bash
# oh-my-zsh 설치
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 플러그인 설치
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

`~/.zshrc`에 아래 내용을 반영한다.

```shell
ZSH_THEME="arrow"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# 모든 Docker 컨테이너 중지 후 삭제
alias dsr='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
```

### 3. iTerm2 단어 단위 이동

`cmd + ,` → **Keys** → **Key Bindings**에서 추가한다.

| 동작 | Keyboard Shortcut | Action | 값 |
|---|---|---|---|
| 왼쪽 단어로 이동 | `option + ←` | Send Escape Sequence | Esc+ `b` |
| 오른쪽 단어로 이동 | `option + →` | Send Escape Sequence | Esc+ `f` |
| 앞 단어 삭제 | `option + delete` | Send Hex Code | `0x17` |

### 4. 스크린샷 저장 폴더

```bash
mkdir -p ~/Desktop/screenshots
```

`cmd + shift + 5` → **옵션** → **기타 위치…**에서 위 폴더를 선택한다.

### 5. Poetry

가상환경(`.venv`)을 프로젝트 루트에 만들도록 설정한다.

```bash
poetry config virtualenvs.in-project true
poetry init
source $(poetry env info --path)/bin/activate
```

---

## Claude Code

skills · plugins · MCP · 관련 CLI를 한 번에 설치한다. macOS · Linux · Windows(Git Bash)에서 동일하게 동작한다.

**필요:** Node.js 18+, [Claude Code](https://docs.claude.com/en/docs/claude-code), git, curl
(`uv`는 없으면 스크립트가 설치한다)

```bash
bash claude/install.sh
```

설치가 끝나면 **Claude Code를 재시작**한다. 항목별 설명은 [`claude/README.md`](claude/README.md) 참고.

### 설치 항목

**기본 설정** (기존 값은 덮어쓰지 않음)

| 파일 | 반영 방식 | 내용 |
|---|---|---|
| [`claude/CLAUDE.md`](claude/CLAUDE.md) → `~/.claude/CLAUDE.md` | 파일이 **없을 때만** 복사 | 전역 규칙: 한국어 답변, 근거 기반 답변, 외부 시스템 쓰기 전 확인, 배포 전 검증 등 |
| [`claude/settings.json`](claude/settings.json) → `~/.claude/settings.json` | **없는 키만** 채움 (`settings.json.bak` 백업) | 모델(`opus[1m]`), 모델별 effort, 테마, 자동 업데이트 채널 |

**Skills**

| 이름 | 출처 |
|---|---|
| find-skills | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| mcp-builder | [anthropics/skills](https://github.com/anthropics/skills) |
| design-taste-frontend (taste) | [leonxlnx/taste-skill](https://github.com/leonxlnx/taste-skill) |
| agent-browser (+ CLI) | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) |
| gsd | [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) |
| convert-documents-to-markdown | [firecrawl/anydoc](https://github.com/firecrawl/anydoc) |
| remotion-* | [remotion-dev/skills](https://github.com/remotion-dev/skills) |
| conventional-commits | 직접 작성 ([`claude/skills/`](claude/skills)) |

**Plugins**

| 이름 | 출처 |
|---|---|
| claude-code-setup, claude-md-management, code-review, code-simplifier, context7, github, microsoft-docs, skill-creator, superpowers | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| ponytail | [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) |
| graphify | [pleaseai/claude-code-plugins](https://github.com/pleaseai/claude-code-plugins) |
| claude-mem | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) |
| humanize-korean | [epoko77-ai/im-not-ai](https://github.com/epoko77-ai/im-not-ai) |
| egm (Elephant-Goldfish Model) | [google/elephant-goldfish-model](https://github.com/google/elephant-goldfish-model) |
| hyperframes | [heygen-com/hyperframes](https://github.com/heygen-com/hyperframes) |
| impeccable | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) |
| prompts.chat | [f/prompts.chat](https://github.com/f/prompts.chat) |
| ecc (everything-claude-code) | [affaan-m/ECC](https://github.com/affaan-m/ECC) |

**MCP**

| 이름 | 출처 |
|---|---|
| chrome-devtools | [chrome-devtools-mcp](https://www.npmjs.com/package/chrome-devtools-mcp) |

**CLI · 앱**

| 이름 | 설치 방식 | 출처 |
|---|---|---|
| bun | npm 전역 (claude-mem 의존성용) | [npm bun](https://www.npmjs.com/package/bun) |
| MarkItDown | `uv tool` | [microsoft/markitdown](https://github.com/microsoft/markitdown) |
| Agent-Reach | `uv tool` (GitHub 릴리스) | [Panniantong/Agent-Reach](https://github.com/Panniantong/Agent-Reach) |
| Craft Anything | OS별 릴리스 다운로드 → `~/.local/opt/craft-anything` | [storytold/craft-anything](https://github.com/storytold/craft-anything) |

### 설치 후 직접 할 일

| 항목 | 방법 |
|---|---|
| Claude 로그인 | `claude` 실행 후 `/login` |
| github 플러그인 토큰 | 플러그인이 환경변수 `GITHUB_PERSONAL_ACCESS_TOKEN`을 Bearer 토큰으로 쓴다. 없으면 연결 실패(`Authorization header is badly formatted`). 아래처럼 설정 후 Claude Code 재시작 (미검증) |
| Craft Anything 연결 (선택) | `craft-anything-cli setup --client claude_code` |
| 권한 허용 목록 (선택) | 몇 번 사용한 뒤 `/fewer-permission-prompts` 실행 → 자주 쓰는 읽기 전용 명령을 허용 목록으로 추가 |

```bash
# macOS / Linux: ~/.zshrc 또는 ~/.bashrc 에 추가 (gh CLI 로그인 상태 기준)
export GITHUB_PERSONAL_ACCESS_TOKEN="$(gh auth token)"
```

```powershell
# Windows: 사용자 환경변수로 저장 (gh CLI 로그인 상태 기준)
setx GITHUB_PERSONAL_ACCESS_TOKEN "$(gh auth token)"
```

### 주의사항

- **GSD**: 설치 시 Claude Code statusline 설정을 덮어쓴다.
- **ECC**: 자체 훅(`standard` 프로필)이 켜진다. 다른 플러그인 훅과 겹치면 `/plugin configure ecc@ecc`에서 끈다.
- **prompts.chat**: 원격 MCP(`prompts.chat/api/mcp`)로 검색어가 외부에 전송된다.
- **Agent-Reach**: PyPI의 `agent-reach`는 다른 프로젝트다. 반드시 GitHub 릴리스로 설치한다(스크립트가 처리).
- **Craft Anything**: macOS는 CLI만 설치되며 앱(`.dmg`)은 직접 설치한다. Claude Code 연결은 자동으로 하지 않으므로 필요하면 `craft-anything-cli setup --client claude_code`를 실행한다.
- **비밀정보 금지**: 이 레포는 공개 레포다. `~/.claude`의 `.credentials.json`, `settings.local.json`, `history.jsonl`, `projects/`(메모리 포함), 회사용 MCP 설정은 올리지 않는다(`.gitignore`에 등록).
- **Windows**: npm 전역 경로(`%APPDATA%\npm`)가 PATH에 없으면 `agent-browser`·`bun`을 찾지 못한다(claude-mem이 bun을 못 찾음). 사용자 PATH에 추가한다.
