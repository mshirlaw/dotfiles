#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Desktop Images
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon 🗑️

# Documentation:
# @raycast.description Delete all .png files on the Desktop.

rm -r $HOME/Desktop/**.png
echo "Images Deleted"