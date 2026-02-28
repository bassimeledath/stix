# /animate

A Claude Code skill that generates stick figure animations from natural language prompts.

```
/animate "a person waving hello"
```

Outputs: `.animate/output/animation.gif` + `.animate/output/animation.mp4`

## Installation

```bash
git clone https://github.com/bassimeledath/animate ~/.claude/skills/animate
```

## Dependencies

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (with `claude` CLI)
- [agent-browser](https://github.com/anthropics/agent-browser) — headless browser for screenshot capture
- [ffmpeg](https://ffmpeg.org/) — frame stitching

## How It Works

1. **Parameter inference** — parses your prompt to determine scene count, mood, FPS
2. **Story decomposition** — breaks the prompt into scenes with characters, poses, and props
3. **Parallel scene generation** — spawns Opus workers to generate HTML/CSS animations
4. **Visual QC** — captures keyframe screenshots, Sonnet reviews against a rubric, auto-fixes failures
5. **Frame capture + stitch** — `agent-browser` captures frames, `ffmpeg` stitches into GIF/MP4

## Examples

```
# Simple (1 scene)
/animate "a person waving hello"

# Medium (2-3 scenes)
/animate "a cat chasing a mouse across a park"

# Complex (3-4 scenes)
/animate "a person sitting sadly, then going to the gym, then walking confidently"
```

## Output

Files are written to `.animate/output/` in the current working directory:

| File | Format | Typical Size |
|------|--------|-------------|
| `animation.gif` | Animated GIF | 200-400KB |
| `animation.mp4` | H.264 MP4 | 50-150KB |

## Component Library

The skill includes a curated library of SVG components:

- **15 named poses** — standing, walking, running, sitting, jumping, dancing, etc.
- **8 facial expressions** — happy, sad, neutral, surprised, determined, angry, laughing, crying
- **17 props** — bench, table, heart, barbell, sun, cloud, tree, pizza, salad, coffee mug, etc.
- **4 animals** — cat, dog, bird, mouse with walk cycles
- **9 transition patterns** — walk cycle, run cycle, sit down, jump, phase transition, etc.

## Architecture

```
/animate prompt
    │
    ├─ Step 1: Infer parameters (scenes, fps, mood)
    ├─ Step 2: Preflight checks (agent-browser, ffmpeg, claude)
    ├─ Step 3: Decompose into scenes → story.json
    ├─ Step 4: Generate scenes (parallel Opus workers)
    ├─ Step 5: QC loop (Sonnet review → Opus fix, max 3 iterations)
    ├─ Step 6: Capture frames → stitch with ffmpeg
    └─ Step 7: Report output paths
```
