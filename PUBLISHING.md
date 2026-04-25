# Publishing Guide

This repository is prepared as a portable Agent Skill package. The canonical skill lives at:

```text
skills/neuroartist-media/SKILL.md
```

Keep this layout stable. Many clients and registries require the containing directory name (`neuroartist-media`) to match the `name` field in `SKILL.md`.

## Universal Compatibility Checklist

Before submitting to any registry:

- `skills/neuroartist-media/SKILL.md` exists.
- `name: neuroartist-media` matches the directory name.
- `description` is plain text, specific, and under 1024 characters.
- `license: Apache-2.0` is present.
- `compatibility` describes runtime requirements and stays under 500 characters.
- `metadata` includes author, version, category, tags, homepage, and repository.
- Supporting docs are under `references/` one level deep.
- No secrets, API keys, private URLs, or user credentials are committed.
- `bash scripts/validate.sh` passes.
- GitHub Actions `Validate Skill` passes on `main`.

## Current Listing Metadata

Use these fields when a marketplace asks for manual listing data:

- Display name: NeuroArtist API Skill
- Skill slug: `neuroartist-media`
- Repository: `https://github.com/CroissanStudioDev/neuroartist-api-skill`
- Skill path: `skills/neuroartist-media`
- License: Apache-2.0
- Category: Media generation
- Tags: `neuroartist`, `image-generation`, `video-generation`, `ai-media`, `cli`, `api`, `queue`
- Requirements: Neuroartist `na` CLI, Neuroartist API key, network access
- Install command: `npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media`

Short description:

```text
Generate, edit, animate, and iterate on AI images and videos through the Neuroartist API using the agent-friendly `na` CLI.
```

Long description:

```text
NeuroArtist API Skill teaches coding agents how to use the Neuroartist CLI (`na`) for image and video generation. It covers model discovery, schema inspection, cost estimation, `na run` for image and short tasks, queue submission and SSE progress for video jobs, result downloads, and prompt construction for image/video workflows.
```

## Marketplace Matrix

| Registry or Tool | How It Finds Skills | What To Do |
| --- | --- | --- |
| Agent Skills spec (`agentskills.io`) | Any directory containing `SKILL.md`; required fields are `name` and `description`; optional `license`, `compatibility`, `metadata`, `allowed-tools` | Already compliant. Keep `skills/neuroartist-media/SKILL.md` as the canonical package and run `scripts/validate.sh`. |
| `npx skills` / skills.sh-style GitHub install | Clones GitHub repos and discovers `SKILL.md` at root, `skills/<name>/`, and common agent folders | Already verified with `npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media --list`. Submit repo URL and use the install command above. |
| Cursor Skills | Loads `.cursor/skills/<name>/SKILL.md`, `~/.cursor/skills/<name>/SKILL.md`, and compatible Claude/Codex locations | Users can install through `npx skills` or manually copy `skills/neuroartist-media` to `~/.cursor/skills/neuroartist-media`. |
| Claude Code Skills | Loads `.claude/skills/<name>/SKILL.md` and `~/.claude/skills/<name>/SKILL.md` | Users can install through `npx skills` or manually copy to `~/.claude/skills/neuroartist-media`. |
| OpenCode Skills | Loads `.opencode/skills`, `~/.config/opencode/skills`, plus `.claude/skills` and `.agents/skills`; strict name-directory matching | Current folder/name match is valid. Manual install command is in `README.md`. |
| Codex / vendor-neutral `.agents` | Many clients accept `.agents/skills/<name>/SKILL.md` as a portable project location | For teams using several agents, copy `skills/neuroartist-media` to `.agents/skills/neuroartist-media`. |
| Agent Skill Hub / `skhub` | Imports public GitHub repos and detects `SKILL.md` files in root, subdirectories, `skills/`, `.agents/skills/`, `.claude/skills/`, `.codex/skills/` | Use the GitHub import flow with this repo URL. Select `neuroartist-media` when detected. |
| SkillRepo-style registries | Upload or import a `SKILL.md` skill; often require `version`, `description`, and optional metadata/category/tags | Frontmatter includes `version`, `license`, `compatibility`, and metadata. Use the listing fields above. |
| `mdskills.ai` | Uses SKILL.md spec; supports marketplace submission after GitHub push or CLI publish | Submit this GitHub repo and point to `skills/neuroartist-media`. If their CLI asks for a local path, use `skills/neuroartist-media`. |
| `skillpm` / npm | Expects npm package with `package.json`, `keywords` containing `agent-skill`, and `skills/<name>/SKILL.md` | `package.json` is included for npm packaging. Publish with `npm publish --access public` or `npx skillpm publish --access public` after npm ownership is confirmed. |
| GitHub `gh skill` / OCI-style tooling | Uses GitHub repos/releases or skill bundles; implementation details vary | The repo is public, versioned, and has CI validation. Use releases/tags after the first marketplace version is accepted. |
| SkillMD.ai / ZIP-style directories | Often indexes downloadable `SKILL.md` content and examples | Use the repo URL and the long description above; the skill can also be zipped from `skills/neuroartist-media`. |

## Submission Steps by Channel

### skills.sh / `npx skills`

1. Confirm discovery:

```bash
npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media --list
```

2. Submit:
   - Repository URL: `https://github.com/CroissanStudioDev/neuroartist-api-skill`
   - Skill: `neuroartist-media`
   - Category: Media generation
   - Tags: from Current Listing Metadata
   - License: Apache-2.0

3. After approval, test normal install:

```bash
npx skills add CroissanStudioDev/neuroartist-api-skill --skill neuroartist-media
```

### Agent Skill Hub / skhub

1. Open the Agent Skill Hub add/import flow.
2. Paste `https://github.com/CroissanStudioDev/neuroartist-api-skill`.
3. Select detected skill `neuroartist-media`.
4. Install with the hub-provided slug, likely similar to:

```bash
npx skhub add <publisher>/neuroartist-media
```

Use the exact command returned by the hub after import.

### SkillRepo

1. Create or open the SkillRepo publishing UI.
2. Add a skill from GitHub or paste the `SKILL.md` content.
3. Use:
   - Path: `skills/neuroartist-media/SKILL.md`
   - Category: `media-generation`
   - Tags: `neuroartist`, `image-generation`, `video-generation`, `cli`
4. Publish only after the preview validates frontmatter.

### mdskills.ai

1. Use their create/publish flow.
2. Point to this GitHub repository or local path `skills/neuroartist-media`.
3. Keep the listing description under their field limits.
4. Re-run `scripts/validate.sh` before each submission.

### npm / skillpm

This repo includes `package.json` for npm-compatible skill distribution.

Before publishing:

1. Confirm npm package name ownership.
2. Check version in `package.json`.
3. Validate:

```bash
bash scripts/validate.sh
```

4. Optional skillpm validation/publish:

```bash
npx skillpm publish --access public
```

5. Or npm publish:

```bash
npm publish --access public
```

Users would then install via skillpm:

```bash
npx skillpm install @croissanstudio/neuroartist-api-skill
```

Do not publish to npm until the package scope and name are confirmed.

## Release Checklist

For each new public version:

1. Update `version` in `skills/neuroartist-media/SKILL.md`.
2. Update `metadata.version` in the same file.
3. Update `version` in `package.json`.
4. Run `bash scripts/validate.sh`.
5. Commit with a clear message.
6. Tag the release, for example `v1.0.1`.
7. Push `main` and the tag.
8. Re-import or resubmit in marketplaces that snapshot GitHub content.

## Why There Are No Generation Wrapper Scripts

The executable interface is the Neuroartist CLI (`na`). Extra wrapper scripts would duplicate CLI behavior, increase review surface for registries, and make future CLI changes harder to support. This package includes only validation automation; generation remains agent-driven through `na`.
