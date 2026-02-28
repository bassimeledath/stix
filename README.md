# /doodle

A coding-agent skill that generates stick figure animations from natural language prompts.

```
/doodle "a person waving hello"
```

Outputs: `.doodle/output/animation.gif` + `.doodle/output/animation.mp4`

## Installation

### Via npx skills (recommended)
```bash
npx skills add bassimeledath/doodle
```

### Via npm
```bash
npx @bassimeledath/doodle
```

### Manual
```bash
# Claude Code
git clone https://github.com/bassimeledath/doodle ~/.claude/skills/doodle

# Codex
git clone https://github.com/bassimeledath/doodle ~/.codex/skills/doodle

# Other agents
git clone https://github.com/bassimeledath/doodle ~/.agents/skills/doodle
```

## Dependencies

- A supported AI coding agent CLI (`claude`, `codex`, or set `DOODLE_AGENT_CLI`)
- [agent-browser](https://github.com/anthropics/agent-browser) — headless browser for screenshot capture
- [ffmpeg](https://ffmpeg.org/) — frame stitching

## Agent Configuration

doodle auto-detects your agent CLI. Override with:

```bash
# Use a specific agent
export DOODLE_AGENT_CLI="codex --quiet --full-auto"

# Custom agent with env vars to unset
export DOODLE_AGENT_CLI="my-agent --pipe"
export DOODLE_AGENT_ENV_UNSET="MY_AGENT_PARENT_SESSION"
```

## How It Works

1. **Parameter inference** — parses your prompt to determine scene count, mood, FPS
2. **Story decomposition** — breaks the prompt into scenes with characters, poses, and props
3. **Parallel scene generation** — spawns generation-tier workers to create HTML/CSS animations
4. **Visual QC** — captures keyframe screenshots, review-tier workers check against a rubric, auto-fixes failures
5. **Frame capture + stitch** — `agent-browser` captures frames, `ffmpeg` stitches into GIF/MP4

## Examples

```
# Simple (1 scene)
/doodle "a person waving hello"

# Medium (2-3 scenes)
/doodle "a cat chasing a mouse across a park"

# Complex (3-4 scenes)
/doodle "a person sitting sadly, then going to the gym, then walking confidently"
```

## Output

Files are written to `.doodle/output/` in the current working directory:

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
/doodle prompt
    │
    ├─ Step 1: Infer parameters (scenes, fps, mood)
    ├─ Step 2: Preflight checks (agent-browser, ffmpeg, agent CLI)
    ├─ Step 3: Decompose into scenes → story.json
    ├─ Step 4: Generate scenes (parallel generation-tier workers)
    ├─ Step 5: QC loop (review-tier → generation-tier fix, max 3 iterations)
    ├─ Step 6: Capture frames → stitch with ffmpeg
    └─ Step 7: Report output paths
```
