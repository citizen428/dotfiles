#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title org-capture
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🦄
# @raycast.packageName org-capture
# @raycast.description Org Mode Capture

# Documentation:
# @raycast.author Michael Kohl
# @raycast.authorURL https://citizen428.net

emacsclient --eval '(my/global-org-capture nil nil "t")'
