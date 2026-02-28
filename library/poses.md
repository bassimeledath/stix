# Poses Library

All poses defined with **hip at origin (0, 0)**, shoulder at (0, -37), head center at (0, -60). Wrap in `<g transform="translate(HIP_X, HIP_Y)">` to position on stage.

For absolute coordinates, add the hip position. Default hip position: (450, 295).

---

## standing

Neutral upright stance, arms relaxed at sides.

```svg
<!-- Head -->
<circle cx="0" cy="-60" r="18" class="char-head" />
<circle cx="-6" cy="-63" r="2" class="char-eyes" />
<circle cx="6" cy="-63" r="2" class="char-eyes" />
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms -->
<path d="M 0 -37 L -18 -17 L -20 0" class="char-body" />
<path d="M 0 -37 L 18 -17 L 20 0" class="char-body" />
<!-- Legs -->
<path d="M 0 0 L -15 35 L -20 53" class="char-body" />
<path d="M 0 0 L 15 35 L 20 53" class="char-body" />
```

## walking_a

Left foot forward, right arm forward (first frame of walk cycle).

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms -->
<path d="M 0 -37 L -18 -20 L -20 -5" class="char-body" />   <!-- left arm back -->
<path d="M 0 -37 L 18 -20 L 20 -5" class="char-body" />     <!-- right arm forward -->
<!-- Legs -->
<path d="M 0 0 L -15 35 L -15 53" class="char-body" />      <!-- left leg forward -->
<path d="M 0 0 L 15 35 L 15 53" class="char-body" />        <!-- right leg back -->
```

## walking_b

Right foot forward, left arm forward (second frame of walk cycle).

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms -->
<path d="M 0 -37 L 18 -20 L 20 -5" class="char-body" />    <!-- right arm back -->
<path d="M 0 -37 L -18 -20 L -20 -5" class="char-body" />  <!-- left arm forward -->
<!-- Legs -->
<path d="M 0 0 L 15 35 L 15 53" class="char-body" />       <!-- right leg forward -->
<path d="M 0 0 L -15 35 L -15 53" class="char-body" />     <!-- left leg back -->
```

## running_a

Extended stride, left foot forward. Arms pumping.

```svg
<!-- Torso (slight forward lean) -->
<line x1="0" y1="-42" x2="2" y2="0" class="char-body" />
<!-- Arms (pumping) -->
<path d="M 0 -37 L -20 -25 L -28 -15" class="char-body" />
<path d="M 0 -37 L 20 -25 L 28 -15" class="char-body" />
<!-- Legs (extended stride) -->
<path d="M 0 0 L -20 30 L -22 53" class="char-body" />
<path d="M 0 0 L 20 30 L 22 53" class="char-body" />
```

## running_b

Extended stride, right foot forward.

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="2" y2="0" class="char-body" />
<!-- Arms (opposite pump) -->
<path d="M 0 -37 L 20 -25 L 28 -15" class="char-body" />
<path d="M 0 -37 L -20 -25 L -28 -15" class="char-body" />
<!-- Legs -->
<path d="M 0 0 L 20 30 L 22 53" class="char-body" />
<path d="M 0 0 L -20 30 L -22 53" class="char-body" />
```

## sitting

Seated on a surface (surface at ~hip level). Legs bent forward.

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms (resting on lap) -->
<path d="M 0 -37 L -20 -17 L -15 0" class="char-body" />
<path d="M 0 -37 L 20 -17 L 15 0" class="char-body" />
<!-- Legs (bent at knee, feet on ground) -->
<path d="M 0 0 L -13 23 L -20 53" class="char-body" />
<path d="M 0 0 L 13 23 L 20 53" class="char-body" />
```

## sitting_slouched

Slouched sitting — torso rotated forward, head drooped. Use `transform-origin` at shoulder for the slump rotation.

```svg
<!-- Torso (angled forward via parent rotation 18deg) -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms (dangling) -->
<path d="M 0 -37 L -20 -17 L -15 0" class="char-body" />
<path d="M 0 -37 L 20 -17 L 15 0" class="char-body" />
<!-- Legs -->
<path d="M 0 0 L -13 23 L -20 53" class="char-body" />
<path d="M 0 0 L 13 23 L 20 53" class="char-body" />
```

CSS to animate slump:
```css
.slump-group {
  animation: slump 8s ease-in-out infinite;
  transform-origin: HIP_X SHOULDER_Y;
}
@keyframes slump {
  0%, 72% { transform: rotate(0deg); }
  85%, 100% { transform: rotate(18deg); }
}
```

## jumping

Mid-air, legs tucked, arms raised.

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms (raised up) -->
<path d="M 0 -37 L -18 -55 L -22 -65" class="char-body" />
<path d="M 0 -37 L 18 -55 L 22 -65" class="char-body" />
<!-- Legs (tucked) -->
<path d="M 0 0 L -12 15 L -18 10" class="char-body" />
<path d="M 0 0 L 12 15 L 18 10" class="char-body" />
```

## crouching

Low stance, knees deeply bent.

```svg
<!-- Torso (shortened — crouch) -->
<line x1="0" y1="-30" x2="0" y2="0" class="char-body" />
<!-- Head (lower) -->
<circle cx="0" cy="-48" r="18" class="char-head" />
<!-- Arms (reaching down) -->
<path d="M 0 -25 L -18 -10 L -22 5" class="char-body" />
<path d="M 0 -25 L 18 -10 L 22 5" class="char-body" />
<!-- Legs (deeply bent) -->
<path d="M 0 0 L -20 10 L -25 30" class="char-body" />
<path d="M 0 0 L 20 10 L 25 30" class="char-body" />
```

## waving

Standing with right arm raised in a wave.

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Left arm (relaxed) -->
<path d="M 0 -37 L -18 -17 L -20 0" class="char-body" />
<!-- Right arm (waving — raised, hand oscillates) -->
<path d="M 0 -37 L 18 -55 L 28 -60" class="char-body" />
<!-- Legs -->
<path d="M 0 0 L -15 35 L -20 53" class="char-body" />
<path d="M 0 0 L 15 35 L 20 53" class="char-body" />
```

## arms_raised

Both arms straight up (celebration / victory).

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms (straight up) -->
<path d="M 0 -37 L -10 -65 L -8 -80" class="char-body" />
<path d="M 0 -37 L 10 -65 L 8 -80" class="char-body" />
<!-- Legs -->
<path d="M 0 0 L -15 35 L -20 53" class="char-body" />
<path d="M 0 0 L 15 35 L 20 53" class="char-body" />
```

## reaching

One arm extended forward to grab something.

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Left arm (at side) -->
<path d="M 0 -37 L -18 -17 L -20 0" class="char-body" />
<!-- Right arm (reaching forward) -->
<path d="M 0 -37 L 30 -25 L 45 -20" class="char-body" />
<!-- Legs -->
<path d="M 0 0 L -15 35 L -20 53" class="char-body" />
<path d="M 0 0 L 15 35 L 20 53" class="char-body" />
```

## lying_down

Horizontal on the ground. Hip at ground level, body extends left.

```svg
<!-- Torso (horizontal) -->
<line x1="0" y1="0" x2="-37" y2="0" class="char-body" />
<!-- Head (at left end) -->
<circle cx="-55" cy="0" r="18" class="char-head" />
<!-- Arms (resting alongside) -->
<path d="M -37 0 L -40 15 L -35 25" class="char-body" />
<path d="M -5 0 L -2 15 L 3 25" class="char-body" />
<!-- Legs (extending right) -->
<path d="M 0 0 L 30 2 L 53 0" class="char-body" />
<path d="M 0 0 L 30 -2 L 53 0" class="char-body" />
```

## dancing_a

Arms up and angled, one leg lifted. Party pose.

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms (angled up, disco style) -->
<path d="M 0 -37 L -25 -55 L -30 -45" class="char-body" />
<path d="M 0 -37 L 25 -50 L 35 -55" class="char-body" />
<!-- Left leg (planted) -->
<path d="M 0 0 L -10 35 L -15 53" class="char-body" />
<!-- Right leg (lifted/kicked) -->
<path d="M 0 0 L 20 20 L 30 15" class="char-body" />
```

## dancing_b

Mirror of dancing_a.

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms (opposite angles) -->
<path d="M 0 -37 L 25 -55 L 30 -45" class="char-body" />
<path d="M 0 -37 L -25 -50 L -35 -55" class="char-body" />
<!-- Right leg (planted) -->
<path d="M 0 0 L 10 35 L 15 53" class="char-body" />
<!-- Left leg (lifted/kicked) -->
<path d="M 0 0 L -20 20 L -30 15" class="char-body" />
```

## lifting

Arms extended down gripping a barbell, body slightly bent.

```svg
<!-- Torso -->
<line x1="0" y1="-42" x2="0" y2="0" class="char-body" />
<!-- Arms (reaching down to barbell) -->
<path d="M 0 -37 L -25 -23 L -40 -15" class="char-body" />
<path d="M 0 -37 L 25 -23 L 40 -15" class="char-body" />
<!-- Legs (standing firm) -->
<path d="M 0 0 L -15 35 L -20 53" class="char-body" />
<path d="M 0 0 L 15 35 L 20 53" class="char-body" />
<!-- Barbell (attached to hands) -->
<line x1="-45" y1="-13" x2="45" y2="-13" stroke="#888888" stroke-width="3" stroke-linecap="round" />
<circle cx="-45" cy="-13" r="8" fill="none" stroke="#888888" stroke-width="2.4" />
<circle cx="45" cy="-13" r="8" fill="none" stroke="#888888" stroke-width="2.4" />
```
