#!/bin/bash

# Prerequisites: grim, slurp, tesseract, wl-clipboard

# Create a temporary directory
TMPDIR=$(mktemp -d)

# Take a screenshot of a selected area using grim and slurp, save it as screenshot.png in the temporary directory
grim -g "$(slurp)" $TMPDIR/screenshot.png

# Process the screenshot with Tesseract and save the result to a text file in the temporary directory
# tesseract $TMPDIR/screenshot.png $TMPDIR/output
tesseract $TMPDIR/screenshot.png $TMPDIR/output\
  -l chi_sim+eng \
  --oem 1 \
  --psm 6

# Copy the result to the clipboard (Wayland)
# Ignore all non-ASCII characters
cat $TMPDIR/output.txt |
    tr -cd '\11\12\15\40-\176' | grep . | perl -pe 'chomp if eof' |
    wl-copy

# Optionally, remove the temporary directory when done
rm -r $TMPDIR

