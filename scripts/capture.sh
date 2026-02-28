#!/bin/bash
# Capture animated HTML scenes and stitch into GIF + MP4
# Usage: ./capture.sh [options]
#
# Options:
#   --scenes-dir DIR    Directory containing scene-*.html files (default: .animate/scenes)
#   --frames-dir DIR    Directory to store captured frames (default: .animate/frames)
#   --output-dir DIR    Directory for output files (default: .animate/output)
#   --fps N             Frames per second for output (default: 8)
#   --format FORMAT     Output format: gif, mp4, both (default: both)
#   --width N           Output width in pixels (default: 800)

set -e

# Defaults
SCENES_DIR=".animate/scenes"
FRAMES_DIR=".animate/frames"
OUTPUT_DIR=".animate/output"
FPS=8
FORMAT="both"
WIDTH=800

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --scenes-dir)  SCENES_DIR="$2"; shift 2 ;;
    --frames-dir)  FRAMES_DIR="$2"; shift 2 ;;
    --output-dir)  OUTPUT_DIR="$2"; shift 2 ;;
    --fps)         FPS="$2"; shift 2 ;;
    --format)      FORMAT="$2"; shift 2 ;;
    --width)       WIDTH="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Validate
if [ ! -d "$SCENES_DIR" ]; then
  echo "Error: scenes directory not found: $SCENES_DIR"
  exit 1
fi

command -v agent-browser >/dev/null 2>&1 || { echo "Error: agent-browser not found. Install it first."; exit 1; }
command -v ffmpeg >/dev/null 2>&1 || { echo "Error: ffmpeg not found. Install it first."; exit 1; }

# Setup
rm -rf "$FRAMES_DIR"
mkdir -p "$FRAMES_DIR" "$OUTPUT_DIR"

# Discover scenes
SCENE_FILES=($(ls "$SCENES_DIR"/scene-*.html 2>/dev/null | sort))
if [ ${#SCENE_FILES[@]} -eq 0 ]; then
  echo "Error: no scene-*.html files found in $SCENES_DIR"
  exit 1
fi

echo "Found ${#SCENE_FILES[@]} scene(s)"

# Calculate frames per scene: fps × 8 seconds per scene
FRAMES_PER_SCENE=$((FPS * 8))
SLEEP_INTERVAL=$(echo "scale=4; 1 / $FPS" | bc)

GLOBAL_FRAME=1

for scene_file in "${SCENE_FILES[@]}"; do
  scene_name=$(basename "$scene_file" .html)
  echo "→ Capturing $scene_name..."

  # Open the scene in browser
  abs_path="$(cd "$(dirname "$scene_file")" && pwd)/$(basename "$scene_file")"
  agent-browser open "file://$abs_path"
  sleep 1  # let CSS animations initialize

  for i in $(seq 1 $FRAMES_PER_SCENE); do
    PADDED=$(printf "%04d" $GLOBAL_FRAME)
    agent-browser screenshot "$FRAMES_DIR/frame-${PADDED}.png" 2>/dev/null
    sleep "$SLEEP_INTERVAL"
    GLOBAL_FRAME=$((GLOBAL_FRAME + 1))
  done

  agent-browser close
  echo "  ✓ $scene_name captured ($FRAMES_PER_SCENE frames)"
done

TOTAL=$((GLOBAL_FRAME - 1))
echo ""
echo "→ Captured $TOTAL total frames across ${#SCENE_FILES[@]} scene(s)"

# Stitch into GIF
if [[ "$FORMAT" == "gif" || "$FORMAT" == "both" ]]; then
  echo "→ Creating GIF..."
  ffmpeg -y -framerate "$FPS" -start_number 1 -i "$FRAMES_DIR/frame-%04d.png" \
    -filter_complex "[0:v] scale=${WIDTH}:-1:flags=lanczos,split[a][b];[a]palettegen=max_colors=196:stats_mode=diff[p];[b][p]paletteuse=dither=floyd_steinberg" \
    -loop 0 \
    "$OUTPUT_DIR/animation.gif" 2>/dev/null

  GIF_SIZE=$(du -h "$OUTPUT_DIR/animation.gif" | cut -f1)
  echo "  ✓ GIF: $OUTPUT_DIR/animation.gif ($GIF_SIZE)"
fi

# Create MP4
if [[ "$FORMAT" == "mp4" || "$FORMAT" == "both" ]]; then
  echo "→ Creating MP4..."
  ffmpeg -y -framerate "$FPS" -start_number 1 -i "$FRAMES_DIR/frame-%04d.png" \
    -vf "scale=${WIDTH}:-2:flags=lanczos" \
    -c:v libx264 -preset slow -crf 18 -pix_fmt yuv420p \
    -movflags +faststart \
    "$OUTPUT_DIR/animation.mp4" 2>/dev/null

  MP4_SIZE=$(du -h "$OUTPUT_DIR/animation.mp4" | cut -f1)
  echo "  ✓ MP4: $OUTPUT_DIR/animation.mp4 ($MP4_SIZE)"
fi

# Clean up frames
rm -rf "$FRAMES_DIR"

echo ""
echo "✅ Animation complete!"
echo "   Scenes: ${#SCENE_FILES[@]}"
echo "   Frames: $TOTAL"
echo "   FPS: $FPS"
[[ "$FORMAT" == "gif" || "$FORMAT" == "both" ]] && echo "   GIF: $OUTPUT_DIR/animation.gif"
[[ "$FORMAT" == "mp4" || "$FORMAT" == "both" ]] && echo "   MP4: $OUTPUT_DIR/animation.mp4"
