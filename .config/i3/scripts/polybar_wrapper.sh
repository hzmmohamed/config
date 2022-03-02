#!/bin/sh

# Convenience wrapper for launching polybar on all monitors

killall polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload stats &
  done
else
  polybar --reload top &
fi
