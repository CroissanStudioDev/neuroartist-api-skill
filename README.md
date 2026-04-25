# NeuroArtist API Skill

Portable Agent Skill for generating images and videos through the Neuroartist API using the `na` CLI.

This repository is designed for Agent Skills compatible clients and marketplaces such as skills.sh-style `npx skills`, Cursor, Claude Code, Codex, OpenCode, OpenClaw/OpenCloud-style clients, Windsurf, Gemini CLI, and GitHub-backed skill registries.

## Skill

```text
skills/neuroartist-media/
```

The skill name is `neuroartist-media`. The directory name intentionally matches the `name` field in `SKILL.md`, which is required by strict Agent Skills clients.

## What It Does

- Discovers Neuroartist image/video models.
- Reads model schemas before building inputs.
- Estimates credits before expensive jobs.
- Uses `na run` for image and short tasks.
- Uses `na queue` for video and long-running tasks.
- Streams queue progress and fetches final results.
- Returns local asset paths, public URLs, request IDs, and regeneration commands.

## Requirements

- Neuroartist CLI: `npm install -g @neuroartist/cli`
- Neuroartist API key configured with `na auth login`
- Network access to the configured Neuroartist API
- A client that supports the Agent Skills `SKILL.md` format

## Install with `npx skills`

Install the specific skill from this repository:

```bash
npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media
```

Install from the full GitHub URL:

```bash
npx skills add https://github.com/CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media
```

Some versions of the `skills` CLI also support direct paths:

```bash
npx skills add https://github.com/CroissanStudioDev/neuroartist-api-skill/tree/main/skills/neuroartist-media
```

## Manual Install

Cursor:

```bash
mkdir -p ~/.cursor/skills
cp -R skills/neuroartist-media ~/.cursor/skills/neuroartist-media
```

Claude Code:

```bash
mkdir -p ~/.claude/skills
cp -R skills/neuroartist-media ~/.claude/skills/neuroartist-media
```

OpenAI Codex:

```bash
mkdir -p ~/.codex/skills
cp -R skills/neuroartist-media ~/.codex/skills/neuroartist-media
```

OpenCode:

```bash
mkdir -p ~/.config/opencode/skills
cp -R skills/neuroartist-media ~/.config/opencode/skills/neuroartist-media
```

OpenClaw/OpenCloud-style project install:

```bash
mkdir -p skills
cp -R skills/neuroartist-media skills/neuroartist-media
```

Restart or reload your agent client if it does not discover new skills automatically.

## CLI Setup

Install the Neuroartist CLI:

```bash
npm install -g @neuroartist/cli
na --version
```

Authenticate:

```bash
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

## Repository Layout

```text
.
├── README.md
├── LICENSE
├── scripts/
│   └── validate.sh
├── .github/
│   └── workflows/
│       └── validate.yml
└── skills/
    └── neuroartist-media/
        ├── SKILL.md
        └── references/
            ├── prompting.md
            ├── model-selection.md
            ├── workflows.md
            ├── examples.md
            └── install.md
```

## Validate

Run static package checks:

```bash
./scripts/validate.sh
```

Optional external validator, when available:

```bash
RUN_SKILLS_REF=1 ./scripts/validate.sh
```

## Publish to Marketplaces

See [PUBLISHING.md](PUBLISHING.md) for the full marketplace matrix and submission instructions for:

- `npx skills` / skills.sh-style GitHub registries
- Agent Skill Hub / `skhub`
- SkillRepo-style registries
- mdskills.ai
- npm / `skillpm`
- Cursor, Claude Code, Codex, OpenCode, and vendor-neutral `.agents/skills`

## Marketplace Listing

Suggested listing fields:

- Name: NeuroArtist API Skill
- Slug: `neuroartist-media`
- Category: Media generation
- Tags: `neuroartist`, `image-generation`, `video-generation`, `ai-media`, `cli`, `api`
- License: MIT
- Repository: `https://github.com/CroissanStudioDev/neuroartist-api-skill`
- Install command: `npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media`

Short description:

```text
Generate, edit, animate, and iterate on AI images and videos through the Neuroartist API using the agent-friendly `na` CLI.
```

## Safety

- This skill does not contain API keys or secrets.
- The skill does not run generation by itself; it teaches agents to use the installed `na` CLI.
- Expensive video and batch jobs should be estimated before submission.
- Queue submission is non-idempotent; agents should not retry uncertain submits blindly.

## License

MIT
