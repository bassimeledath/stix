# /animate — Stick Figure Animation

Generate stick figure animations from natural language descriptions. Outputs GIF and MP4 files.

## Usage

```
/animate "a cat chasing a mouse across a park"
```

## Pipeline

When the user invokes `/animate`, execute these steps in order:

---

### Step 1: Parameter Inference

Parse the user's prompt and infer these parameters. The user never sees or sets these directly — infer them from the natural language description:

| Parameter | Range | Default | How to infer |
|-----------|-------|---------|--------------|
| `scenes` | 1–6 | 2 | Count distinct moments/locations/emotional beats in the prompt |
| `length` | 4–30s | 8s per scene | More complex = longer |
| `fps` | 8–24 | 8 | Default for most; use 12 for fast action |
| `format` | gif/mp4/both | both | Default both unless user specifies |
| `mood` | playful/melancholy/energetic/calm | playful | Infer from the emotion in the prompt |

Write these to `.animate/params.json`:

```json
{
  "prompt": "a cat chasing a mouse across a park",
  "scenes": 3,
  "fps": 8,
  "format": "both",
  "mood": "playful"
}
```

---

### Step 2: Preflight Checks

Verify dependencies are installed:

```bash
command -v agent-browser >/dev/null 2>&1 || { echo "❌ agent-browser not found"; exit 1; }
command -v ffmpeg >/dev/null 2>&1 || { echo "❌ ffmpeg not found"; exit 1; }
command -v claude >/dev/null 2>&1 || { echo "❌ claude CLI not found"; exit 1; }
```

Create the working directory:

```bash
rm -rf .animate
mkdir -p .animate/scenes .animate/qc .animate/output
```

---

### Step 3: Story Decomposition

Break the prompt into scenes. Write `.animate/story.json`:

```json
{
  "title": "Cat Chases Mouse",
  "scenes": [
    {
      "id": 1,
      "description": "A mouse scurries across a park path, unaware. Trees and a bench in background.",
      "characters": ["mouse"],
      "start_pose": "standing",
      "end_pose": "running",
      "props": ["tree", "bench"],
      "mood": "playful",
      "key_action": "Mouse enters from left and runs across screen"
    },
    {
      "id": 2,
      "description": "A cat spots the mouse and launches into a chase. Both running across the park.",
      "characters": ["cat", "mouse"],
      "start_pose": "crouching",
      "end_pose": "running",
      "props": ["tree"],
      "mood": "energetic",
      "key_action": "Cat enters chasing mouse, both running right",
      "continuity": "Mouse position matches end of scene 1"
    }
  ]
}
```

**Continuity rules:**
- Last frame of scene N must match first frame of scene N+1 in character position, pose, and visible props
- Characters that exit a scene should enter the next scene from the same direction
- Emotional progression must be logical

---

### Step 4: Scene Generation (Parallel Workers)

For each scene, spawn a background worker using the Claude CLI. All workers run in parallel.

**For each scene N:**

1. Build the worker prompt by assembling context from the component library:

```bash
SKILL_DIR="$(dirname "$(readlink -f "$0")" 2>/dev/null || cd "$(dirname "$0")" && pwd)"
# If SKILL_DIR detection fails, try common install locations:
# ~/.claude/skills/animate or ~/.agents/skills/animate

WORKER_PROMPT=$(cat << 'PROMPT_END'
You are generating a single HTML file for a stick figure animation scene.

## Scene Specification
SCENE_DESCRIPTION_HERE

## Component Library

Read and use these reference files for exact SVG data and animation patterns:
- Style Guide: SKILL_DIR/library/style-guide.md
- Poses: SKILL_DIR/library/poses.md
- Transitions: SKILL_DIR/library/transitions.md
- Expressions: SKILL_DIR/library/expressions.md
- Props: SKILL_DIR/library/props.md
- Animals: SKILL_DIR/library/animals.md

## Base Template

Start from this HTML skeleton:
SKILL_DIR/references/scene-base.html

## Rules

1. Use CSS-only animation (no JavaScript)
2. All animations loop with `infinite` and duration `8s`
3. Use the relative coordinate system from the style guide
4. Position characters via `translate()` on parent `<g>` elements
5. Match poses and props from the component library exactly
6. Use the color palette from the style guide
7. Sub-loops (walk cycle 0.5s, run cycle 0.4s) nest inside the 8s scene loop
8. Include the ground line at y=355

## Output

Write ONLY the complete HTML file to: .animate/scenes/scene-NN.html
No explanation, no markdown — just the HTML file.
PROMPT_END
)
```

2. Spawn the worker:

```bash
# Write the assembled prompt to a temp file
cat > /tmp/animate-scene-$(printf "%02d" $N)-prompt.txt << PROMPT_EOF
$WORKER_PROMPT
PROMPT_EOF

# Spawn background worker
env -u CLAUDE_CODE_ENTRYPOINT -u CLAUDECODE \
  claude -p --dangerously-skip-permissions \
  --model claude-opus-4-6 \
  "$(cat /tmp/animate-scene-$(printf "%02d" $N)-prompt.txt)" &
```

3. After spawning all workers, wait for completion:

```bash
wait
```

4. Verify all scene files exist:

```bash
for N in $(seq 1 $TOTAL_SCENES); do
  FILE=".animate/scenes/scene-$(printf "%02d" $N).html"
  if [ ! -f "$FILE" ]; then
    echo "❌ Missing: $FILE"
    exit 1
  fi
  echo "✓ $FILE generated"
done
```

**Important:** Each worker prompt must include the full text content of the relevant library files (read them and inject into the prompt). The workers don't have access to the skill directory — they only see what's in their prompt.

---

### Step 5: Visual QC

For each scene, perform quality checks using screenshots and a review worker.

**Per scene:**

1. **Capture 4 keyframes:**

```bash
SCENE_FILE=".animate/scenes/scene-$(printf "%02d" $N).html"
ABS_PATH="$(cd "$(dirname "$SCENE_FILE")" && pwd)/$(basename "$SCENE_FILE")"

agent-browser open "file://$ABS_PATH"
sleep 0.5

# Keyframe at 0%
agent-browser screenshot ".animate/qc/scene-${N}-kf0.png"

# Keyframe at 33% (sleep 2.64s into 8s loop)
sleep 2.64
agent-browser screenshot ".animate/qc/scene-${N}-kf33.png"

# Keyframe at 66%
sleep 2.64
agent-browser screenshot ".animate/qc/scene-${N}-kf66.png"

# Keyframe at 100%
sleep 2.64
agent-browser screenshot ".animate/qc/scene-${N}-kf100.png"

agent-browser close
```

2. **Spawn a Sonnet QC reviewer:**

```bash
cat > /tmp/animate-qc-$(printf "%02d" $N)-prompt.txt << 'QC_EOF'
Review these 4 keyframe screenshots of a stick figure animation scene against the QC rubric.

Screenshots:
- .animate/qc/scene-N-kf0.png (0% - start)
- .animate/qc/scene-N-kf33.png (33%)
- .animate/qc/scene-N-kf66.png (66%)
- .animate/qc/scene-N-kf100.png (100% - end)

QC Rubric: [contents of references/qc-rubric.md]

Scene description: [scene description from story.json]

Evaluate each category: Character Integrity, Animation Correctness, Scene Composition, Visual Quality.

Output a JSON object:
{
  "scene": N,
  "overall": "PASS" or "FAIL",
  "categories": {
    "character_integrity": { "result": "PASS/FAIL", "notes": "..." },
    "animation_correctness": { "result": "PASS/FAIL", "notes": "..." },
    "scene_composition": { "result": "PASS/FAIL", "notes": "..." },
    "visual_quality": { "result": "PASS/FAIL", "notes": "..." }
  },
  "fix_instructions": ["list of specific fixes needed"]
}

Write the result to: .animate/qc/scene-N-result.json
QC_EOF

env -u CLAUDE_CODE_ENTRYPOINT -u CLAUDECODE \
  claude -p --dangerously-skip-permissions \
  --model claude-sonnet-4-6 \
  "$(cat /tmp/animate-qc-$(printf "%02d" $N)-prompt.txt)"
```

3. **If FAIL, fix and re-review (max 3 iterations):**

```bash
ITERATION=0
MAX_ITERATIONS=3

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
  # Read QC result
  QC_RESULT=$(cat ".animate/qc/scene-${N}-result.json" 2>/dev/null)

  if echo "$QC_RESULT" | grep -q '"overall": "PASS"'; then
    echo "✓ Scene $N passed QC"
    break
  fi

  ITERATION=$((ITERATION + 1))
  echo "⚠ Scene $N failed QC (attempt $ITERATION/$MAX_ITERATIONS). Fixing..."

  # Spawn Opus fix worker
  cat > /tmp/animate-fix-$(printf "%02d" $N)-prompt.txt << FIX_EOF
Fix this stick figure animation scene based on QC feedback.

Current HTML: [read .animate/scenes/scene-NN.html]
QC Result: $QC_RESULT

Component Library:
[inject library files as context]

Fix the issues listed in fix_instructions. Write the corrected HTML to:
.animate/scenes/scene-$(printf "%02d" $N).html
FIX_EOF

  env -u CLAUDE_CODE_ENTRYPOINT -u CLAUDECODE \
    claude -p --dangerously-skip-permissions \
    --model claude-opus-4-6 \
    "$(cat /tmp/animate-fix-$(printf "%02d" $N)-prompt.txt)"

  # Re-capture and re-review
  # (repeat keyframe capture + Sonnet review from above)
done
```

4. **Continuity check (multi-scene only):**

For scenes 2+, compare `.animate/qc/scene-${N-1}-kf100.png` with `.animate/qc/scene-${N}-kf0.png`:

```bash
cat > /tmp/animate-continuity-prompt.txt << 'CONT_EOF'
Compare these two screenshots for continuity:
1. .animate/qc/scene-PREV-kf100.png (end of previous scene)
2. .animate/qc/scene-CURR-kf0.png (start of current scene)

Check:
- Character position consistency
- Pose continuity
- Prop consistency
- Emotional progression

Output: PASS or FAIL with specific fix notes.
Write to: .animate/qc/continuity-PREV-CURR.json
CONT_EOF

env -u CLAUDE_CODE_ENTRYPOINT -u CLAUDECODE \
  claude -p --dangerously-skip-permissions \
  --model claude-sonnet-4-6 \
  "$(cat /tmp/animate-continuity-prompt.txt)"
```

---

### Step 6: Frame Capture & Stitch

Run the capture script with inferred parameters:

```bash
SKILL_DIR="$(dirname "$(readlink -f "$0")" 2>/dev/null || cd "$(dirname "$0")" && pwd)"

bash "$SKILL_DIR/scripts/capture.sh" \
  --scenes-dir .animate/scenes \
  --frames-dir .animate/frames \
  --output-dir .animate/output \
  --fps $FPS \
  --format $FORMAT
```

---

### Step 7: Report

After the pipeline completes, report to the user:

```
✅ Animation complete!

Prompt: "a cat chasing a mouse across a park"
Scenes: 3
Duration: 24s (3 × 8s)
FPS: 8
QC: All scenes passed (2 required fixes)

Output:
  GIF: .animate/output/animation.gif (270KB)
  MP4: .animate/output/animation.mp4 (90KB)
```

---

## Component Library Reference

When generating scenes, always read and inject these files into worker prompts:

| File | Purpose |
|------|---------|
| `library/style-guide.md` | Coordinate system, proportions, colors, CSS classes |
| `library/poses.md` | 15 named poses with exact SVG path data |
| `library/transitions.md` | Animation keyframe patterns (walk, run, sit, jump, etc.) |
| `library/expressions.md` | 8 facial expressions with SVG data |
| `library/props.md` | 17 reusable prop SVG snippets |
| `library/animals.md` | 4 animal templates with walk cycles |

## Key Conventions

1. **CSS-only animation** — no JavaScript. Deterministic timing, no race conditions.
2. **8s scene duration** — all `animation-duration: 8s` with `infinite` loop.
3. **Relative coordinates** — characters defined at origin, positioned via `translate()`.
4. **Phase-based scenes** — for multi-moment scenes, use opacity toggling (see `transitions.md` → phase_transition).
5. **Sub-loops** — walk cycle (0.5s), run cycle (0.4s) nest inside the 8s scene loop.
6. **Opus for generation, Sonnet for QC** — match model capability to task complexity.
7. **Max 3 QC fix iterations** — if still failing after 3, report the remaining issues to the user.
