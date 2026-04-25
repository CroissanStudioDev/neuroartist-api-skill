# Examples

Copy these patterns and adjust model IDs and input names after reading `na models schema <modelId> --json`.

## User Request: Generate a Product Image

User:

```text
Generate a square image for a premium smart watch ad.
```

Agent flow:

```bash
na models list --search "product image" --limit 10 --json
na models schema <modelId> --json
na models estimate <modelId> \
  -i prompt="Minimalist product poster for a black smart watch on a pale stone surface, centered composition, soft studio lighting, monochrome palette, clean negative space" \
  -i aspect_ratio="1:1" \
  --json
na run <modelId> \
  -i prompt="Minimalist product poster for a black smart watch on a pale stone surface, centered composition, soft studio lighting, monochrome palette, clean negative space" \
  -i aspect_ratio="1:1" \
  -o ./out/neuroartist/smart-watch \
  --json
```

Return:

```text
Generated with <modelId>. Saved to ./out/neuroartist/smart-watch. Public URL: <url>.
```

## User Request: Create a Cinematic Video

User:

```text
Create a 5 second cinematic video of a futuristic city at sunrise.
```

Agent flow:

```bash
na models list --search "text to video cinematic" --limit 10 --json
na models schema <modelId> --json
na models estimate <modelId> \
  -i prompt="Cinematic wide shot of a futuristic city at sunrise. A slow drone camera glides forward between glass towers while soft morning haze moves through the streets. Warm gold highlights, cool blue shadows, realistic scale, smooth continuous motion, no cuts, no text, no logos." \
  -i duration="5s" \
  -i aspect_ratio="16:9" \
  --json
na queue submit <modelId> \
  -i prompt="Cinematic wide shot of a futuristic city at sunrise. A slow drone camera glides forward between glass towers while soft morning haze moves through the streets. Warm gold highlights, cool blue shadows, realistic scale, smooth continuous motion, no cuts, no text, no logos." \
  -i duration="5s" \
  -i aspect_ratio="16:9" \
  --json
na queue stream <modelId> <requestId> --json
na queue result <modelId> <requestId> -o ./out/neuroartist/city-video --json
```

Return:

```text
Video completed with <modelId>. Request ID: <requestId>. Saved to ./out/neuroartist/city-video. URL: <url>.
```

## User Request: Animate This Image

User:

```text
Turn this image into a subtle 5 second video with a slow camera push.
```

Agent flow:

```bash
na models list --search "image to video" --limit 10 --json
na models schema <modelId> --json
na models estimate <modelId> \
  -i image_url="https://example.com/source.png" \
  -i prompt="Preserve the exact source image identity, composition, outfit, face, and lighting. Add a slow camera push in, subtle atmospheric movement, and gentle background motion. Single continuous shot, no cuts, no added text." \
  -i duration="5s" \
  --json
na queue submit <modelId> \
  -i image_url="https://example.com/source.png" \
  -i prompt="Preserve the exact source image identity, composition, outfit, face, and lighting. Add a slow camera push in, subtle atmospheric movement, and gentle background motion. Single continuous shot, no cuts, no added text." \
  -i duration="5s" \
  --json
```

## User Request: Estimate Before Running

User:

```text
How much will it cost to generate three 10 second videos?
```

Agent flow:

```bash
na models schema <modelId> --json
na models estimate <modelId> \
  -i prompt="..." \
  -i duration="10s" \
  --json
```

Then multiply by 3 only if the estimate is per generation and `num_outputs` is not part of the same model input. Prefer a real estimate with `num_outputs=3` if the schema supports it.

## User Request: Continue a Previous Job

User:

```text
Check request abc123 for model my-video-model.
```

Agent flow:

```bash
na queue status my-video-model abc123 --json
na queue result my-video-model abc123 -o ./out/neuroartist/abc123 --json
```

If still running:

```bash
na queue stream my-video-model abc123 --json
```

## Error Response Pattern

When `na` returns an error envelope:

```text
I could not start the generation because Neuroartist returned `<error.code>`: <error.message>. Suggested fix: <error.hint>.
```

For retryable errors:

```text
The request hit a transient error. I will retry once after a short backoff unless this was an uncertain queue submit.
```
