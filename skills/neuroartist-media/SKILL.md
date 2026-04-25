---
name: neuroartist-media
description: Generate, edit, animate, and iterate on AI images/videos through the Neuroartist API using the `na` CLI. Use when the user asks for Neuroartist media generation, text-to-image, image-to-image, text-to-video, image-to-video, model discovery, cost estimates, queue status, or result downloads.
version: "1.0.0"
license: MIT
compatibility: Works with Cursor, Claude Code, Codex, OpenCode, OpenClaw/OpenCloud-style clients, Windsurf, Gemini CLI, and other Agent Skills compatible clients. Requires the Neuroartist `na` CLI, network access, and a configured Neuroartist API key.
metadata:
  author: neuroartist
  version: "1.0.0"
  category: media-generation
  tags: neuroartist,image-generation,video-generation,cli,api,queue
  homepage: https://github.com/CroissanStudioDev/neuroartist-api-skill
  repository: https://github.com/CroissanStudioDev/neuroartist-api-skill
---

# Neuroartist Media

Use the Neuroartist CLI (`na`) as the primary interface for image and video generation. Prefer the CLI over direct HTTP because it provides stable JSON envelopes, exit codes, retries, SSE parsing, and asset downloads.

## What This Skill Does

- Finds suitable Neuroartist models for image/video tasks.
- Reads model schemas before building inputs.
- Estimates credits before expensive generations.
- Runs image and short jobs with `na run`.
- Runs video and long jobs with `na queue`.
- Downloads generated assets and returns local paths plus public URLs.

## Required Workflow

1. Parse the request: media type, prompt, input image/video URL or file, aspect ratio, duration, quality, output folder, deadline, and whether this is a cheap draft or final render.
2. Check CLI readiness when needed: `na doctor --json`, `na auth status --json`, or `na commands --json`.
3. Discover the model if the user did not name one: `na models list --json` with a search term.
4. Read the model contract before using unfamiliar inputs: `na models schema <modelId> --json`.
5. Build inputs from the schema. Do not guess parameter names when the schema is available.
6. Estimate cost before expensive video, batch, or final-quality runs: `na models estimate <modelId> -i key=value --json`.
7. Execute with the right transport:
   - Use `na run <modelId> ... --json` for images and short jobs where waiting is reasonable.
   - Use `na queue submit`, `na queue stream --json`, and `na queue result` for videos, slow models, or resumable jobs.
8. Return a concise result: model, request id if any, final status, local paths, public URLs, cost/credits if present, seed/metadata if present, and a useful regeneration command.

## Command Rules

- Always add `--json` for commands that support the stable envelope.
- Use `-q` when scripting and stderr progress is noisy.
- Use `-y` or `CI=true` for non-interactive automation.
- Keep stdout machine-readable. CLI progress and debug output belongs on stderr.
- Use named `-i key=value` inputs or `--input-file body.json`; never rely on positional payloads.
- Save generated assets with `-o <dir>` when the user asks for files or downstream work needs local paths.
- Treat `na queue submit` as non-idempotent: do not retry blindly after an unknown submit result.

## Run vs Queue

Use `na run` when:

- The output is an image or a short synchronous task.
- The user asked for one quick result and can wait.
- You want automatic wait and asset download in one command.

Use `na queue` when:

- The output is video or a long-running model.
- The user asks for async behavior, progress, status, cancellation, or resumability.
- A timeout would be expensive or likely.
- You need lifecycle events with `na queue stream <modelId> <requestId> --json`.

## Error Handling

Use CLI exit codes and JSON error fields:

- Exit `3` or `error.code` like `no_api_key`: ask the user to run `na auth login` or provide a configured profile.
- Exit `4` or `error.retryable: true`: retry with short backoff, except after uncertain `queue submit`.
- `insufficient_balance`: report the estimate and ask the user to top up before retrying.
- 4xx input/schema errors: re-read `na models schema <modelId> --json` and rebuild the input.
- Timeout after submit: keep the `requestId` and use `queue status`, `queue stream`, or `queue result`.

## Reference Files

Load these only when needed:

- `references/prompting.md` for image/video prompt structure and repair.
- `references/model-selection.md` for model discovery, schema mapping, and cost estimates.
- `references/workflows.md` for step-by-step generation recipes.
- `references/examples.md` for copyable commands and response patterns.
- `references/install.md` for installation, verification, and marketplace packaging.
