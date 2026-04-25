# Install and Verify

This is a portable Agent Skill. The skill directory name must remain `neuroartist-media` because many agents require the directory name to match `name: neuroartist-media` in `SKILL.md`.

## Expected Layout

```text
neuroartist-media/
  SKILL.md
  references/
    prompting.md
    model-selection.md
    workflows.md
    examples.md
    install.md
```

## Install Locations

Copy the `neuroartist-media/` directory to the target agent's skill directory.

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

# OpenClaw project-local convention
mkdir -p skills
cp -R skills/neuroartist-media skills/neuroartist-media
```

Restart or reload the agent environment if your client does not pick up new skills automatically.

## Marketplace Packaging

For GitHub-backed registries such as `npx skills`/skills.sh, publish this repository and install:

```bash
npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media
```

Recommended repository shape:

```text
repo/
  README.md
  LICENSE
  skills/
    neuroartist-media/
      SKILL.md
      references/
```

Before publishing, verify:

- `SKILL.md` exists and starts with valid YAML frontmatter.
- `name` is lowercase hyphenated and matches the directory name.
- `description` clearly says what the skill does and when to use it.
- `license` is present.
- `compatibility` describes runtime requirements.
- Reference files are one level deep under `references/`.
- No API keys, secrets, or private URLs are included.

## CLI Setup

Install or update the Neuroartist CLI:

```bash
npm install -g @neuroartist/cli
na --version
```

Authenticate:

```bash
na auth login
```

For non-default environments:

```bash
na --profile staging auth login --base-url https://staging.neuroartist.ru
```

## Dry Verification

Run these before generating media:

```bash
na doctor --json
na auth status --json
na commands --json
na models list --limit 5 --json
```

A healthy setup should show:

- A configured profile or environment API key.
- API health reachable.
- A command tree containing `na models`, `na run`, and `na queue`.
- A non-empty public model catalog.

## Schema Verification

Before using a model:

```bash
na models get <modelId> --json
na models schema <modelId> --json
```

The agent should confirm the input fields it plans to use are present in the schema.

## Smoke Test: Cheap Image

Only run when the user has confirmed API key and balance:

```bash
na models list --search "image" --limit 10 --json
na models schema <modelId> --json
na models estimate <modelId> -i prompt="Simple black circle on white background" --json
na run <modelId> \
  -i prompt="Simple black circle on white background, centered, clean vector-like image" \
  -o ./out/neuroartist-smoke-image \
  --json
```

Verify the result contains at least one public URL or downloaded local path.

## Smoke Test: Queue Flow

Only run when the user has confirmed balance and accepts video cost:

```bash
na models list --search "video" --limit 10 --json
na models schema <modelId> --json
na models estimate <modelId> \
  -i prompt="A calm ocean horizon, slow camera push, gentle waves, no text" \
  -i duration="5s" \
  --json
na queue submit <modelId> \
  -i prompt="A calm ocean horizon, slow camera push, gentle waves, no text" \
  -i duration="5s" \
  --json
na queue stream <modelId> <requestId> --json
na queue result <modelId> <requestId> -o ./out/neuroartist-smoke-video --json
```

Verify the stream emits lifecycle events and the final result includes a video URL or downloaded local path.

## Safety Checks

- Do not write API keys into skill files.
- Do not paste secret values into examples.
- Do not run expensive video or batch jobs without a cost estimate.
- Do not retry uncertain `queue submit` failures without checking whether a request was created.
- Do not use direct HTTP unless the CLI is unavailable and the user explicitly approves the fallback.
