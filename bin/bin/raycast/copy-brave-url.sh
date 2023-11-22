#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Brave URL
# @raycast.mode silent
# @raycast.packageName Brave
#
# Optional parameters:
# @raycast.icon ./images/Brave.icns
#
# Documentation:
# @raycast.description This script copies URL of currently opened page in Brave into clipboard.
# @raycast.author Matt Shirlaw
# @raycast.authorURL https://github.com/mshirlaw

osascript -e 'tell application "Brave" to get URL of active tab of first window' | pbcopy
echo "Copied" 