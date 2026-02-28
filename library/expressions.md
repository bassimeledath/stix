# Facial Expressions Library

All expressions defined relative to head center `(cx, cy)`. The head circle is at `cx, cy` with radius 18 (male) or 16 (female).

Eyes are at `(cx-6, cy-3)` and `(cx+6, cy-3)`.
Mouth baseline is at `cy+5`.

---

## happy

Upward-curving smile arc. Eyes at normal size.

```svg
<!-- Eyes -->
<circle cx="CX-6" cy="CY-3" r="2" class="char-eyes" />
<circle cx="CX+6" cy="CY-3" r="2" class="char-eyes" />
<!-- Mouth: smile arc -->
<path d="M CX-8 CY+5 Q CX CY+15 CX+8 CY+5" class="char-mouth" />
```

## sad

Downward-curving frown. Eyebrows angled inward-up.

```svg
<!-- Eyes -->
<circle cx="CX-6" cy="CY-3" r="2" class="char-eyes" />
<circle cx="CX+6" cy="CY-3" r="2" class="char-eyes" />
<!-- Sad eyebrows (angled inward-up) -->
<line x1="CX-9" y1="CY-7" x2="CX-3" y2="CY-6" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<line x1="CX+9" y1="CY-7" x2="CX+3" y2="CY-6" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: frown arc -->
<path d="M CX-8 CY+7 Q CX CY+0 CX+8 CY+7" class="char-mouth" />
```

## neutral

Flat horizontal line mouth. Default resting face.

```svg
<!-- Eyes -->
<circle cx="CX-6" cy="CY-3" r="2" class="char-eyes" />
<circle cx="CX+6" cy="CY-3" r="2" class="char-eyes" />
<!-- Mouth: flat line -->
<line x1="CX-5" y1="CY+5" x2="CX+5" y2="CY+5" class="char-mouth" />
```

## surprised

Mouth is a small open circle. Eyes wider (larger radius).

```svg
<!-- Eyes (wider) -->
<circle cx="CX-6" cy="CY-3" r="2.8" class="char-eyes" />
<circle cx="CX+6" cy="CY-3" r="2.8" class="char-eyes" />
<!-- Raised eyebrows -->
<line x1="CX-9" y1="CY-9" x2="CX-3" y2="CY-8" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<line x1="CX+9" y1="CY-9" x2="CX+3" y2="CY-8" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: open O -->
<circle cx="CX" cy="CY+7" r="4" class="char-mouth" />
```

## determined

Flat pressed mouth, slight furrowed brows. Resolute face.

```svg
<!-- Eyes -->
<circle cx="CX-6" cy="CY-3" r="2" class="char-eyes" />
<circle cx="CX+6" cy="CY-3" r="2" class="char-eyes" />
<!-- Furrowed brows (angled inward-down) -->
<line x1="CX-9" y1="CY-6" x2="CX-3" y2="CY-7" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<line x1="CX+9" y1="CY-6" x2="CX+3" y2="CY-7" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: pressed flat line -->
<line x1="CX-5" y1="CY+5" x2="CX+5" y2="CY+5" stroke="#2a2a2a" stroke-width="2.4" stroke-linecap="round" />
```

## angry

V-shaped brows angled down, tight frown.

```svg
<!-- Eyes -->
<circle cx="CX-6" cy="CY-3" r="2" class="char-eyes" />
<circle cx="CX+6" cy="CY-3" r="2" class="char-eyes" />
<!-- Angry brows (steep V, angled inward-down) -->
<line x1="CX-10" y1="CY-5" x2="CX-3" y2="CY-8" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" />
<line x1="CX+10" y1="CY-5" x2="CX+3" y2="CY-8" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" />
<!-- Mouth: tight frown -->
<path d="M CX-6 CY+6 Q CX CY+2 CX+6 CY+6" class="char-mouth" />
```

## laughing

Wide open mouth arc, eyes squinted (reduced to arcs).

```svg
<!-- Eyes (squinted — arcs instead of circles) -->
<path d="M CX-8 CY-3 Q CX-6 CY-5 CX-4 CY-3" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" fill="none" />
<path d="M CX+4 CY-3 Q CX+6 CY-5 CX+8 CY-3" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" fill="none" />
<!-- Mouth: wide open smile -->
<path d="M CX-10 CY+4 Q CX CY+18 CX+10 CY+4" class="char-mouth" />
```

## crying

Tears streaming, sad mouth, eyebrows up.

```svg
<!-- Eyes -->
<circle cx="CX-6" cy="CY-3" r="2" class="char-eyes" />
<circle cx="CX+6" cy="CY-3" r="2" class="char-eyes" />
<!-- Sad eyebrows -->
<line x1="CX-9" y1="CY-7" x2="CX-3" y2="CY-6" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<line x1="CX+9" y1="CY-7" x2="CX+3" y2="CY-6" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: wobbly frown -->
<path d="M CX-8 CY+7 Q CX CY+0 CX+8 CY+7" class="char-mouth" />
<!-- Tear drops -->
<path d="M CX-6 CY L CX-7 CY+8" stroke="#8bb8d0" stroke-width="1.5" stroke-linecap="round" />
<path d="M CX+6 CY L CX+7 CY+8" stroke="#8bb8d0" stroke-width="1.5" stroke-linecap="round" />
```

## smirk

Asymmetric half-smile.

```svg
<!-- Eyes -->
<circle cx="CX-6" cy="CY-3" r="2" class="char-eyes" />
<circle cx="CX+6" cy="CY-3" r="2" class="char-eyes" />
<!-- One raised eyebrow -->
<line x1="CX+3" y1="CY-8" x2="CX+9" y2="CY-7" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: asymmetric smile (one side up) -->
<path d="M CX-6 CY+5 Q CX CY+6 CX+6 CY+2" class="char-mouth" />
```
