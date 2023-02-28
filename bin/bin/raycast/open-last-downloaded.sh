#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Last Downloaded
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon 🗃️ 

# Documentation:
# @raycast.description Opens the last file that was downloaded

open $HOME/"Downloads/$(ls -tr $HOME/Downloads/ | tail -n 1)"