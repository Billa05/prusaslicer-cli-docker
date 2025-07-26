#!/bin/bash

MODEL="$1"         # e.g., test_model.stl
CONFIG="$2"        # e.g., 2.2.17.ini
BASENAME="$(basename "${MODEL%.*}")"  # e.g., test_model


GCODE="gcode/${BASENAME}.gcode"
STATS="stats/${BASENAME}_stats.txt"
FINALJSON="output/${BASENAME}.json"

docker run --rm \
  -v "$(pwd)/models:/models" \
  -v "$(pwd)/gcode:/gcode" \
  -v "$(pwd)/config:/config" \
  -v "$(pwd)/stats:/stats" \
  billa05/prusacli:latest \
  -c "/usr/bin/time -v /app/prusa-slicer \"/models/$MODEL\" --load \"/config/$CONFIG\" --export-gcode --output \"/gcode/${BASENAME}.gcode\" --support-material --brim-width 8 2>&1 | grep -E 'User time|System time|Percent of CPU|Maximum resident set size' > \"/stats/${BASENAME}_stats.txt\""

if [ $? -ne 0 ]; then
  echo "Slicing failed for $MODEL" >> error.log
fi
