# NeuroArtist API Skill

[![Validate Skill](https://github.com/CroissanStudioDev/neuroartist-api-skill/actions/workflows/validate.yml/badge.svg)](https://github.com/CroissanStudioDev/neuroartist-api-skill/actions/workflows/validate.yml)
[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)
[![Agent Skill](https://img.shields.io/badge/Agent%20Skill-SKILL.md-black.svg)](https://agentskills.io/specification)

English | [Русский](README.ru.md)

Portable Agent Skill for generating, editing, animating, and iterating on AI images and videos through the Neuroartist API using the agent-friendly `na` CLI.

The skill is designed for Cursor, Claude Code, Codex, OpenCode, OpenClaw/OpenCloud-style clients, Windsurf, Gemini CLI, `npx skills`, `skillpm`, and other tools that support the Agent Skills `SKILL.md` format.

## Why Use It

Most media-generation failures in agent workflows come from guessing model inputs, using synchronous calls for long video jobs, or skipping cost checks. This skill teaches agents a safer workflow:

- discover the right Neuroartist model;
- inspect model schemas before building inputs;
- estimate credits before expensive video or batch jobs;
- use `na run` for image and short tasks;
- use `na queue` for video and long-running tasks;
- stream progress and download final assets;
- return request IDs, local paths, public URLs, and regeneration commands.

## Install

Install with `npx skills`:

```bash
npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media
```

Install from the full GitHub URL:

```bash
npx skills add https://github.com/CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media
```

Direct-path install, if your `skills` CLI version supports it:

```bash
npx skills add https://github.com/CroissanStudioDev/neuroartist-api-skill/tree/main/skills/neuroartist-media
```

## Manual Install

Copy `skills/neuroartist-media` to your agent's skills directory:

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

# Vendor-neutral project install
mkdir -p .agents/skills
cp -R skills/neuroartist-media .agents/skills/neuroartist-media
```

Restart or reload your agent client if it does not discover new skills automatically.

## Requirements

- Node.js/npm if installing the Neuroartist CLI from npm.
- Neuroartist CLI: `npm install -g @neuroartist/cli`.
- Neuroartist API key configured with `na auth login`.
- Network access to the configured Neuroartist API.
- An agent client that supports the Agent Skills `SKILL.md` format.

## CLI Setup

```bash
npm install -g @neuroartist/cli
na --version
na auth login
na doctor --json
```

For staging or custom gateways:

```bash
na --profile staging auth login --base-url https://staging.neuroartist.ru
```

## Example Agent Requests

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

## Skill Package

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

`SKILL.md` stays compact for fast activation. Detailed guidance is in `references/` and is loaded only when needed.

## Repository Layout

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

## Validate

```bash
./scripts/validate.sh
```

Optional external validator:

```bash
RUN_SKILLS_REF=1 ./scripts/validate.sh
```

## Publish

See [PUBLISHING.md](PUBLISHING.md) for submission notes for:

- `npx skills` / skills.sh-style GitHub registries;
- Agent Skill Hub / `skhub`;
- SkillRepo-style registries;
- `mdskills.ai`;
- npm / `skillpm`;
- Cursor, Claude Code, Codex, OpenCode, and vendor-neutral `.agents/skills`.

Suggested marketplace listing:

- Name: NeuroArtist API Skill
- Slug: `neuroartist-media`
- Category: Media generation
- Tags: `neuroartist`, `image-generation`, `video-generation`, `ai-media`, `cli`, `api`, `queue`
- License: Apache-2.0
- Install command: `npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media`

## Safety

- This repository does not contain API keys or secrets.
- The skill does not execute generation by itself; it teaches agents to use the installed `na` CLI.
- Expensive video and batch jobs should be estimated before submission.
- Queue submission is non-idempotent; agents should not retry uncertain submits blindly.

## License

Apache-2.0. See [LICENSE](LICENSE).
