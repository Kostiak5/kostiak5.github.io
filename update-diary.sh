#!/bin/bash
# Run this after dropping a new photo into images/diary/.
# Finds the most recently modified image in that folder and points
# diary.html at it via images/diary/current.js.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIARY_DIR="$DIR/images/diary"

latest=$(find "$DIARY_DIR" -maxdepth 1 -type f \
  \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.heic' -o -iname '*.webp' \) \
  -exec stat -f '%m %N' {} \; | sort -rn | head -1 | cut -d' ' -f2-)

if [ -z "$latest" ]; then
  echo "No photos found in images/diary/ — drop one in there first."
  exit 1
fi

filename="$(basename "$latest")"
printf 'const DIARY_PHOTO = "images/diary/%s";\n' "$filename" > "$DIARY_DIR/current.js"
echo "diary updated -> $filename"
