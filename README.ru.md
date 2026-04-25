# NeuroArtist API Skill

[![Validate Skill](https://github.com/CroissanStudioDev/neuroartist-api-skill/actions/workflows/validate.yml/badge.svg)](https://github.com/CroissanStudioDev/neuroartist-api-skill/actions/workflows/validate.yml)
[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)
[![Agent Skill](https://img.shields.io/badge/Agent%20Skill-SKILL.md-black.svg)](https://agentskills.io/specification)

[English](README.md) | Русский

Переносимый Agent Skill для генерации, редактирования, анимации и итерации AI-изображений и видео через Neuroartist API с помощью agent-friendly CLI `na`.

Скилл рассчитан на Cursor, Claude Code, Codex, OpenCode, OpenClaw/OpenCloud-style клиенты, Windsurf, Gemini CLI, `npx skills`, `skillpm` и другие инструменты, которые поддерживают формат Agent Skills `SKILL.md`.

## Зачем Он Нужен

Большинство ошибок в agent workflow для медиа-генерации возникает из-за угадывания входных параметров модели, синхронных вызовов для долгих видео-задач или пропуска оценки стоимости. Этот скилл учит агента более надежному сценарию:

- находить подходящую модель Neuroartist;
- читать schema модели перед сборкой inputs;
- оценивать кредиты перед дорогими видео или batch-задачами;
- использовать `na run` для изображений и коротких задач;
- использовать `na queue` для видео и долгих задач;
- стримить прогресс и скачивать готовые ассеты;
- возвращать request ID, локальные пути, публичные URL и команды для повторной генерации.

## Установка

Установка через `npx skills`:

```bash
npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media
```

Установка по полному GitHub URL:

```bash
npx skills add https://github.com/CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media
```

Установка по прямому пути, если ваша версия `skills` CLI это поддерживает:

```bash
npx skills add https://github.com/CroissanStudioDev/neuroartist-api-skill/tree/main/skills/neuroartist-media
```

## Ручная Установка

Скопируйте `skills/neuroartist-media` в директорию скиллов вашего агента:

```bash
# Cursor
mkdir -p ~/.cursor/skills
cp -R skills/neuroartist-media ~/.cursor/skills/neuroartist-media

# Claude Code
mkdir -p ~/.claude/skills
cp -R skills/neuroartist-media ~/.claude/skills/neuroartist-media

# OpenAI Codex
mkdir -p ~/.codex/skills
cp -R skills/neuroartist-media ~/.codex/skills/neuroartist-media

# OpenCode
mkdir -p ~/.config/opencode/skills
cp -R skills/neuroartist-media ~/.config/opencode/skills/neuroartist-media

# Vendor-neutral установка в проект
mkdir -p .agents/skills
cp -R skills/neuroartist-media .agents/skills/neuroartist-media
```

Перезапустите или перезагрузите агент-клиент, если он не обнаруживает новые скиллы автоматически.

## Требования

- Node.js/npm, если Neuroartist CLI устанавливается из npm.
- Neuroartist CLI: `npm install -g @neuroartist/cli`.
- Neuroartist API key, настроенный через `na auth login`.
- Доступ к сети и выбранному Neuroartist API.
- Агент-клиент с поддержкой формата Agent Skills `SKILL.md`.

## Настройка CLI

```bash
npm install -g @neuroartist/cli
na --version
na auth login
na doctor --json
```

Для staging или кастомных gateway:

```bash
na --profile staging auth login --base-url https://staging.neuroartist.ru
```

## Примеры Запросов Агенту

```text
Use Neuroartist to generate a square product image for a premium smart watch.
```

```text
Create a 5 second cinematic text-to-video shot of a futuristic city at sunrise.
```

```text
Animate this source image with a slow camera push and preserve the character identity.
```

```text
Estimate the cost before generating three video variations.
```

## Пакет Скилла

```text
skills/neuroartist-media/
  SKILL.md
  references/
    prompting.md
    model-selection.md
    workflows.md
    examples.md
    install.md
```

`SKILL.md` остается компактным для быстрой активации. Подробные инструкции лежат в `references/` и подгружаются только когда нужны.

## Структура Репозитория

```text
.
├── README.md
├── README.ru.md
├── PUBLISHING.md
├── LICENSE
├── package.json
├── scripts/
│   └── validate.sh
├── .github/
│   └── workflows/
│       └── validate.yml
└── skills/
    └── neuroartist-media/
        ├── SKILL.md
        └── references/
```

## Валидация

```bash
./scripts/validate.sh
```

Опциональный внешний validator:

```bash
RUN_SKILLS_REF=1 ./scripts/validate.sh
```

## Публикация

См. [PUBLISHING.md](PUBLISHING.md) с инструкциями для:

- `npx skills` / skills.sh-style GitHub registries;
- Agent Skill Hub / `skhub`;
- SkillRepo-style registries;
- `mdskills.ai`;
- npm / `skillpm`;
- Cursor, Claude Code, Codex, OpenCode и vendor-neutral `.agents/skills`.

Рекомендуемые поля для marketplace listing:

- Name: NeuroArtist API Skill
- Slug: `neuroartist-media`
- Category: Media generation
- Tags: `neuroartist`, `image-generation`, `video-generation`, `ai-media`, `cli`, `api`, `queue`
- License: Apache-2.0
- Install command: `npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media`

## Безопасность

- В репозитории нет API keys или secrets.
- Скилл сам не запускает генерацию; он учит агентов пользоваться установленным CLI `na`.
- Для дорогих видео и batch-задач стоит сначала оценивать стоимость.
- Queue submission не является идемпотентным; агент не должен вслепую повторять submit с неизвестным результатом.

## Лицензия

Apache-2.0. См. [LICENSE](LICENSE).
