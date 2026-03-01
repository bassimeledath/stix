# Character Asset Template

Generate a self-contained SVG `<g>` element for a stick figure character. This asset will be reused across multiple animation scenes — scene composers will position it via `translate()` and animate it with CSS `@keyframes`.

## Output Format

Write a single SVG file containing a `<g>` element with the character's ID. The character is defined **relative to hip at (0, 0)** per the style guide.

```svg
<g id="CHARACTER_ID">
  <!-- Head group: contains head circle + expression variants -->
  <g class="head" transform="translate(0, -60)">
    <circle cx="0" cy="0" r="18" class="char-head" />

    <!-- Each expression is a separate group. Scene composers toggle via display:none/block -->
    <g class="expr-happy">
      <circle cx="-6" cy="-3" r="2" class="char-eyes" />
      <circle cx="6" cy="-3" r="2" class="char-eyes" />
      <path d="M -8 5 Q 0 15 8 5" class="char-mouth" />
    </g>

    <g class="expr-neutral" style="display:none">
      <circle cx="-6" cy="-3" r="2" class="char-eyes" />
      <circle cx="6" cy="-3" r="2" class="char-eyes" />
      <line x1="-6" y1="5" x2="6" y2="5" class="char-mouth" />
    </g>

    <!-- Add more expressions as specified in the character description -->
  </g>

  <!-- Torso -->
  <line x1="0" y1="-42" x2="0" y2="0" class="char-body" />

  <!-- Left arm (2 segments: shoulder -> elbow -> hand) -->
  <path class="left-arm char-body" d="M 0 -37 L -18 -17 L -20 0" />

  <!-- Right arm -->
  <path class="right-arm char-body" d="M 0 -37 L 18 -17 L 20 0" />

  <!-- Left leg (2 segments: hip -> knee -> foot) -->
  <path class="left-leg char-body" d="M 0 0 L -15 35 L -20 53" />

  <!-- Right leg -->
  <path class="right-leg char-body" d="M 0 0 L 15 35 L 20 53" />
</g>
```

## Rules

1. **Hip at origin (0, 0)** — all coordinates are relative. Scene composers position via `translate()`.
2. **Named CSS classes on each limb** — `left-arm`, `right-arm`, `left-leg`, `right-leg`, `head`. Scene composers animate these individually with `@keyframes`.
3. **Expression variants** — include a `<g class="expr-EXPRESSION_NAME">` for each expression listed in the character spec's `expressions_needed`. The first expression should be visible (no `display:none`), all others should have `style="display:none"`.
4. **Use library poses as reference** — the default pose should be `standing` from `library/poses.md`. Copy exact path data.
5. **Use library expressions** — copy expression SVG from `library/expressions.md`. Position them relative to head center at (0, 0) inside the head group.
6. **Apply character-specific colors** — if the character spec includes colors (e.g., blue jacket), add `fill` or `stroke` attributes to the appropriate elements. Keep the `#2a2a2a` outline on all body parts.
7. **For animals** — use `library/animals.md` for the body structure instead of human proportions. Still use hip-at-origin convention and named limb classes.
8. **Keep it minimal** — aim for 50-100 lines. No animation, no background, no HTML wrapper. Just the SVG `<g>`.

## Proportions Reference

| Part | Relative to hip (0,0) |
|------|----------------------|
| Head center | (0, -60) |
| Neck | (0, -42) |
| Shoulder | (0, -37) |
| Hip (origin) | (0, 0) |
| Knee | (+/-15, +35) |
| Feet | (+/-20, +53) |
| Total height | ~126px |
| Head radius | 18px (male) / 16px (female) |
