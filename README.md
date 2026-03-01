# /stix

A coding-agent skill that generates stick figure animations from natural language prompts.

```
/stix "a person waving hello"
```

Outputs: `.stix/output/animation.gif` + `.stix/output/animation.mp4`

## Installation

### Via npx skills (recommended)
```bash
npx skills add bassimeledath/stix
```

### Via npm
```bash
npx @bassimeledath/stix
```

### Manual
```bash
# Claude Code
git clone https://github.com/bassimeledath/stix ~/.claude/skills/stix

# Codex
git clone https://github.com/bassimeledath/stix ~/.codex/skills/stix

# Other agents
git clone https://github.com/bassimeledath/stix ~/.agents/skills/stix
```

## Dependencies

- A supported AI coding agent CLI (`claude`, `codex`, or set `STIX_AGENT_CLI`)
- [agent-browser](https://github.com/anthropics/agent-browser) — headless browser for screenshot capture
- [ffmpeg](https://ffmpeg.org/) — frame stitching

## Agent Configuration

stix auto-detects your agent CLI. Override with:

```bash
# Use a specific agent
export STIX_AGENT_CLI="codex --quiet --full-auto"

# Custom agent with env vars to unset
export STIX_AGENT_CLI="my-agent --pipe"
export STIX_AGENT_ENV_UNSET="MY_AGENT_PARENT_SESSION"
```

## How It Works

stix uses an **asset-first pipeline** inspired by animation studios: characters, backgrounds, and props are generated as reusable SVG assets upfront, then scenes are composed by positioning and animating those shared assets. This guarantees visual consistency across scenes.

1. **Parameter inference** — parses your prompt to determine scene count, mood, FPS
2. **Story decomposition** — breaks the prompt into scenes with an asset manifest and per-scene position contracts
3. **Asset generation** — parallel workers create reusable SVG assets (characters, background, props)
4. **Asset validation** — each asset is rendered and screenshotted for visual inspection
5. **Scene composition** — parallel workers read shared assets, position them with `translate()`, and add CSS `@keyframes`
6. **Visual QC** — eval-based keyframe capture, review-tier workers check against a rubric, auto-fixes failures
7. **Frame capture + stitch** — `agent-browser eval` seeks to exact frame positions, `ffmpeg` stitches into GIF/MP4

## Examples

```
# Simple (1 scene)
/stix "a person waving hello"

# Medium (2-3 scenes)
/stix "a cat chasing a mouse across a park"

# Complex (3-4 scenes)
/stix "a person sitting sadly, then going to the gym, then walking confidently"
```

## Output

Files are written to `.stix/output/` in the current working directory:

| File | Format | Typical Size |
|------|--------|-------------|
| `animation.gif` | Animated GIF | 200-400KB |
| `animation.mp4` | H.264 MP4 | 50-150KB |

## Component Library

The skill includes a curated library of SVG components:

- **16 named poses** — standing, walking, running, sitting, jumping, dancing, etc.
- **9 facial expressions** — happy, sad, neutral, surprised, determined, angry, laughing, crying, smirk
- **21 props** — bench, table, heart, barbell, sun, cloud, tree, pizza, salad, coffee mug, etc.
- **4 animals** — cat, dog, bird, mouse with walk cycles
- **11 transition patterns** — walk cycle, run cycle, sit down, jump, phase transition, etc.

## Architecture

```
/stix prompt
    |
    |- Step 1: Infer parameters (scenes, fps, mood)
    |- Step 2: Preflight checks (agent-browser, ffmpeg, agent CLI)
    |- Step 3: Decompose into scenes + asset manifest -> story.json
    |
    |- Step 4: Generate assets (parallel workers)
    |   |- Characters -> .stix/assets/characters/*.svg
    |   |- Background -> .stix/assets/background.svg
    |   '- Props -> .stix/assets/props/*.svg
    |
    |- Step 5: Validate assets (render + screenshot each)
    |- Step 6: Compose scenes (parallel workers read shared assets)
    |- Step 7: QC loop (eval-based keyframe capture, review + fix)
    |- Step 8: Capture frames (eval seek + screenshot) + stitch with ffmpeg
    '- Step 9: Report output paths
```
