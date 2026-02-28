# Props Library

Reusable SVG snippets for scene props. All positioned at a reference origin — use `transform="translate(X, Y)"` to place on stage.

---

## bench

Park bench. Width ~160px, seat at y=0 reference.

```svg
<g class="bench" stroke="#2a2a2a" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" fill="none">
  <!-- Seat -->
  <line x1="-80" y1="0" x2="80" y2="0" />
  <!-- Back rest -->
  <line x1="-75" y1="-35" x2="-75" y2="0" />
  <line x1="-75" y1="-35" x2="75" y2="-35" />
  <line x1="75" y1="-35" x2="75" y2="0" />
  <!-- Back slats -->
  <line x1="-20" y1="-33" x2="-20" y2="-2" />
  <line x1="10" y1="-33" x2="10" y2="-2" />
  <line x1="40" y1="-33" x2="40" y2="-2" />
  <!-- Legs -->
  <line x1="-65" y1="0" x2="-70" y2="40" />
  <line x1="65" y1="0" x2="70" y2="40" />
  <!-- Arm rests -->
  <line x1="-80" y1="-15" x2="-85" y2="0" />
  <line x1="80" y1="-15" x2="85" y2="0" />
</g>
```

## table

Simple table. Width ~160px, surface at y=0.

```svg
<g class="table">
  <!-- Surface -->
  <line x1="-80" y1="0" x2="80" y2="0" stroke="#d4d0c8" stroke-width="2" stroke-linecap="round" />
  <!-- Legs -->
  <line x1="-70" y1="0" x2="-70" y2="60" stroke="#d4d0c8" stroke-width="2" stroke-linecap="round" />
  <line x1="70" y1="0" x2="70" y2="60" stroke="#d4d0c8" stroke-width="2" stroke-linecap="round" />
</g>
```

## heart

Whole heart. Center at (0, 0), ~32px wide.

```svg
<path d="M 0 -12 C -8 -20, -16 -12, -16 -4 C -16 4, 0 12, 0 12 C 0 12, 16 4, 16 -4 C 16 -12, 8 -20, 0 -12 Z" fill="#e85c5c" />
```

## broken_heart

Heart split in two halves with crack.

```svg
<g class="broken-heart">
  <!-- Left half -->
  <path d="M 0 -12 C -8 -20, -16 -12, -16 -4 C -16 4, 0 12, 0 12 L 0 -12 Z" fill="#e85c5c" />
  <!-- Right half (offset slightly) -->
  <path d="M 3 -12 C 11 -20, 19 -12, 19 -4 C 19 4, 3 12, 3 12 L 3 -12 Z" fill="#e85c5c" />
  <!-- Crack line -->
  <path d="M 0 -10 L 2 -5 L -1 0 L 2 5 L 0 10" stroke="#faf9f6" stroke-width="1.5" fill="none" stroke-linecap="round" />
</g>
```

## barbell

Horizontal bar with weights. Width ~90px.

```svg
<g class="barbell">
  <line x1="-45" y1="0" x2="45" y2="0" stroke="#888888" stroke-width="3" stroke-linecap="round" />
  <circle cx="-45" cy="0" r="8" fill="none" stroke="#888888" stroke-width="2.4" />
  <circle cx="45" cy="0" r="8" fill="none" stroke="#888888" stroke-width="2.4" />
</g>
```

## sun

Sun with rays. Center at (0, 0).

```svg
<g class="sun">
  <circle cx="0" cy="0" r="26" fill="#f0c040" />
  <g stroke="#f0c040" stroke-width="2.5" stroke-linecap="round">
    <line x1="0" y1="-38" x2="0" y2="-50" />
    <line x1="0" y1="38" x2="0" y2="50" />
    <line x1="-38" y1="0" x2="-50" y2="0" />
    <line x1="38" y1="0" x2="50" y2="0" />
    <line x1="-27" y1="-27" x2="-35" y2="-35" />
    <line x1="27" y1="-27" x2="35" y2="-35" />
    <line x1="-27" y1="27" x2="-35" y2="35" />
    <line x1="27" y1="27" x2="35" y2="35" />
  </g>
</g>
```

Optional glow layer:
```svg
<circle cx="0" cy="0" r="45" fill="#f0c040" opacity="0.15" />
```

## cloud

Fluffy cloud. Width ~60px.

```svg
<g class="cloud" opacity="0.5">
  <circle cx="-12" cy="0" r="12" fill="#8bb8d0" />
  <circle cx="2" cy="-4" r="14" fill="#8bb8d0" />
  <circle cx="16" cy="1" r="11" fill="#8bb8d0" />
  <circle cx="-5" cy="6" r="10" fill="#8bb8d0" />
  <circle cx="10" cy="6" r="10" fill="#8bb8d0" />
</g>
```

## rain_cloud

Cloud with rain streaks.

```svg
<g class="rain-cloud">
  <!-- Cloud body -->
  <circle cx="-12" cy="0" r="12" fill="#8bb8d0" opacity="0.5" />
  <circle cx="2" cy="-4" r="14" fill="#8bb8d0" opacity="0.5" />
  <circle cx="16" cy="1" r="11" fill="#8bb8d0" opacity="0.5" />
  <circle cx="-5" cy="6" r="10" fill="#8bb8d0" opacity="0.45" />
  <circle cx="10" cy="6" r="10" fill="#8bb8d0" opacity="0.45" />
  <!-- Rain drops -->
  <line x1="-10" y1="14" x2="-12" y2="22" stroke="#8bb8d0" stroke-width="1.8" stroke-linecap="round" />
  <line x1="0" y1="16" x2="-2" y2="24" stroke="#8bb8d0" stroke-width="1.8" stroke-linecap="round" />
  <line x1="10" y1="14" x2="8" y2="22" stroke="#8bb8d0" stroke-width="1.8" stroke-linecap="round" />
  <line x1="-5" y1="18" x2="-7" y2="26" stroke="#8bb8d0" stroke-width="1.8" stroke-linecap="round" />
  <line x1="5" y1="17" x2="3" y2="25" stroke="#8bb8d0" stroke-width="1.8" stroke-linecap="round" />
</g>
```

## tree

Simple tree. Trunk from ground, canopy of overlapping circles.

```svg
<g class="tree" stroke="#2a2a2a" stroke-width="1.5" stroke-linecap="round" fill="none" opacity="0.25">
  <line x1="0" y1="0" x2="0" y2="-65" />
  <circle cx="0" cy="-80" r="20" />
  <circle cx="-15" cy="-70" r="14" />
  <circle cx="15" cy="-70" r="14" />
</g>
```

Place with `transform="translate(X, GROUND_Y)"` where GROUND_Y is 355.

## pizza_slice

Single pizza slice. Triangle with toppings.

```svg
<g class="pizza-slice">
  <path d="M 0 -10 L 7 0 L -7 0 Z" fill="#e8a85c" stroke="#2a2a2a" stroke-width="1.2" stroke-linejoin="round" />
  <circle cx="1" cy="-3" r="1.2" fill="#e85c5c" />
  <circle cx="-2" cy="-2" r="1" fill="#7a9a3a" />
</g>
```

## pizza_box

Closed pizza box.

```svg
<g class="pizza-box">
  <rect x="-17" y="-3" width="35" height="6" rx="1" fill="none" stroke="#2a2a2a" stroke-width="1.8" />
  <line x1="-17" y1="0" x2="18" y2="0" stroke="#e8a85c" stroke-width="0.8" opacity="0.5" />
</g>
```

## salad_bowl

Bowl with leafy greens.

```svg
<g class="salad-bowl">
  <path d="M -15 0 Q -15 -12 0 -15 Q 15 -12 15 0 Z" fill="#7ec87e" fill-opacity="0.3" stroke="#7ec87e" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
  <path d="M -7 -6 Q -3 -12 1 -6" fill="none" stroke="#5aa55a" stroke-width="1.5" stroke-linecap="round" />
  <path d="M -2 -4 Q 3 -10 7 -4" fill="none" stroke="#5aa55a" stroke-width="1.5" stroke-linecap="round" />
  <path d="M -10 -3 Q -6 -8 -2 -2" fill="none" stroke="#5aa55a" stroke-width="1.5" stroke-linecap="round" />
  <path d="M -17 0 L 17 0" stroke="#7ec87e" stroke-width="2" stroke-linecap="round" />
</g>
```

## coffee_mug

Simple mug with steam.

```svg
<g class="coffee-mug">
  <rect x="-8" y="-12" width="16" height="16" rx="2" fill="none" stroke="#2a2a2a" stroke-width="2" />
  <!-- Handle -->
  <path d="M 8 -8 Q 16 -4 8 0" fill="none" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" />
  <!-- Steam wisps -->
  <path d="M -3 -14 Q -5 -22 -2 -28" fill="none" stroke="#d4d0c8" stroke-width="1.2" stroke-linecap="round" />
  <path d="M 3 -15 Q 5 -23 2 -30" fill="none" stroke="#d4d0c8" stroke-width="1.2" stroke-linecap="round" />
</g>
```

## bicycle

Simple stick bicycle.

```svg
<g class="bicycle" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" fill="none">
  <!-- Wheels -->
  <circle cx="-20" cy="0" r="15" />
  <circle cx="20" cy="0" r="15" />
  <!-- Frame -->
  <line x1="-20" y1="0" x2="0" y2="-20" />
  <line x1="0" y1="-20" x2="20" y2="0" />
  <line x1="0" y1="-20" x2="-10" y2="-25" />
  <line x1="0" y1="-20" x2="5" y2="-30" />
  <!-- Handlebars -->
  <line x1="2" y1="-32" x2="10" y2="-30" />
  <!-- Seat -->
  <line x1="-12" y1="-27" x2="-6" y2="-25" />
</g>
```

## speech_bubble

Speech bubble with tail pointing down-left.

```svg
<g class="speech-bubble">
  <ellipse cx="0" cy="-20" rx="38" ry="18" fill="#faf9f6" stroke="#2a2a2a" stroke-width="1.8" />
  <!-- Tail -->
  <path d="M -10 -4 L -18 10 L 0 -6" fill="#faf9f6" stroke="#2a2a2a" stroke-width="1.5" />
  <!-- Fill overlap to clean interior -->
  <ellipse cx="0" cy="-20" rx="30" ry="12" fill="#faf9f6" stroke="none" />
</g>
```

Add text inside: `<text x="0" y="-18" text-anchor="middle" font-size="10" fill="#2a2a2a">Hello!</text>`

## thought_bubble

Thought bubble with small leading circles.

```svg
<g class="thought-bubble">
  <!-- Leading dots -->
  <circle cx="-20" cy="10" r="3" fill="none" stroke="#2a2a2a" stroke-width="1.2" />
  <circle cx="-28" cy="0" r="4.5" fill="none" stroke="#2a2a2a" stroke-width="1.2" />
  <!-- Main cloud -->
  <ellipse cx="0" cy="-25" rx="38" ry="22" fill="#faf9f6" stroke="#2a2a2a" stroke-width="1.8" />
  <circle cx="-20" cy="-30" r="12" fill="#faf9f6" stroke="#2a2a2a" stroke-width="1.5" />
  <circle cx="20" cy="-33" r="13" fill="#faf9f6" stroke="#2a2a2a" stroke-width="1.5" />
  <circle cx="0" cy="-38" r="11" fill="#faf9f6" stroke="#2a2a2a" stroke-width="1.5" />
  <!-- Fill interior -->
  <ellipse cx="0" cy="-27" rx="30" ry="16" fill="#faf9f6" stroke="none" />
</g>
```

## musical_note

Single eighth note.

```svg
<text font-size="20" fill="#b8a080">&#9834;</text>
```

Double note: `&#9835;`

## sparkle

4-point sparkle star (cross pattern).

```svg
<g class="sparkle">
  <path d="M 0 -5 L 0 5 M -5 0 L 5 0" stroke="#f0c040" stroke-width="2" stroke-linecap="round" />
</g>
```

## tv

Television with antenna and flickering screen.

```svg
<g class="tv">
  <!-- Stand -->
  <line x1="-10" y1="25" x2="-10" y2="40" stroke="#2a2a2a" stroke-width="2" />
  <line x1="10" y1="25" x2="10" y2="40" stroke="#2a2a2a" stroke-width="2" />
  <line x1="-20" y1="40" x2="20" y2="40" stroke="#2a2a2a" stroke-width="2" />
  <!-- TV body -->
  <rect x="-35" y="-25" width="70" height="50" rx="3" fill="none" stroke="#2a2a2a" stroke-width="2.4" />
  <!-- Screen -->
  <rect x="-30" y="-20" width="60" height="40" rx="1" fill="#1a2a3a" opacity="0.15" />
  <!-- Antenna -->
  <line x1="-8" y1="-25" x2="-15" y2="-40" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
  <line x1="8" y1="-25" x2="15" y2="-40" stroke="#2a2a2a" stroke-width="1.8" stroke-linecap="round" />
</g>
```

## couch

Couch/sofa. Width ~140px.

```svg
<g class="couch">
  <rect x="-70" y="0" width="140" height="22" rx="4" fill="none" stroke="#2a2a2a" stroke-width="2.4" />
  <!-- Back -->
  <rect x="-70" y="-50" width="12" height="72" rx="4" fill="none" stroke="#2a2a2a" stroke-width="2.4" />
  <!-- Armrest -->
  <rect x="58" y="-25" width="12" height="47" rx="4" fill="none" stroke="#2a2a2a" stroke-width="2.4" />
  <!-- Legs -->
  <line x1="-60" y1="22" x2="-60" y2="40" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" />
  <line x1="60" y1="22" x2="60" y2="40" stroke="#2a2a2a" stroke-width="2" stroke-linecap="round" />
  <!-- Cushion line -->
  <line x1="0" y1="0" x2="0" y2="20" stroke="#2a2a2a" stroke-width="1.2" opacity="0.4" />
</g>
```

## window

Window with cross panes and sill.

```svg
<g class="window">
  <rect x="-35" y="-40" width="70" height="80" rx="2" fill="none" stroke="#d4d0c8" stroke-width="2" />
  <line x1="0" y1="-40" x2="0" y2="40" stroke="#d4d0c8" stroke-width="1.2" />
  <line x1="-35" y1="0" x2="35" y2="0" stroke="#d4d0c8" stroke-width="1.2" />
  <!-- Sill -->
  <line x1="-40" y1="40" x2="40" y2="40" stroke="#d4d0c8" stroke-width="2" />
</g>
```
