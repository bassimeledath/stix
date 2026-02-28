# Stick Figure Animals Library

All animals defined relative to hip/body center at (0, 0). Position on stage via `transform="translate(X, Y)"`.

Animals use the same line style as characters (`stroke: #2a2a2a`, `stroke-linecap: round`, `stroke-linejoin: round`, `fill: none`) with scaled stroke widths per animal size (cat/dog `2`, bird `1.8`, mouse `1.5`).

---

## cat

**Scale:** 60% of human height (~76px tall). Pointed ears, whiskers, curved tail.

```svg
<g class="cat" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none">
  <!-- Body (horizontal, quadruped) -->
  <line x1="-20" y1="0" x2="20" y2="0" />

  <!-- Head -->
  <circle cx="-28" cy="-8" r="10" />
  <!-- Pointed ears -->
  <path d="M -35 -15 L -33 -25 L -28 -16" />
  <path d="M -23 -15 L -21 -25 L -26 -16" />
  <!-- Eyes -->
  <circle cx="-31" cy="-10" r="1.5" fill="#2a2a2a" />
  <circle cx="-25" cy="-10" r="1.5" fill="#2a2a2a" />
  <!-- Whiskers -->
  <line x1="-38" y1="-8" x2="-48" y2="-12" stroke-width="1" />
  <line x1="-38" y1="-6" x2="-48" y2="-6" stroke-width="1" />
  <line x1="-38" y1="-4" x2="-48" y2="0" stroke-width="1" />
  <!-- Nose -->
  <circle cx="-38" cy="-7" r="1" fill="#2a2a2a" />

  <!-- Front legs -->
  <line x1="-15" y1="0" x2="-15" y2="20" class="cat-front-l" />
  <line x1="-10" y1="0" x2="-10" y2="20" class="cat-front-r" />
  <!-- Back legs -->
  <line x1="15" y1="0" x2="15" y2="20" class="cat-back-l" />
  <line x1="20" y1="0" x2="20" y2="20" class="cat-back-r" />

  <!-- Tail (curved upward) -->
  <path d="M 20 0 Q 35 -5 30 -20" class="cat-tail" />
</g>
```

### Cat Walk Cycle

```css
.cat-front-l { animation: catFrontL 0.4s ease-in-out infinite; }
@keyframes catFrontL {
  0%, 100% { d: path("M -15 0 L -18 20"); }
  50%      { d: path("M -15 0 L -12 20"); }
}
.cat-front-r { animation: catFrontR 0.4s ease-in-out infinite; }
@keyframes catFrontR {
  0%, 100% { d: path("M -10 0 L -7 20"); }
  50%      { d: path("M -10 0 L -13 20"); }
}
.cat-back-l { animation: catBackL 0.4s ease-in-out infinite; }
@keyframes catBackL {
  0%, 100% { d: path("M 15 0 L 18 20"); }
  50%      { d: path("M 15 0 L 12 20"); }
}
.cat-back-r { animation: catBackR 0.4s ease-in-out infinite; }
@keyframes catBackR {
  0%, 100% { d: path("M 20 0 L 17 20"); }
  50%      { d: path("M 20 0 L 23 20"); }
}
```

### Tail Wag

```css
.cat-tail { animation: catTailWag 1s ease-in-out infinite; }
@keyframes catTailWag {
  0%, 100% { d: path("M 20 0 Q 35 -5 30 -20"); }
  50%      { d: path("M 20 0 Q 35 -10 28 -22"); }
}
```

---

## dog

**Scale:** 70% of human height (~88px tall). Floppy ears, wagging tail, longer body.

```svg
<g class="dog" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none">
  <!-- Body -->
  <line x1="-25" y1="0" x2="25" y2="0" />

  <!-- Head -->
  <circle cx="-33" cy="-8" r="12" />
  <!-- Floppy ears -->
  <path d="M -42 -14 Q -48 -8 -44 0" />
  <path d="M -26 -14 Q -20 -8 -24 0" />
  <!-- Eyes -->
  <circle cx="-37" cy="-10" r="1.8" fill="#2a2a2a" />
  <circle cx="-29" cy="-10" r="1.8" fill="#2a2a2a" />
  <!-- Nose -->
  <circle cx="-43" cy="-6" r="2" fill="#2a2a2a" />
  <!-- Tongue (optional, happy dog) -->
  <path d="M -43 -3 L -44 4" stroke="#e85c5c" stroke-width="1.5" />

  <!-- Front legs -->
  <line x1="-18" y1="0" x2="-18" y2="25" />
  <line x1="-12" y1="0" x2="-12" y2="25" />
  <!-- Back legs -->
  <path d="M 18 0 L 15 12 L 18 25" />
  <path d="M 23 0 L 20 12 L 23 25" />

  <!-- Tail (wagging) -->
  <path d="M 25 0 Q 38 -15 32 -25" class="dog-tail" />
</g>
```

### Tail Wag (fast, happy)

```css
.dog-tail { animation: dogTailWag 0.3s ease-in-out infinite; }
@keyframes dogTailWag {
  0%, 100% { d: path("M 25 0 Q 38 -15 32 -25"); }
  50%      { d: path("M 25 0 Q 40 -8 38 -20"); }
}
```

---

## bird

**Scale:** 30% of human height (~38px). Wing arcs, small beak.

```svg
<g class="bird" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" fill="none">
  <!-- Body -->
  <ellipse cx="0" cy="0" rx="10" ry="6" />
  <!-- Head -->
  <circle cx="-12" cy="-4" r="5" />
  <!-- Eye -->
  <circle cx="-14" cy="-5" r="1" fill="#2a2a2a" />
  <!-- Beak -->
  <path d="M -17 -4 L -22 -3 L -17 -2" fill="#e8a85c" stroke="#e8a85c" stroke-width="1" />
  <!-- Wing -->
  <path d="M -2 -4 Q 8 -18 18 -8" stroke-width="2" class="bird-wing" />
  <!-- Tail feathers -->
  <path d="M 10 0 L 18 -4" />
  <path d="M 10 0 L 18 2" />
  <!-- Legs -->
  <line x1="-3" y1="6" x2="-3" y2="12" />
  <line x1="3" y1="6" x2="3" y2="12" />
  <!-- Feet -->
  <path d="M -5 12 L -1 12" stroke-width="1" />
  <path d="M 1 12 L 5 12" stroke-width="1" />
</g>
```

### Wing Flap

```css
.bird-wing { animation: wingFlap 0.3s ease-in-out infinite; }
@keyframes wingFlap {
  0%, 100% { d: path("M -2 -4 Q 8 -18 18 -8"); }
  50%      { d: path("M -2 -4 Q 8 -2 18 -6"); }
}
```

### Flying (translate + flap)

```css
.bird-fly {
  animation: birdFly 8s linear infinite;
}
@keyframes birdFly {
  0%   { transform: translate(-100px, 50px); }
  100% { transform: translate(900px, -30px); }
}
```

---

## mouse

**Scale:** 25% of human height (~32px). Round ears, long thin tail.

```svg
<g class="mouse" stroke="#2a2a2a" stroke-width="1.5" stroke-linecap="round" fill="none">
  <!-- Body -->
  <ellipse cx="0" cy="0" rx="8" ry="5" />
  <!-- Head -->
  <circle cx="-10" cy="-2" r="4.5" />
  <!-- Round ears -->
  <circle cx="-14" cy="-7" r="3" />
  <circle cx="-7" cy="-7" r="3" />
  <!-- Eye -->
  <circle cx="-12" cy="-3" r="0.8" fill="#2a2a2a" />
  <!-- Nose -->
  <circle cx="-14.5" cy="-1" r="0.6" fill="#2a2a2a" />
  <!-- Whiskers -->
  <line x1="-15" y1="-2" x2="-22" y2="-4" stroke-width="0.8" />
  <line x1="-15" y1="-1" x2="-22" y2="-1" stroke-width="0.8" />
  <line x1="-15" y1="0" x2="-22" y2="2" stroke-width="0.8" />
  <!-- Legs (tiny) -->
  <line x1="-4" y1="5" x2="-4" y2="9" />
  <line x1="0" y1="5" x2="0" y2="9" />
  <line x1="4" y1="5" x2="4" y2="9" />
  <!-- Tail (long, curving) -->
  <path d="M 8 0 Q 20 -5 25 5 Q 30 12 35 8" />
</g>
```

### Mouse Scurry

```css
.mouse-scurry {
  animation: mouseScurry 0.2s linear infinite;
}
@keyframes mouseScurry {
  0%, 100% { transform: translateY(0); }
  50%      { transform: translateY(-2px); }
}

/* Combine with horizontal movement */
.mouse-run {
  animation: mouseRun 8s linear infinite;
}
@keyframes mouseRun {
  0%   { transform: translateX(-50px); }
  100% { transform: translateX(850px); }
}
```
