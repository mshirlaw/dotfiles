#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL
# @raycast.mode silent
# @raycast.packageName Arc
#
# Optional parameters:
# @raycast.icon ./images/Arc.icns
#
# Documentation:
# @raycast.description This script copies URL of currently opened page in Arc into clipboard.
# @raycast.author Matt Shirlaw
# @raycast.authorURL https://github.com/mshirlaw

osascript -e 'tell application "Arc" to get URL of active tab of first window' | pbcopy
echo "Copied"