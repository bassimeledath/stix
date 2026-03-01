# Scene Composition Instructions

You are composing an animation scene from pre-built SVG assets. Your job is **positioning + keyframes + timing** — NOT character or prop design. You must not modify the SVG shapes from the assets.

## Workflow

1. **Read the base HTML template** (`references/scene-base.html`)
2. **Read each asset SVG file** listed in the prompt
3. **Embed assets** into the SVG, wrapped in positioning `<g>` elements
4. **Add CSS `@keyframes`** for movement, limb animation, and expression changes
5. **Write the complete HTML file**

## Embedding Assets

### Background

Copy the background SVG content into the `<g id="background">` group. No transform needed — background coordinates are already in the 900x400 viewBox space.

```html
<g id="background">
  <!-- paste contents of .stix/assets/background.svg here -->
</g>
```

### Characters

Wrap each character asset in a positioning `<g>` with the starting translate position from the scene spec. Apply a CSS animation for movement.

```html
<g id="char-NAME-wrapper" style="animation: move-NAME 8s ease-in-out infinite;">
  <!-- paste contents of .stix/assets/characters/NAME.svg here, exactly as-is -->
</g>
```

The `@keyframes move-NAME` handles the translate from start to end position:

```css
@keyframes move-NAME {
  0%   { transform: translate(START_Xpx, START_Ypx); }
  100% { transform: translate(END_Xpx, END_Ypx); }
}
```

### Props

Position each prop with a static translate:

```html
<g id="prop-NAME" transform="translate(X, Y)">
  <!-- paste contents of .stix/assets/props/NAME.svg here -->
</g>
```

## Adding Animation

### Character Movement

Use the start/end coordinates from the scene spec:

```css
@keyframes move-cat {
  0%   { transform: translate(30px, 310px); }
  100% { transform: translate(600px, 310px); }
}
```

### Limb Animation (Walk/Run Cycles)

Target the named limb classes inside each character asset. These nest as sub-loops inside the 8s scene:

```css
/* Walk cycle: 0.5s period, alternating legs */
#char-cat .left-leg {
  animation: walk-left-leg 0.5s ease-in-out infinite;
}
#char-cat .right-leg {
  animation: walk-right-leg 0.5s ease-in-out infinite;
}
#char-cat .left-arm {
  animation: walk-left-arm 0.5s ease-in-out infinite;
}
#char-cat .right-arm {
  animation: walk-right-arm 0.5s ease-in-out infinite;
}

@keyframes walk-left-leg {
  0%, 100% { transform: rotate(-15deg); }
  50%      { transform: rotate(15deg); }
}
@keyframes walk-right-leg {
  0%, 100% { transform: rotate(15deg); }
  50%      { transform: rotate(-15deg); }
}
/* Arms swing in opposition to legs */
@keyframes walk-left-arm {
  0%, 100% { transform: rotate(15deg); }
  50%      { transform: rotate(-15deg); }
}
@keyframes walk-right-arm {
  0%, 100% { transform: rotate(-15deg); }
  50%      { transform: rotate(15deg); }
}
```

Use `transform-origin` on limb elements to set the rotation pivot (shoulder for arms, hip for legs).

### Expression Changes

Toggle expression groups using opacity or display at specific keyframe percentages:

```css
/* Switch from neutral to surprised at 60% */
#char-mouse .expr-neutral {
  animation: hide-at-60 8s step-end infinite;
}
#char-mouse .expr-surprised {
  animation: show-at-60 8s step-end infinite;
}

@keyframes hide-at-60 {
  0%, 59%  { display: block; }
  60%, 100% { display: none; }
}
@keyframes show-at-60 {
  0%, 59%  { display: none; }
  60%, 100% { display: block; }
}
```

## Timing Rules

- **Scene duration**: always 8s with `infinite` loop
- **Movement easing**: `ease-in-out` for natural motion, `linear` for constant-speed locomotion
- **Sub-loops**: walk cycle 0.5s, run cycle 0.4s — these repeat independently inside the 8s scene
- **Phase timing**: use the `timing` object from the scene spec to map actions to percentages
- **Expression timing**: align with emotional beats in the scene description

## Critical Rules

1. **DO NOT modify asset SVG paths** — copy them exactly as-is from the asset files
2. **Position via translate() only** — never rewrite SVG coordinates to move characters
3. **All timing via CSS** — no JavaScript
4. **Include the ground line** — `<line class="ground" x1="0" y1="355" x2="900" y2="355" />`
5. **Use the transition library** — reference `library/transitions.md` for animation patterns
6. **Match scene spec coordinates** — use the exact start/end `[x, y]` positions from the spec
