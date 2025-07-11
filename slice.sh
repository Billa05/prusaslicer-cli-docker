#!/bin/bash

# Usage: ./slice.sh <model.stl> <config.ini> <output.gcode> [stats.txt]
# Example: ./slice.sh test_model.stl 2.2.17.ini test.gcode stats.txt

MODEL="$1"
CONFIG="$2"
OUTPUT="$3"
STATS="${4:-stats.txt}"  # Optional 4th argument, defaults to stats.txt

docker run --rm \
  -v "$(pwd)/models:/models" \
  billa05/prusacli:latest \
  -c "/usr/bin/time -v /app/prusa-slicer \"/models/$MODEL\" --load \"/models/$CONFIG\" --export-gcode --output \"/models/$OUTPUT\" --support-material --brim-width 8 2> \"/models/$STATS\""
