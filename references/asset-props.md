# Props Asset Template

Generate individual SVG files for each prop needed by the animation. Props are reusable across scenes — scene composers position them via `translate()`.

## Output Format

Write each prop as a separate SVG file. Each prop is a self-contained `<g>` element defined at origin (0, 0).

Example for a heart prop (`heart.svg`):

```svg
<g id="heart">
  <path d="M 0 -8 C -10 -20 -25 -5 0 12 C 25 -5 10 -20 0 -8 Z"
        fill="#e85c5c" stroke="#2a2a2a" stroke-width="1.5" />
</g>
```

Example for a sparkle prop (`sparkle.svg`):

```svg
<g id="sparkle">
  <path d="M 0 -12 L 2 -2 L 12 0 L 2 2 L 0 12 L -2 2 L -12 0 L -2 -2 Z"
        fill="#f0c040" stroke="none" opacity="0.9" />
</g>
```

## Rules

1. **Origin at (0, 0)** — each prop is centered at its own origin. Scene composers position via `translate()`.
2. **Use props library** — reference `library/props.md` for exact SVG path data. Copy the shapes exactly.
3. **One file per prop** — each prop gets its own `.svg` file named after its ID (e.g., `tree.svg`, `bench.svg`, `heart.svg`).
4. **Self-contained `<g>`** — each file contains a single `<g id="PROP_ID">` with all the prop's elements inside.
5. **Color palette** — use colors from `library/style-guide.md`. Common: `#e85c5c` (heart), `#7ec87e` (plants), `#f0c040` (sun/sparkle), `#87CEEB` (sky elements).
6. **No animation** — props are static SVG. Scene composers add animations if needed.
7. **Appropriate scale** — props should be sized relative to characters (~126px tall). A bench is ~60px tall, a heart is ~24px, a tree is ~100px.
8. **Keep it minimal** — each prop should be 5-20 lines of SVG.
