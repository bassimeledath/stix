# Visual QC Rubric

Use this rubric to evaluate each scene's 4 keyframe screenshots (captured at 0%, 33%, 66%, 100% of the animation loop).

Score each category **PASS** or **FAIL**. If any category is FAIL, the scene must be fixed.

---

## 1. Character Integrity

**Check at every keyframe:**

- [ ] Head is a visible circle with correct proportions (r=18 male, r=16 female)
- [ ] Eyes are visible inside the head
- [ ] Torso connects head/neck to hips as a continuous line
- [ ] Arms connect at shoulder point and have 2 segments
- [ ] Legs connect at hip point and have 2 segments
- [ ] No body parts are detached, overlapping incorrectly, or missing
- [ ] Character doesn't clip through props or scene boundaries

**FAIL if:** Any body part is missing, detached, or malformed in any keyframe.

**Fix instructions:** Re-examine the SVG path coordinates for the failing body part. Ensure all parts share consistent origin points. Cross-reference with `library/poses.md` for correct path data.

---

## 2. Animation Correctness

**Check across keyframes:**

- [ ] Character pose changes between keyframes (animation is actually happening)
- [ ] Walk/run cycles show alternating leg positions
- [ ] Arms swing in opposition to legs during locomotion
- [ ] Transitions between poses are smooth (no teleporting)
- [ ] Animation timing matches the scene's emotional beat
- [ ] No animation "freezes" — every moving element should change between at least 2 keyframes

**FAIL if:** Animation doesn't progress, limbs move in same direction, or poses teleport between keyframes.

**Fix instructions:** Check `animation-duration`, keyframe percentages, and `d: path()` values. Ensure leg/arm animations use opposite phase timing. Reference `library/transitions.md`.

---

## 3. Scene Composition

**Check at every keyframe:**

- [ ] Ground line is visible at y=355
- [ ] Characters are standing ON the ground (feet near y=348-355)
- [ ] Props are correctly positioned (not floating, not underground)
- [ ] Scene uses the full 900×400 viewBox reasonably (not cramped in corner)
- [ ] Background elements (trees, sun, etc.) don't overlap foreground characters
- [ ] Text elements (if any) are readable

**FAIL if:** Characters float above ground, are underground, or scene is empty/mis-composed.

**Fix instructions:** Check character Y positions against the style guide. Ensure ground line exists. Verify prop placement coordinates.

---

## 4. Visual Quality

**Check overall:**

- [ ] Line widths are consistent (stroke-width: 2.4 for characters)
- [ ] Colors match the palette (see `library/style-guide.md`)
- [ ] No visual artifacts (stray lines, incorrect fills)
- [ ] Background is `#faf9f6` (warm off-white)
- [ ] Opacity values are reasonable (0.25 for background trees, etc.)
- [ ] CSS animations use `ease-in-out` for natural motion (not linear, unless intentional)

**FAIL if:** Major color discrepancy, incorrect line weights, or visual artifacts.

**Fix instructions:** Cross-reference all color values with style guide. Check `stroke-width` values.

---

## 5. Continuity (Multi-Scene Only)

**Check between last keyframe of scene N and first keyframe of scene N+1:**

- [ ] Character position is consistent (not teleporting across stage)
- [ ] Character pose is consistent or has logical transition
- [ ] Expression matches emotional progression
- [ ] Props that should persist are present
- [ ] Props that should be gone are removed
- [ ] Background/setting transition is logical (e.g., outdoor → indoor)

**FAIL if:** Character position, pose, or props are inconsistent between scenes.

**Fix instructions:** Adjust the starting state of scene N+1 to match the ending state of scene N. Or adjust the ending state of scene N.

---

## QC Report Format

```
Scene: scene-01.html
Keyframes: 4 captured at 0%, 33%, 66%, 100%

1. Character Integrity:  PASS / FAIL — [notes]
2. Animation Correctness: PASS / FAIL — [notes]
3. Scene Composition:    PASS / FAIL — [notes]
4. Visual Quality:       PASS / FAIL — [notes]
5. Continuity:           PASS / FAIL — [notes] (if multi-scene)

Overall: PASS / FAIL
Fix priority: [list specific issues to fix, ordered by severity]
```
