# Claude Code skills / plugins

설치: `bash install.sh` (상위 [README](../README.md#claude-code) 참고)

## 기본 설정

| 파일 | 설명 |
|---|---|
| `CLAUDE.md` | 전역 규칙. `~/.claude/CLAUDE.md`가 없을 때만 복사된다. |
| `settings.json` | 모델·effort·테마 등 공통 기본값. `~/.claude/settings.json`에 없는 키만 채운다. |

## Skills

| 이름 | 설명 |
|---|---|
| find-skills | "X 하는 스킬 있어?" 같은 요청에 맞는 스킬을 찾아 설치해 준다. |
| mcp-builder | Python(FastMCP)·TypeScript로 MCP 서버를 만드는 가이드. |
| design-taste-frontend (taste) | 템플릿 티 안 나는 웹사이트·랜딩 페이지를 만들고 다듬는 프론트엔드 디자인 스킬. |
| agent-browser | 웹 페이지 열기·클릭·폼 입력·스크린샷·스크래핑을 하는 브라우저 자동화 CLI. |
| gsd (get-shit-done) | 프로젝트를 페이즈 단위로 기획→계획→실행→검증하는 스펙 기반 개발 워크플로우 (`/gsd-help`). |
| convert-documents-to-markdown | Word·PowerPoint·Excel·PDF·EPUB 등을 Markdown으로 변환한다. |
| conventional-commits | Conventional Commits 규약으로 커밋 메시지를 작성·검토한다 (직접 작성, `skills/`). |
| remotion-* | React 코드로 영상을 만드는 Remotion 스킬 묶음 (생성·자막·렌더·미리보기 등 13개). |

## MCP

| 이름 | 설명 |
|---|---|
| chrome-devtools | Chrome DevTools로 브라우저를 조작·디버깅·성능 측정한다. |

## Plugins

| 이름 | 설명 |
|---|---|
| superpowers | 브레인스토밍·TDD·체계적 디버깅·계획 작성 등 개발 프로세스 스킬 모음. |
| code-review | 현재 변경분이나 PR을 코드 리뷰한다. |
| code-simplifier | 최근 수정한 코드를 동작은 유지한 채 더 단순하게 정리한다. |
| claude-md-management | CLAUDE.md를 점검·개선하고 세션에서 배운 내용을 반영한다. |
| claude-code-setup | 코드베이스를 분석해 맞는 hook·skill·MCP·subagent 자동화를 추천한다. |
| skill-creator | 새 스킬을 만들고 수정·평가한다. |
| context7 | 라이브러리의 버전별 최신 문서·예제를 가져오는 MCP. |
| github | GitHub 이슈·PR·저장소를 다루는 MCP. |
| microsoft-docs | Microsoft Learn 공식 문서·코드 샘플을 검색하는 MCP와 스킬. |
| ponytail | 과설계를 피하고 최소한의 코드로 해결하도록 하는 모드. |
| graphify | 코드·문서 폴더를 질의 가능한 지식 그래프로 만든다. |
| claude-mem | 세션 간 작업 맥락을 압축·저장해 다음 세션에서 이어 쓴다 (bun 필요). |
| humanize-korean | 한국어 글의 AI 티를 진단하고 자연스럽게 윤문한다. |
| egm (Elephant-Goldfish Model) | 맥락을 다 아는 세션이 설계서를 쓰고, 맥락 없는 새 세션들이 검토하게 한다 (`/egm:`). |
| hyperframes | HTML·CSS로 영상을 만들고 렌더링하는 HeyGen HyperFrames 스킬. |
| impeccable | 프론트엔드 디자인 품질을 점검·개선하는 명령 모음 (`/impeccable`). |
| prompts.chat | prompts.chat의 공개 프롬프트·스킬을 검색해 가져온다 (원격 MCP `prompts.chat/api/mcp`). |
| ecc (everything-claude-code) | 에이전트·스킬·명령·훅을 한데 묶은 대형 세트. 자체 훅이 켜지므로 `/plugin configure ecc@ecc`로 조절. |
| andrej-karpathy-skills (karpathy-guidelines) | 과한 구현·넓은 수정·숨은 가정을 줄이는 코딩 행동 지침 (먼저 생각, 단순하게, 필요한 곳만 수정, 검증 기준 정의). |
| caveman | 군말을 빼고 짧게 답하게 하는 모드. 코드·명령·에러 원문은 그대로 둔다 (`/caveman`). 세션 시작 훅이 켜진다. |
| eli5 | 주제를 아무것도 모르는 사람에게 설명하듯, 큰 그림과 적은 글의 HTML 페이지로 풀어 준다 (`/eli5 <주제>`). |

## Apps / CLI

| 이름 | 설명 |
|---|---|
| bun | claude-mem 의존성 설치에 필요한 JS 런타임 (npm 전역 설치). |
| MarkItDown | Microsoft 공식 문서→Markdown 변환 CLI `markitdown` (uv tool). |
| Agent-Reach | GitHub·YouTube·Reddit 등을 읽기 전용으로 검색·조회하는 CLI + 스킬 (uv tool, GitHub 릴리스). |
| Craft Anything | 웹사이트·앱·게임을 분석해 비슷한 프로젝트를 새로 만들어 주는 데스크톱 앱·CLI·MCP (알파). `~/.local/opt/craft-anything`에 설치, Claude Code 연결은 `craft-anything-cli setup --client claude_code`. |
