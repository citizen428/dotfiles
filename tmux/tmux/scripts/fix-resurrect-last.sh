#!/bin/bash
# After a session closes, remove any 0-byte resurrect saves and re-point
# 'last' to the most recent non-empty one. Prevents continuum from restoring
# an empty session when tmux was saved with no windows open.
RESURRECT_DIR="$HOME/.local/share/tmux/resurrect"

find "$RESURRECT_DIR" -name "tmux_resurrect_*.txt" -size 0 -delete

latest=$(find "$RESURRECT_DIR" -name "tmux_resurrect_*.txt" -size +0c | sort | tail -1)
if [ -n "$latest" ]; then
    ln -sf "$(basename "$latest")" "$RESURRECT_DIR/last"
fi
