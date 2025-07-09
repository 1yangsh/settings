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

