#!/bin/bash

CONFIG="config.ini"
MODEL_DIR="models"
PARALLEL_JOBS=2  # Limit to 2 parallel jobs for stability

# Find all .stl and .obj files in the models directory and run slice.sh in parallel
find "$MODEL_DIR" -type f \( -iname "*.stl" -o -iname "*.obj" \) | \
  xargs -I{} -P $PARALLEL_JOBS ./slice.sh "$(basename "{}")" "$CONFIG"