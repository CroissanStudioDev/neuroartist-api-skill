# Model Selection

Do not hardcode the live catalog. Neuroartist models and schemas are provider-synced, so discover what is available at execution time.

## Discovery Order

1. If the user named a model, inspect it:

```bash
na models get <modelId> --json
na models schema <modelId> --json
```

2. If the user described a task, search broadly:

```bash
na models list --search image --limit 20 --json
na models list --search video --limit 20 --json
na models list --search "image to video" --limit 20 --json
na models list --search "edit" --limit 20 --json
```

3. Pick a model using fit, cost, speed, and schema clarity.

4. Estimate cost when the run is expensive or repeated:

```bash
na models estimate <modelId> -i prompt="..." --json
```

## Selection Heuristics

For text-to-image:

- Prefer fast/cheap models for exploration and thumbnails.
- Prefer higher-fidelity models for final marketing visuals, product shots, typography, or detailed realism.
- Check whether the schema supports `image_size`, `aspect_ratio`, `num_images`, `seed`, or quality settings.

For image-to-image:

- Prefer models whose schema includes image input fields such as `image`, `image_url`, `input_image`, or a provider-specific reference field.
- Use local files with `@./file.png` only if the CLI/schema accepts data URLs for that field.
- If the API expects a public URL and local file upload is not available, ask the user for a URL or use an existing hosted asset.

For text-to-video:

- Prefer queue mode by default.
- Prefer models with explicit `duration` and `aspect_ratio` fields when the user requested them.
- Use shorter durations for first drafts.

For image-to-video:

- Start from a strong still image whenever possible.
- Preserve identity and composition in the prompt.
- Prefer models with an explicit image URL input.

## Schema Discipline

After `na models schema <modelId> --json`, map user intent only to fields present in the schema.

Common mappings, only when supported:

- Prompt text: `prompt`
- Aspect: `aspect_ratio`, `image_size`, `size`
- Duration: `duration`, `seconds`
- Count: `num_images`, `num_outputs`
- Seed: `seed`
- Input image: `image`, `image_url`, `input_image`, `reference_image`
- Quality: `quality`, `resolution`, `mode`, `num_inference_steps`

If the schema uses different field names, follow the schema.

## Cost and Balance

Estimate before:

- Any video generation.
- More than one image.
- High-resolution or final-quality output.
- Batch variations.
- A retry after a failed expensive request.

Also check balance when a cost estimate looks close to the user's available credits:

```bash
na balance --json
```

If the estimate fails because inputs are incomplete, build the smallest valid input from the schema and estimate again.

## Fallbacks

If the requested model is unavailable:

1. Search for the same modality and task.
2. Prefer a model with compatible schema fields.
3. Tell the user which model was chosen and why.
4. Do not silently switch from video to image or from image-to-video to text-to-video.
