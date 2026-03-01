# Visual QC Rubric

Use this rubric to evaluate each scene's 4 keyframe screenshots (captured at 0%, 33%, 66%, 100% of the animation loop via eval-based seeking).

Score each category **PASS** or **FAIL**. If any category is FAIL, the scene must be fixed.

Note: Character and prop integrity is validated separately at the asset validation step (Step 5). This rubric focuses on **composition and animation quality** in the assembled scene.

---

## 1. Animation Correctness

**Check across keyframes:**

- [ ] Characters move between keyframes (animation is actually happening)
- [ ] Walk/run cycles show alternating leg positions
- [ ] Arms swing in opposition to legs during locomotion
- [ ] Transitions between poses are smooth (no teleporting)
- [ ] Animation timing matches the scene's emotional beat
- [ ] No animation "freezes" — every moving element should change between at least 2 keyframes
- [ ] Expression changes happen at the right moments (matching scene spec timing)

**FAIL if:** Animation doesn't progress, limbs move in same direction, or poses teleport between keyframes.

**Fix instructions:** Check `animation-duration`, keyframe percentages, and transform values. Ensure leg/arm animations use opposite phase timing. Reference `library/transitions.md`. Do NOT modify the SVG asset shapes — only fix keyframes and timing.

---

## 2. Scene Composition

**Check at every keyframe:**

- [ ] Ground line is visible at y=355
- [ ] Characters are standing ON the ground (feet near y=348-355)
- [ ] Props are correctly positioned (not floating, not underground)
- [ ] Scene uses the full 900x400 viewBox reasonably (not cramped in corner)
- [ ] Background is visible and properly placed
- [ ] Characters don't clip through props or scene boundaries
- [ ] Start and end positions match the scene specification coordinates

**FAIL if:** Characters float above ground, are underground, or scene is empty/mis-composed.

**Fix instructions:** Check character translate() Y positions against the style guide. Ensure ground line exists. Verify prop placement coordinates. Do NOT modify asset SVGs.

---

## 3. Visual Quality

**Check overall:**

- [ ] Line widths are consistent (stroke-width: 2.4 for characters)
- [ ] Colors match the palette (see `library/style-guide.md`)
- [ ] No visual artifacts (stray lines, incorrect fills, clipping)
- [ ] Background is `#faf9f6` (warm off-white)
- [ ] Opacity values are reasonable (0.25 for background trees, etc.)
- [ ] CSS animations use `ease-in-out` for natural motion (not linear, unless intentional)

**FAIL if:** Major color discrepancy, incorrect line weights, or visual artifacts.

**Fix instructions:** Cross-reference all color values with style guide. Check `stroke-width` values.

---

## 4. Continuity (Multi-Scene Only)

**Check between last keyframe of scene N and first keyframe of scene N+1:**

- [ ] Character position is consistent (not teleporting across stage)
- [ ] Character pose is consistent or has logical transition
- [ ] Expression matches emotional progression
- [ ] Props that should persist are present
- [ ] Props that should be gone are removed

**FAIL if:** Character position, pose, or props are inconsistent between scenes.

**Fix instructions:** Adjust the starting translate() position of scene N+1 to match the ending position of scene N. Or adjust the ending position of scene N.

---

## QC Report Format

Output as JSON:

```json
{
  "scene": 1,
  "overall": "PASS",
  "categories": {
    "animation_correctness": { "result": "PASS", "notes": "" },
    "scene_composition": { "result": "PASS", "notes": "" },
    "visual_quality": { "result": "PASS", "notes": "" }
  },
  "fix_instructions": []
}
```
