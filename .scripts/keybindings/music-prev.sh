#!/usr/bin/env bash

# Spotify
# ref: https://gist.github.com/jbonney/5743509
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
