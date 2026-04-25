# Workflows

These recipes assume `na` is installed and authenticated. Add `--profile <name>` or `--base-url <url>` when using a non-default environment.

## Preflight

Use when the environment is unknown:

```bash
na doctor --json
na auth status --json
na commands --json
```

Use `na commands --json` as the source of truth if a command or flag differs from this reference.

## Text to Image

1. Search and inspect:

```bash
na models list --search "text to image" --limit 20 --json
na models schema <modelId> --json
```

2. Estimate if final-quality or batch:

```bash
na models estimate <modelId> \
  -i prompt="Minimalist product poster for a smart watch" \
  -i aspect_ratio="1:1" \
  --json
```

3. Generate and download:

```bash
na run <modelId> \
  -i prompt="Minimalist product poster for a smart watch on a pale stone surface, centered composition, soft studio lighting" \
  -i aspect_ratio="1:1" \
  -o ./out/neuroartist \
  --json
```

## Image to Image

1. Confirm the model supports an image input:

```bash
na models schema <modelId> --json
```

2. Generate using the schema's image field:

```bash
na run <modelId> \
  -i prompt="Keep the same subject and composition. Change the scene to a clean monochrome editorial studio." \
  -i image=@./source.png \
  -o ./out/neuroartist \
  --json
```

If the schema requires a public URL instead of a data URL, use:

```bash
na run <modelId> \
  -i prompt="Preserve identity and animate only the background lighting." \
  -i image_url="https://example.com/source.png" \
  -o ./out/neuroartist \
  --json
```

## Text to Video

Use queue mode by default.

1. Search, inspect, and estimate:

```bash
na models list --search "text to video" --limit 20 --json
na models schema <modelId> --json
na models estimate <modelId> \
  -i prompt="Cinematic wide shot of a futuristic city at sunrise, slow drone glide forward, warm haze, no text" \
  -i duration="5s" \
  -i aspect_ratio="16:9" \
  --json
```

2. Submit:

```bash
na queue submit <modelId> \
  -i prompt="Cinematic wide shot of a futuristic city at sunrise, slow drone glide forward, warm haze, no text" \
  -i duration="5s" \
  -i aspect_ratio="16:9" \
  --json
```

3. Stream progress:

```bash
na queue stream <modelId> <requestId> --json
```

4. Fetch result and download assets:

```bash
na queue result <modelId> <requestId> -o ./out/neuroartist --json
```

## Image to Video

1. Inspect schema and identify the image field.
2. Estimate with the real duration and aspect ratio.
3. Submit through queue:

```bash
na queue submit <modelId> \
  -i image_url="https://example.com/source.png" \
  -i prompt="Preserve the source image identity and composition. Camera slowly pushes in while soft wind moves the hair and background lights shimmer. Single continuous shot, no cuts, no text." \
  -i duration="5s" \
  -i aspect_ratio="16:9" \
  --json
```

## Draft to Final

1. Generate a cheaper draft with lower resolution, shorter duration, or fast model settings when available.
2. Keep the winning prompt and seed if the schema supports it.
3. Re-run with final model/quality after estimating cost.

## Batch Variations

Before batch generation:

- Estimate total cost.
- Keep variation count small.
- Use different seeds or small prompt deltas, not unrelated prompts.

Example:

```bash
na run <modelId> \
  -i prompt="Luxury black perfume bottle on black glass, rim lighting, premium product photography" \
  -i num_images=3 \
  -o ./out/neuroartist/perfume-variations \
  --json
```

## Resume by Request ID

If a job was already submitted:

```bash
na queue status <modelId> <requestId> --json
na queue stream <modelId> <requestId> --json
na queue result <modelId> <requestId> -o ./out/neuroartist --json
```

Do not submit a duplicate unless the user explicitly wants another generation.
