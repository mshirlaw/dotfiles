#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reload Herdr Config
# @raycast.mode silent
# @raycast.packageName Herdr

# Optional parameters:
# @raycast.icon 🐑

# Documentation:
# @raycast.description Reload herdr's config.toml on the running server without restarting panes.
# @raycast.author Matt Shirlaw
# @raycast.authorURL https://github.com/mshirlaw

herdr server reload-config
echo "Herdr config reloaded"
