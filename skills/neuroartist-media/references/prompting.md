# Prompting Reference

Use this reference to turn a vague user request into model-ready image or video inputs. Keep prompts concrete, visual, and compatible with the selected model schema.

## Universal Prompt Brief

Before generating, derive a brief with these fields:

- Goal: what the asset is for.
- Medium: image, image edit, video, or image-to-video.
- Subject: who or what appears.
- Setting: where it happens.
- Style: photo, cinematic, product, editorial, anime, 3D, sketch, UI mockup, etc.
- Composition: framing, aspect ratio, camera distance, layout.
- Quality target: draft, standard, high, or final.
- Constraints: text that must appear, brand colors, things to avoid, safety limits.

If the user supplies enough detail, do not ask extra questions. Make a reasonable choice and proceed. Ask only when the missing choice changes cost, duration, or output type.

## Image Prompt Formula

Use this structure for text-to-image and image edits:

```text
[Subject] in [setting], [composition/framing], [style], [lighting], [color/mood], [important details], [quality constraints].
```

Good image prompt:

```text
Minimalist product poster for a black smart watch on a pale stone surface, centered composition, soft studio lighting, monochrome palette, subtle reflections, premium technology advertising, clean negative space for headline.
```

Image prompt checklist:

- Name the main subject early.
- Specify composition: close-up, wide shot, centered, flat lay, three-quarter view.
- Specify lighting: softbox, golden hour, neon, overcast, rim light.
- Specify style only when it matters.
- Include text exactly if the model supports typography; otherwise ask for text-free output and add text later.
- Use `seed` only when the schema supports it and reproducibility matters.

## Image Editing Prompts

For image-to-image, preserve identity and state only the intended change.

```text
Keep the same person, pose, camera angle, and background. Change only the jacket color to deep navy blue. Preserve facial features, hands, lighting, and image resolution.
```

Use negative constraints when supported by schema:

```text
Avoid warped hands, extra fingers, duplicated faces, unreadable text, low resolution, heavy blur, watermark, logo artifacts.
```

If negative prompts are not in the schema, fold constraints into the positive prompt as "without ..." or "preserve ...".

## Video Prompt Formula

Video prompts must describe time and motion, not only a still frame:

```text
Subject: ...
Action: ...
Camera: ...
Motion: ...
Look: ...
Duration: ...
Constraints: ...
```

Compact single-prompt form:

```text
Cinematic wide shot of a futuristic city at sunrise. A slow drone camera glides forward between glass towers while soft morning haze moves through the streets. Warm gold highlights, cool blue shadows, realistic scale, smooth continuous motion, no cuts, no text, no logos.
```

Video prompt checklist:

- Include one clear action, not many competing events.
- Include camera movement: locked-off, slow dolly in, orbit, pan, tilt, handheld, FPV, drone.
- Include subject motion: walking, turning, clouds drifting, fabric moving, water rippling.
- Include continuity: "single continuous shot", "no cuts", "stable subject identity".
- Specify duration only if the schema supports it.
- Keep text-to-video prompts shorter than image prompts; motion clarity matters more than adjective density.

## Identity vs Motion

For character consistency, separate identity from motion:

Identity block:

```text
Same young woman with short black bob haircut, oval glasses, beige trench coat, calm expression, natural facial proportions.
```

Motion block:

```text
She walks through a rainy neon street, turns toward the camera, and smiles slightly as the camera slowly tracks backward.
```

Do not rewrite identity details between shots unless the user asks. For image-to-video, say "preserve the source image identity, outfit, face, and composition" before adding motion.

## Draft to Final

For uncertain creative direction:

1. Generate a cheap draft or lower-quality preview if the chosen model supports quality/resolution controls.
2. Ask the user to choose or refine.
3. Reuse the best prompt, seed, model, and input image for the final.

Do not batch expensive video variations without cost estimation.

## Prompt Repair

If results are static, add motion verbs and camera movement:

```text
Camera slowly pushes in; leaves sway in the wind; reflections ripple across the water.
```

If results drift identity, strengthen preservation:

```text
Preserve the exact same face, clothing, pose, and scene layout from the reference image.
```

If results contain artifacts, simplify the scene and reduce simultaneous actions.
