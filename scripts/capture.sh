#!/bin/bash
# Capture animated HTML scenes and stitch into GIF + MP4
# Usage: ./capture.sh [options]
#
# Options:
#   --scenes-dir DIR    Directory containing scene-*.html files (default: .stix/scenes)
#   --frames-dir DIR    Directory to store captured frames (default: .stix/frames)
#   --output-dir DIR    Directory for output files (default: .stix/output)
#   --fps N             Frames per second for output (default: 8)
#   --format FORMAT     Output format: gif, mp4, both (default: both)
#   --width N           Output width in pixels (default: 800)

set -e

# Defaults
SCENES_DIR=".stix/scenes"
FRAMES_DIR=".stix/frames"
OUTPUT_DIR=".stix/output"
FPS=8
FORMAT="both"
WIDTH=800

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --scenes-dir)  [[ -n "${2:-}" ]] || { echo "Error: --scenes-dir requires a value"; exit 1; }; SCENES_DIR="$2"; shift 2 ;;
    --frames-dir)  [[ -n "${2:-}" ]] || { echo "Error: --frames-dir requires a value"; exit 1; }; FRAMES_DIR="$2"; shift 2 ;;
    --output-dir)  [[ -n "${2:-}" ]] || { echo "Error: --output-dir requires a value"; exit 1; }; OUTPUT_DIR="$2"; shift 2 ;;
    --fps)         [[ -n "${2:-}" ]] || { echo "Error: --fps requires a value"; exit 1; }; FPS="$2"; shift 2 ;;
    --format)      [[ -n "${2:-}" ]] || { echo "Error: --format requires a value"; exit 1; }; FORMAT="$2"; shift 2 ;;
    --width)       [[ -n "${2:-}" ]] || { echo "Error: --width requires a value"; exit 1; }; WIDTH="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Validate numeric parameters
if ! [[ "$FPS" =~ ^[0-9]+$ ]] || [ "$FPS" -lt 1 ]; then
  echo "Error: --fps must be a positive integer, got: $FPS"
  exit 1
fi

if ! [[ "$WIDTH" =~ ^[0-9]+$ ]] || [ "$WIDTH" -lt 1 ]; then
  echo "Error: --width must be a positive integer, got: $WIDTH"
  exit 1
fi

# Validate format
if [[ "$FORMAT" != "gif" && "$FORMAT" != "mp4" && "$FORMAT" != "both" ]]; then
  echo "Error: --format must be gif, mp4, or both, got: $FORMAT"
  exit 1
fi

# Validate scenes directory
if [ ! -d "$SCENES_DIR" ]; then
  echo "Error: scenes directory not found: $SCENES_DIR"
  exit 1
fi

command -v agent-browser >/dev/null 2>&1 || { echo "Error: agent-browser not found. Install it first."; exit 1; }
command -v ffmpeg >/dev/null 2>&1 || { echo "Error: ffmpeg not found. Install it first."; exit 1; }

# Cleanup trap: ensure browser is closed and temp frames cleaned on failure
BROWSER_OPEN=false
cleanup() {
  if $BROWSER_OPEN; then
    agent-browser close 2>/dev/null || true
  fi
}
trap cleanup EXIT

# Setup frames directory (guard: only remove if it looks like our frames dir)
if [ -d "$FRAMES_DIR" ]; then
  case "$FRAMES_DIR" in
    *frames*|*.stix/*)
      rm -rf "$FRAMES_DIR"
      ;;
    *)
      echo "Error: refusing to rm -rf '$FRAMES_DIR' — does not look like a frames directory"
      exit 1
      ;;
  esac
fi
mkdir -p "$FRAMES_DIR" "$OUTPUT_DIR"

# Discover scenes using glob (safe with spaces/special chars)
SCENE_FILES=()
for f in "$SCENES_DIR"/scene-*.html; do
  [ -e "$f" ] && SCENE_FILES+=("$f")
done

# Sort the files
IFS=$'\n' SCENE_FILES=($(printf '%s\n' "${SCENE_FILES[@]}" | sort)); unset IFS

if [ ${#SCENE_FILES[@]} -eq 0 ]; then
  echo "Error: no scene-*.html files found in $SCENES_DIR"
  exit 1
fi

echo "Found ${#SCENE_FILES[@]} scene(s)"

# Calculate frames per scene: fps × 8 seconds per scene
FRAMES_PER_SCENE=$((FPS * 8))
# Frame interval using pure bash integer arithmetic (microsecond precision)
# 1/FPS in seconds, computed as integer division for sleep
SLEEP_INTERVAL=$(awk "BEGIN { printf \"%.4f\", 1/$FPS }")

GLOBAL_FRAME=1

for scene_file in "${SCENE_FILES[@]}"; do
  scene_name=$(basename "$scene_file" .html)
  echo "→ Capturing $scene_name..."

  # Open the scene in browser
  abs_path="$(cd "$(dirname "$scene_file")" && pwd)/$(basename "$scene_file")"
  agent-browser open "file://$abs_path"
  BROWSER_OPEN=true
  sleep 1  # let CSS animations initialize

  for i in $(seq 1 $FRAMES_PER_SCENE); do
    PADDED=$(printf "%04d" $GLOBAL_FRAME)
    agent-browser screenshot "$FRAMES_DIR/frame-${PADDED}.png" 2>/dev/null
    sleep "$SLEEP_INTERVAL"
    GLOBAL_FRAME=$((GLOBAL_FRAME + 1))
  done

  agent-browser close
  BROWSER_OPEN=false
  echo "  ✓ $scene_name captured ($FRAMES_PER_SCENE frames)"
done

TOTAL=$((GLOBAL_FRAME - 1))
echo ""
echo "→ Captured $TOTAL total frames across ${#SCENE_FILES[@]} scene(s)"

# Stitch into GIF
if [[ "$FORMAT" == "gif" || "$FORMAT" == "both" ]]; then
  echo "→ Creating GIF..."
  FFMPEG_LOG=$(mktemp)
  if ffmpeg -y -framerate "$FPS" -start_number 1 -i "$FRAMES_DIR/frame-%04d.png" \
    -filter_complex "[0:v] scale=${WIDTH}:-1:flags=lanczos,split[a][b];[a]palettegen=max_colors=196:stats_mode=diff[p];[b][p]paletteuse=dither=floyd_steinberg" \
    -loop 0 \
    "$OUTPUT_DIR/animation.gif" 2>"$FFMPEG_LOG"; then
    GIF_SIZE=$(du -h "$OUTPUT_DIR/animation.gif" | cut -f1)
    echo "  ✓ GIF: $OUTPUT_DIR/animation.gif ($GIF_SIZE)"
  else
    echo "  ❌ GIF encoding failed. ffmpeg output:"
    cat "$FFMPEG_LOG"
    rm -f "$FFMPEG_LOG"
    exit 1
  fi
  rm -f "$FFMPEG_LOG"
fi

# Create MP4
if [[ "$FORMAT" == "mp4" || "$FORMAT" == "both" ]]; then
  echo "→ Creating MP4..."
  FFMPEG_LOG=$(mktemp)
  if ffmpeg -y -framerate "$FPS" -start_number 1 -i "$FRAMES_DIR/frame-%04d.png" \
    -vf "scale=${WIDTH}:-2:flags=lanczos" \
    -c:v libx264 -preset slow -crf 18 -pix_fmt yuv420p \
    -movflags +faststart \
    "$OUTPUT_DIR/animation.mp4" 2>"$FFMPEG_LOG"; then
    MP4_SIZE=$(du -h "$OUTPUT_DIR/animation.mp4" | cut -f1)
    echo "  ✓ MP4: $OUTPUT_DIR/animation.mp4 ($MP4_SIZE)"
  else
    echo "  ❌ MP4 encoding failed. ffmpeg output:"
    cat "$FFMPEG_LOG"
    rm -f "$FFMPEG_LOG"
    exit 1
  fi
  rm -f "$FFMPEG_LOG"
fi

# Clean up frames (guarded)
if [ -d "$FRAMES_DIR" ]; then
  case "$FRAMES_DIR" in
    *frames*|*.stix/*)
      rm -rf "$FRAMES_DIR"
      ;;
  esac
fi

echo ""
echo "✅ Animation complete!"
echo "   Scenes: ${#SCENE_FILES[@]}"
echo "   Frames: $TOTAL"
echo "   FPS: $FPS"
[[ "$FORMAT" == "gif" || "$FORMAT" == "both" ]] && echo "   GIF: $OUTPUT_DIR/animation.gif"
[[ "$FORMAT" == "mp4" || "$FORMAT" == "both" ]] && echo "   MP4: $OUTPUT_DIR/animation.mp4"
