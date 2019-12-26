#!/usr/bin/env sh

# Terminate already-running picom instances
#killall picom

# Wait until the processes have been shutdown
while pgrep -x picom >/dev/null; do sleep 1; done

if [ "$DISABLE_PICOM" = "1" ]; then
  exit
fi

#picom --config "$HOME/.config/picom.conf" &
picom -b
