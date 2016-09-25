#!/usr/bin/env bash
# Load additional terminals in my personal development configuration

FOCUSED_WORKSPACE=$(i3-msg -t get_workspaces | python -m json.tool | grep -A2 '"focused": true' | tail -n1 | cut -d ':' -f2 | cut -d ',' -f1)
WORKSPACE="${1:-$FOCUSED_WORKSPACE}"
DEFAULT_TERMINAL_PATH="/home/owner"
TERMINAL_PATH="${2:-$DEFAULT_TERMINAL_PATH}"

i3-msg "workspace $WORKSPACE; append_layout /home/owner/.i3/layout/development-terminals.json; exec gnome-terminal --working-directory=$PATH; exec gnome-terminal --working-directory=$PATH; exec gnome-terminal --working-directory=$PATH; exec gnome-terminal --working-directory=$PATH;"
