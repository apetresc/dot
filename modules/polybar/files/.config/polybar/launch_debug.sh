#!/usr/bin/env sh

# Terminate already-running bar instances
killall -q polybar

# Wait until the processes have been shutdown
while pgrep -x polybar >/dev/null; do sleep 1; done

# Get network interface name
export NETWORK_INTERFACE=$(ip link show | grep "state UP" | head -n 1 | cut -d" " -f2 | cut -d":" -f1)

# Get CPU thermal zone
export THERMAL_ZONE=$(ls /sys/class/thermal | grep thermal_zone | grep -oE "[0-9]" | sort -nr | head -n 1)

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    (MONITOR=$m NETWORK_INTERFACE=$NETWORK_INTERFACE THERMAL_ZONE=$THERMAL_ZONE polybar -l info --reload example ; echo $? >> ~/.config/polybar/debug.log) &
  done
else
  (NETWORK_INTERFACE=$NETWORK_INTERFACE THERMAL_ZONE=$THERMAL_ZONE polybar -l info --reload example ; echo $? >> ~/.config/polybar/debug.log) &
fi
