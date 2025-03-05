#!/bin/env bash

# Check if already recording and stop if so
pgrep -x "wf-recorder" && pkill -INT -x wf-recorder && notify-send "Screen Recording" "Finished Recording" -i video-display -t 5000 && exit 0

# Countdown notifications
notify-send "Screen Recording" "Recording in: 3" -i video-display -t 4000
sleep 1
notify-send "Screen Recording" "Recording in: 2" -i video-display -t 3000
sleep 1
notify-send "Screen Recording" "Recording in: 1" -i video-display -t 2000
sleep 1
notify-send "Screen Recording" "Recording..." -i video-display -t 2000

# Set date/time for filename
dateTime=$(date +%m-%d-%Y-%H-%M-%S)

# Start recording with more explicit format settings
wf-recorder --bframes max_b_frames -c h264_vaapi -d /dev/dri/renderD128 -f $HOME/Videos/$dateTime.mp4 2>/dev/null