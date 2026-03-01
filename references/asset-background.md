# Background Asset Template

Generate a single SVG background that will be shared across ALL scenes in the animation. This ensures visual consistency — every scene has the exact same sky, ground, and environmental elements.

## Output Format

Write an SVG file containing all background elements within the 900x400 viewBox coordinate space.

```svg
<!-- Sky gradient -->
<defs>
  <linearGradient id="sky" x1="0%" y1="0%" x2="0%" y2="100%">
    <stop offset="0%" style="stop-color:#87CEEB" />
    <stop offset="100%" style="stop-color:#E0F0FF" />
  </linearGradient>
</defs>
<rect x="0" y="0" width="900" height="355" fill="url(#sky)" />

<!-- Ground area -->
<rect x="0" y="355" width="900" height="45" fill="#c8d8a0" opacity="0.3" />

<!-- Background elements: trees, buildings, hills, etc. -->
<!-- Place behind characters (y < 355 for above-ground, use opacity for depth) -->

<!-- Example: distant tree -->
<g transform="translate(150, 280)" opacity="0.25">
  <!-- tree SVG from props library -->
</g>

<!-- Example: sun -->
<g transform="translate(780, 60)">
  <!-- sun SVG from props library -->
</g>
```

## Rules

1. **900x400 viewBox** — all coordinates are absolute within this space.
2. **Ground line at y=355** — the ground line itself is added by the scene template, but background ground fill should end at y=355.
3. **Use props library** — reference `library/props.md` for trees, sun, clouds, benches, etc. Copy their SVG exactly.
4. **Depth via opacity** — distant elements use `opacity="0.25"`, mid-ground `opacity="0.5"`. Foreground props (benches, etc.) are fully opaque.
5. **No characters** — the background contains only environmental elements. Characters are separate assets.
6. **No animation** — the background is static. Scene composers add any environmental animations (clouds moving, sun pulsing) if needed.
7. **Match the description** — include all environmental elements mentioned in the background spec (e.g., "park with trees and bench" should have trees and a bench).
8. **Color palette** — use colors from `library/style-guide.md`. Background `#faf9f6` is handled by the HTML body, not the SVG.
9. **Keep it clean** — aim for 30-80 lines of SVG. Simple shapes, no excessive detail.
