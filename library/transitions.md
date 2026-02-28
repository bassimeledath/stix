# Animation Transitions Library

CSS keyframe patterns for common motions. All timings assume `animation-duration: 8s` for the scene and `infinite` looping.

Example values below use the default hip position **(450, 295)**, giving shoulder at (450, 258), head center at (450, 235), knee-Y at 330, and feet-Y at 348. **Adjust these values per character position.**

---

## walk_cycle

**Duration:** 0.5s sub-loop
**Use:** Character walking in place (combine with `translateX` on parent group to move across stage).

```css
/* Leg oscillation */
.walk-leg-l {
  animation: walkLegL 0.5s ease-in-out infinite;
}
@keyframes walkLegL {
  0%, 100% { d: path("M 450 295 L 435 330 L 435 348"); }
  50%      { d: path("M 450 295 L 465 330 L 465 348"); }
}

.walk-leg-r {
  animation: walkLegR 0.5s ease-in-out infinite;
}
@keyframes walkLegR {
  0%, 100% { d: path("M 450 295 L 465 330 L 465 348"); }
  50%      { d: path("M 450 295 L 435 330 L 435 348"); }
}

/* Arm swing (opposite phase to legs) */
.walk-arm-l {
  animation: walkArmL 0.5s ease-in-out infinite;
}
@keyframes walkArmL {
  0%, 100% { d: path("M 450 258 L 432 278 L 430 293"); }
  50%      { d: path("M 450 258 L 468 278 L 470 293"); }
}

.walk-arm-r {
  animation: walkArmR 0.5s ease-in-out infinite;
}
@keyframes walkArmR {
  0%, 100% { d: path("M 450 258 L 468 278 L 470 293"); }
  50%      { d: path("M 450 258 L 432 278 L 430 293"); }
}

/* Bounce (apply to character group) */
.walk-bounce {
  animation: walkBounce 0.5s ease-in-out infinite;
}
@keyframes walkBounce {
  0%, 100% { transform: translateY(0); }
  42%      { transform: translateY(-5px); }
}
```

## run_cycle

**Duration:** 0.4s sub-loop
**Use:** Faster locomotion. Wider stride, more body lean. Uses `linear` timing for smooth locomotion.

```css
.run-leg-l {
  animation: runLegL 0.4s linear infinite;
  transform-origin: 450px 295px;  /* hip position */
}
@keyframes runLegL {
  0%   { transform: rotate(-20deg); }
  50%  { transform: rotate(20deg); }
  100% { transform: rotate(-20deg); }
}

.run-leg-r {
  animation: runLegR 0.4s linear infinite;
  transform-origin: 450px 295px;
}
@keyframes runLegR {
  0%   { transform: rotate(20deg); }
  50%  { transform: rotate(-20deg); }
  100% { transform: rotate(20deg); }
}

.run-arm-l {
  animation: runArmL 0.4s linear infinite;
  transform-origin: 450px 258px;  /* shoulder position */
}
@keyframes runArmL {
  0%   { transform: rotate(15deg); }
  50%  { transform: rotate(-15deg); }
  100% { transform: rotate(15deg); }
}

.run-arm-r {
  animation: runArmR 0.4s linear infinite;
  transform-origin: 450px 258px;
}
@keyframes runArmR {
  0%   { transform: rotate(-15deg); }
  50%  { transform: rotate(15deg); }
  100% { transform: rotate(-15deg); }
}
```

## sit_down

**Duration:** one-shot within 8s scene
**Use:** Character transitions from standing to sitting.

```css
.sit-down {
  animation: sitDown 8s ease-in-out infinite;
}
@keyframes sitDown {
  0%, 20%  { transform: translateY(0); }     /* standing */
  40%, 100% { transform: translateY(20px); }  /* seated (lower hips) */
}

/* Legs bend during sit */
.sit-legs {
  animation: sitLegs 8s ease-in-out infinite;
}
@keyframes sitLegs {
  0%, 20%  { d: path("M 450 295 L 435 330 L 430 348"); }
  40%, 100% { d: path("M 450 295 L 437 318 L 430 348"); }
}
```

## stand_up

**Duration:** one-shot within 8s scene
**Use:** Reverse of sit_down.

```css
.stand-up {
  animation: standUp 8s ease-in-out infinite;
}
@keyframes standUp {
  0%, 40%  { transform: translateY(20px); }   /* seated */
  60%, 100% { transform: translateY(0); }      /* standing */
}
```

## jump

**Duration:** one-shot within 8s scene
**Use:** Character jumps up and lands.

```css
.jump-char {
  animation: jumpChar 8s ease-in-out infinite;
}
@keyframes jumpChar {
  0%, 40%  { transform: translateY(0); }
  48%      { transform: translateY(5px); }     /* crouch */
  55%      { transform: translateY(-50px); }   /* peak */
  65%      { transform: translateY(0); }       /* land */
  100%     { transform: translateY(0); }
}
```

## wave

**Duration:** 1s sub-loop
**Use:** Right hand oscillates in a wave gesture.

```css
.wave-hand {
  animation: waveHand 1s ease-in-out infinite;
  transform-origin: 450px 258px;  /* shoulder position */
}
@keyframes waveHand {
  0%, 100% { transform: rotate(-5deg); }
  50%      { transform: rotate(15deg); }
}
```

## phase_transition

**Use:** Multi-moment scenes where different character states appear/disappear. Each phase gets equal screen time within the 8s loop.

```css
/* 4-phase example (2s each) */
.phase1 { animation: phase1vis 8s infinite ease-in-out; }
@keyframes phase1vis {
  0%, 20%   { opacity: 1; }
  25%, 100% { opacity: 0; }
}

.phase2 { animation: phase2vis 8s infinite ease-in-out; }
@keyframes phase2vis {
  0%, 20%   { opacity: 0; }
  25%, 45%  { opacity: 1; }
  50%, 100% { opacity: 0; }
}

.phase3 { animation: phase3vis 8s infinite ease-in-out; }
@keyframes phase3vis {
  0%, 45%   { opacity: 0; }
  50%, 70%  { opacity: 1; }
  75%, 100% { opacity: 0; }
}

.phase4 { animation: phase4vis 8s infinite ease-in-out; }
@keyframes phase4vis {
  0%, 70%   { opacity: 0; }
  75%, 97%  { opacity: 1; }
  100%      { opacity: 0; }
}
```

Adjust percentage boundaries for 2-phase (50/50), 3-phase (33/33/33), etc.

## character_translate

**Use:** Move character across the stage over the full 8s loop. Uses `linear` timing for smooth constant-speed locomotion.

```css
/* Left to right walk */
.walk-across {
  animation: walkAcross 8s linear infinite;
}
@keyframes walkAcross {
  0%   { transform: translateX(-120px); }
  100% { transform: translateX(850px); }
}

/* Enter from left, stop at center */
.enter-left {
  animation: enterLeft 8s ease-out infinite;
}
@keyframes enterLeft {
  0%        { transform: translateX(-200px); }
  30%, 100% { transform: translateX(0); }
}

/* Exit right */
.exit-right {
  animation: exitRight 8s ease-in infinite;
}
@keyframes exitRight {
  0%, 60%  { transform: translateX(0); opacity: 1; }
  90%      { transform: translateX(280px); opacity: 0.3; }
  100%     { transform: translateX(280px); opacity: 0; }
}
```

## emotion_shift

**Use:** Animate facial expression changes (mouth path morphing). Values below use default head center at (450, 235). Adjust per character position.

```css
/* Neutral → sad */
.mouth-to-sad {
  animation: mouthSad 8s ease-in-out infinite;
}
@keyframes mouthSad {
  0%, 48%   { d: path("M 442 240 L 458 240"); }                /* neutral */
  60%, 100% { d: path("M 442 242 Q 450 235 458 242"); }        /* sad */
}

/* Neutral → happy */
.mouth-to-happy {
  animation: mouthHappy 8s ease-in-out infinite;
}
@keyframes mouthHappy {
  0%, 48%   { d: path("M 442 240 L 458 240"); }                /* neutral */
  60%, 100% { d: path("M 442 240 Q 450 250 458 240"); }        /* happy */
}
```

## head_drop

**Use:** Head tilts/droops downward (sadness, tiredness).

```css
.head-drop {
  animation: headDrop 8s ease-in-out infinite;
  transform-origin: 450px 235px;  /* head center position */
}
@keyframes headDrop {
  0%, 72%   { transform: translate(0, 0) rotate(0deg); }
  85%, 100% { transform: translate(14px, 20px) rotate(25deg); }
}
```

## sweat_drops

**Use:** Effort/stress indicator. Small circles that appear and drift away.

```css
.sweat-drop {
  animation: sweatDrop 0.8s ease-out infinite;
}
@keyframes sweatDrop {
  0%   { transform: translate(0, 0); opacity: 0.9; }
  100% { transform: translate(25px, -10px); opacity: 0; }
}
```

Stagger multiple drops with `animation-delay: 0.2s`, `0.4s`, etc.
