# Stick Figure Animation Style Guide

## Coordinate System

All characters are defined **relative to hip origin at (0, 0)**. To position a character on the stage, wrap it in a `<g transform="translate(X, Y)">` where X,Y is the desired hip position.

**Relative offsets from hip (0, 0):**

| Part | Offset |
|------|--------|
| Head center | (0, -60) |
| Neck | (0, -42) |
| Shoulder | (0, -37) |
| Hip (origin) | (0, 0) |
| Knee | (±15, +35) |
| Feet | (±20, +53) |

**Absolute coordinates (when hip is at typical position 450, 295):**

| Part | Y position |
|------|------------|
| Head center Y | 235 |
| Neck Y | 253 |
| Shoulder Y | 258 |
| Hip Y | 295 |
| Feet Y | 348 |
| Ground Y | 355 |

## Character Proportions

- **Head**: circle, radius 18px (male) / 16px (female)
- **Body/Torso**: vertical line, 37px long (shoulder to hips)
- **Arms**: 2-segment paths from shoulder, ~35px total length
- **Legs**: 2-segment paths from hip, ~53px total length
- **Total height**: ~126px (head top to feet)

## Line Style

```css
stroke: #2a2a2a;
stroke-width: 2.4;
stroke-linecap: round;
stroke-linejoin: round;
fill: none;
```

## CSS Class Conventions

```css
/* Always define these base classes in every scene */
.char-head  { fill: none; stroke: #2a2a2a; stroke-width: 2.4; }
.char-body  { stroke: #2a2a2a; stroke-width: 2.4; stroke-linecap: round; stroke-linejoin: round; fill: none; }
.char-eyes  { fill: #2a2a2a; }
.char-mouth { stroke: #2a2a2a; stroke-width: 1.8; stroke-linecap: round; fill: none; }
.ground     { stroke: #d4d0c8; stroke-width: 1.5; stroke-dasharray: 6 4; }
```

## Eye Style

- Two circles, `r="2"`, `fill="#2a2a2a"`
- Positioned at `head_cx ± 6`, `head_cy - 3`

## Female Character Variant

- Head radius: 16px (vs 18px male)
- Triangular skirt shape at hips: `<path d="M hip_x hip_y-5 L hip_x-12 hip_y+15 L hip_x+12 hip_y+15 Z" />`
- Hair: 3 curved paths flowing down from head
- Eyelashes: tiny lines above eyes (2 per eye)
- Scale: 0.9 of male proportions

## Color Palette

| Element | Color |
|---------|-------|
| Background | `#faf9f6` (warm off-white) |
| Character lines | `#2a2a2a` |
| Heart | `#e85c5c` |
| Broken heart crack | `#faf9f6` on `#e85c5c` |
| Pizza/food | `#e8a85c` |
| Salad/healthy | `#7ec87e` |
| Gym equipment | `#888888` |
| Sun | `#f0c040` |
| Rain/sweat | `#8bb8d0` |
| Musical notes | `#b8a080` |
| TV glow | `#a0c8e8` |
| Room walls | `#e8e4dc` |
| Furniture outline | `#d4d0c8` |
| Tree canopy | `#2a2a2a` at 0.25 opacity |

## SVG ViewBox

All scenes use `viewBox="0 0 900 400"`. Ground dashed line at `y=355`.

## Animation Timing

- Each scene: **8 seconds** total, `animation-duration: 8s`
- All animations loop with `infinite`
- Use `ease-in-out` for natural movement (default for most motions)
- Use `linear` for constant-speed locomotion (walk-across, run cycles, character_translate) where acceleration would look unnatural
- Sub-loops (walk cycles, etc.) use their own shorter duration (0.4-0.5s)
- Phase-based scenes split 8s into equal segments (e.g., 4 phases = 2s each)

## Character Positioning via translate()

To move a character across the stage, animate the parent `<g>` element's `transform`:

```css
@keyframes walk-across {
  0%   { transform: translateX(-120px); }
  100% { transform: translateX(850px); }
}
```

Never rewrite individual path coordinates to move a character — always use `translate()` on the containing group.
