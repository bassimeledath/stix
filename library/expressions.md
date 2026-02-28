# Facial Expressions Library

All expressions defined relative to **head center at (0, 0)**. Wrap in `<g transform="translate(HEAD_CX, HEAD_CY)">` to position on stage. Default head center is at (0, -60) relative to hip.

The head circle is at `(0, 0)` with radius 18 (male) or 16 (female).

Eyes are at `(-6, -3)` and `(6, -3)`.
Mouth baseline is at `y=5`.

---

## happy

Upward-curving smile arc. Eyes at normal size.

```svg
<!-- Eyes -->
<circle cx="-6" cy="-3" r="2" class="char-eyes" />
<circle cx="6" cy="-3" r="2" class="char-eyes" />
<!-- Mouth: smile arc -->
<path d="M -8 5 Q 0 15 8 5" class="char-mouth" />
```

## sad

Downward-curving frown. Eyebrows angled inward-up.

```svg
<!-- Eyes -->
<circle cx="-6" cy="-3" r="2" class="char-eyes" />
<circle cx="6" cy="-3" r="2" class="char-eyes" />
<!-- Sad eyebrows (angled inward-up) -->
<line x1="-9" y1="-7" x2="-3" y2="-6" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<line x1="9" y1="-7" x2="3" y2="-6" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: frown arc -->
<path d="M -8 7 Q 0 0 8 7" class="char-mouth" />
```

## neutral

Flat horizontal line mouth. Default resting face.

```svg
<!-- Eyes -->
<circle cx="-6" cy="-3" r="2" class="char-eyes" />
<circle cx="6" cy="-3" r="2" class="char-eyes" />
<!-- Mouth: flat line -->
<line x1="-5" y1="5" x2="5" y2="5" class="char-mouth" />
```

## surprised

Mouth is a small open circle. Eyes wider (larger radius).

```svg
<!-- Eyes (wider) -->
<circle cx="-6" cy="-3" r="2.8" class="char-eyes" />
<circle cx="6" cy="-3" r="2.8" class="char-eyes" />
<!-- Raised eyebrows -->
<line x1="-9" y1="-9" x2="-3" y2="-8" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<line x1="9" y1="-9" x2="3" y2="-8" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: open O -->
<circle cx="0" cy="7" r="4" class="char-mouth" />
```

## determined

Flat pressed mouth, slight furrowed brows. Resolute face.

```svg
<!-- Eyes -->
<circle cx="-6" cy="-3" r="2" class="char-eyes" />
<circle cx="6" cy="-3" r="2" class="char-eyes" />
<!-- Furrowed brows (angled inward-down) -->
<line x1="-9" y1="-6" x2="-3" y2="-7" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<line x1="9" y1="-6" x2="3" y2="-7" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: pressed flat line -->
<line x1="-5" y1="5" x2="5" y2="5" stroke="#2a2a2a" stroke-width="2.4" stroke-linecap="round" />
```

## angry

V-shaped brows angled down, tight frown.

```svg
<!-- Eyes -->
<circle cx="-6" cy="-3" r="2" class="char-eyes" />
<circle cx="6" cy="-3" r="2" class="char-eyes" />
<!-- Angry brows (steep V, angled inward-down) -->
<line x1="-10" y1="-5" x2="-3" y2="-8" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" />
<line x1="10" y1="-5" x2="3" y2="-8" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" />
<!-- Mouth: tight frown -->
<path d="M -6 6 Q 0 2 6 6" class="char-mouth" />
```

## laughing

Wide open mouth arc, eyes squinted (reduced to arcs).

```svg
<!-- Eyes (squinted — arcs instead of circles) -->
<path d="M -8 -3 Q -6 -5 -4 -3" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" fill="none" />
<path d="M 4 -3 Q 6 -5 8 -3" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" fill="none" />
<!-- Mouth: wide open smile -->
<path d="M -10 4 Q 0 18 10 4" class="char-mouth" />
```

## crying

Tears streaming, sad mouth, eyebrows up.

```svg
<!-- Eyes -->
<circle cx="-6" cy="-3" r="2" class="char-eyes" />
<circle cx="6" cy="-3" r="2" class="char-eyes" />
<!-- Sad eyebrows -->
<line x1="-9" y1="-7" x2="-3" y2="-6" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<line x1="9" y1="-7" x2="3" y2="-6" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: wobbly frown -->
<path d="M -8 7 Q 0 0 8 7" class="char-mouth" />
<!-- Tear drops -->
<path d="M -6 0 L -7 8" stroke="#8bb8d0" stroke-width="1.5" stroke-linecap="round" />
<path d="M 6 0 L 7 8" stroke="#8bb8d0" stroke-width="1.5" stroke-linecap="round" />
```

## smirk

Asymmetric half-smile.

```svg
<!-- Eyes -->
<circle cx="-6" cy="-3" r="2" class="char-eyes" />
<circle cx="6" cy="-3" r="2" class="char-eyes" />
<!-- One raised eyebrow -->
<line x1="3" y1="-8" x2="9" y2="-7" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
<!-- Mouth: asymmetric smile (one side up) -->
<path d="M -6 5 Q 0 6 6 2" class="char-mouth" />
```
