#!/usr/bin/env bash

xrandr --output HDMI-A-1 --rotate left --left-of HDMI-A-0
xrandr --output HDMI-A-1 --mode 1920x1080 --rate 100
xrandr --output HDMI-A-0 --mode 2560x1440 --rate 100

