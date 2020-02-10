# i3

## Multiple Monitors

Maybe one day I'll have some sort of rofi-based layout selector. Until then,
here's some handy commands I use all the time:

- Put HDMI to the left of eDP:
  ```bash
  xrandr --output DP1 --auto --output eDP1 --auto --right-of DP1
  ```
- Mirror the current display:
  ```bash
  xrandr --output DP1 --auto --same-as eDP1
  ```
- And when HDMI is removed, turn it off to reclaim the workspaces:
  ```bash
  xrandr --output DP1 --off
  ```
