---
name: conventional-commits
description: Conventional Commits 1.0.0 규약으로 git 커밋 메시지를 작성·검토한다. git commit 메시지 작성, 커밋 메시지 리뷰, 커밋 분리, SemVer 버전 결정, CHANGELOG 생성 시 사용. 트리거 — "커밋해줘", "커밋 메시지", "commit message", "conventional commits", "feat/fix 접두어".
---

# Conventional Commits 1.0.0

근거: https://www.conventionalcommits.org/ko/v1.0.0/ (CC BY 3.0)
Microsoft Engineering Playbook도 이 규약을 권장한다.

## 형식

```
<type>[(scope)][!]: <description>

[body]

[footer(s)]
```

## 규칙 (스펙 요약)

1. 접두어 = `type` + 선택 `(scope)` + 선택 `!` + **필수 `: `(콜론+공백)**.
2. `feat` = 새 기능 추가, `fix` = 버그 수정.
3. scope는 영향 영역을 나타내는 명사를 괄호로 감싼다. 예: `fix(parser):`
4. description은 `: ` 바로 뒤에 쓰는 짧은 요약이다.
5. body는 description 다음에 **빈 줄 하나**를 두고 시작한다. 형식은 자유이고 여러 단락이어도 된다.
6. footer는 body 다음에 빈 줄을 두고 쓴다. 형식은 `Token: value` 또는 `Token #value`.
   - 토큰에서 공백 대신 `-`를 쓴다(`Reviewed-by`, `Co-Authored-By`). 예외는 `BREAKING CHANGE`.
   - 값에는 공백·줄바꿈이 들어갈 수 있고, 다음 토큰이 나오면 끝난다.
7. **Breaking change**는 둘 중 하나로 표시한다.
   - 접두어에 `!`: `feat(api)!: ...`
   - footer에 `BREAKING CHANGE: <설명>` (`BREAKING-CHANGE`도 같은 뜻)
8. `feat`/`fix` 외 타입도 쓸 수 있다.
9. `BREAKING CHANGE` 외 요소는 대소문자를 구분하지 않는다. 그래도 **소문자로 통일**한다.

## 타입 (feat/fix 외는 관례)

| type | 용도 | SemVer |
|---|---|---|
| `feat` | 새 기능 | MINOR |
| `fix` | 버그 수정 | PATCH |
| `docs` | 문서만 변경 | - |
| `style` | 포맷·공백 등 동작 무관 | - |
| `refactor` | 기능·버그 변화 없는 구조 개선 | - |
| `perf` | 성능 개선 | - |
| `test` | 테스트 추가·수정 | - |
| `build` | 빌드 시스템·의존성 | - |
| `ci` | CI 설정 | - |
| `chore` | 기타 잡무(소스·테스트 무관) | - |
| `revert` | 커밋 되돌림 | - |

`!` 또는 `BREAKING CHANGE`가 있으면 타입과 상관없이 **MAJOR**다.

## 작성 지침

- 제목 줄은 **50자 내외**, body는 **72자**에서 줄바꿈한다(MS Playbook 기준).
- description은 명령형·현재형으로 쓰고 끝에 마침표를 찍지 않는다. 예: `add`, `fix`, `remove`
- body에는 **왜** 바꿨는지와 **무슨 영향**이 있는지 쓴다. 무엇을 바꿨는지는 diff에 이미 있다.
- 한 커밋에는 한 가지 목적만 담는다. 여러 타입에 걸치면 **커밋을 나눈다**.
- 언어(영어/한국어)와 scope 목록은 **해당 저장소의 기존 `git log`를 먼저 보고 맞춘다**. 이력이 없으면 type은 영어, description은 사용자 요청 언어로 쓴다.
- revert는 `revert:` 타입으로 쓰고 footer에 `Refs: <원본 SHA>`를 남긴다.
- 이슈 연결은 footer에 `Refs: #123`으로 쓴다. Azure DevOps는 `#ID`를 Work Item에 자동 연결한다.
- 시스템이 지정한 attribution 트레일러(`Co-Authored-By: ...`)는 footer 맨 끝에 유지한다.

## 예시

```
feat(lang): add Polish language
```

```
feat!: send an email to customer when product shipped
```

```
fix(etl): prevent duplicate rows on rerun

Rerunning the same date appended rows instead of replacing the
partition, doubling keys in downstream reports.

Refs: #482
Co-Authored-By: Claude Opus 5.5 (1M context) <noreply@anthropic.com>
```

```
feat(config): allow config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for
extending other config files
```

```
revert: let us never again speak of the noodle incident

Refs: 676104e, a215868
```

## 검증 정규식 (제목 줄)

```
^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\([a-z0-9._-]+\))?!?: \S.*$
```
