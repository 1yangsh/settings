# 초기 Mac 셋업



## 1. brew 설치
### Install Homebrew

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
### Install Brewfile

```bash
$ brew bundle --file=./Brewfile
```

## 2. zsh 설정
### Install oh-my-zsh

```bash
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### Install zsh plugins

```bash
$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
zsh 설정 - `~/.zshrc` 파일에서 설정할 수 있습니다.
```bash
$ vi ~/.zshrc
```
```shell
ZSH_THEME="arrow"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
  
alias dsr='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
```

### iterm 단어 이동 설정
- preferences: `cmd + ,`
- Keys -> Key Bindings
  - 왼쪽으로 단어 이동
    - Keyboard Shortcut: `option + ←`
    - Action: `Send Escape Sequence`
    - Esc+: `b`
  - 오른쪽 단어 이동
    - Keyboard Shortcut: `option + →`
    - Action: `Send Escape Sequence`
    - Esc+: `f`
  - 단어 삭제 
    - Keyboard Shortcut: `option + delete`
    - Action: `Send Hex Code`
    - Esc+: `0x17`
## 3. screenshot 폴더 위치 설정 
```bash
# Create a folder for screenshots on the Desktop
$ mkdir -p ~/Desktop/screenshots
```
### Set the screenshot folder location
- Press Command + Shift + 5
- Click on Options
- Now either pick a folder that is listed, or choose Other Location


## 4. git 설정

## 5. poetry 설정
poetry init 시 .venv 디렉토리를 현재 디렉토리(예: 프로젝트 루트)에 생성
```bash
$ poetry config virtualenvs.in-project true
# poetry shell
$ poetry init
$ source $(poetry env info --path)/bin/activate
```

## 6. Claude Code skills / MCP
필요: Node.js 18+, [Claude Code](https://docs.claude.com/en/docs/claude-code)

```bash
$ bash claude/install.sh
```

| 이름 | 종류 | 출처 |
|---|---|---|
| find-skills | skill | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| mcp-builder | skill | [anthropics/skills](https://github.com/anthropics/skills) |
| design-taste-frontend (taste) | skill | [leonxlnx/taste-skill](https://github.com/leonxlnx/taste-skill) |
| agent-browser | skill + CLI | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) |
| gsd | skills | [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) |
| chrome-devtools | MCP | [chrome-devtools-mcp](https://www.npmjs.com/package/chrome-devtools-mcp) |
| convert-documents-to-markdown | skill | [firecrawl/anydoc](https://github.com/firecrawl/anydoc) |
| conventional-commits | skill | 직접 작성 (`claude/skills/`) |
| claude-code-setup, claude-md-management, code-review, code-simplifier, context7, github, microsoft-docs, skill-creator, superpowers | plugin | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| ponytail | plugin | [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) |
| graphify | plugin | [pleaseai/claude-code-plugins](https://github.com/pleaseai/claude-code-plugins) |
| claude-mem | plugin | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) (bun 필요) |
| humanize-korean | plugin | [epoko77-ai/im-not-ai](https://github.com/epoko77-ai/im-not-ai) |

- GSD 설치 시 Claude Code statusline 설정이 덮어써짐
- Windows: npm 전역 경로(`%APPDATA%\npm`)가 PATH에 없으면 `agent-browser` 명령이 안 잡힘
- 설치 후 Claude Code 재시작

