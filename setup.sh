#!/bin/bash

export DISPLAY=:0
cols=2
rows=2
xsize=1367
ysize=768

cleanup() {
    echo "Caught SIGINT! Cleaning up..."
    # Add any cleanup commands here
    killall -9 x11vnc
    exit 0
}

# Set up the trap to catch SIGINT
trap cleanup SIGINT

setup_vnc() {
  local xoffset=$1
  local yoffset=$2
  for ((x=0; x<${cols};x++)); do
    for ((y=0; y<${rows};y++)); do
      echo "Starting C${x}R${y}"
      x11vnc -q -clip ${xsize}x${ysize}+$(( (x * xsize) + xoffset))+$(( (y * ysize) + yoffset)) -forever -rfbport $(( (y * cols + x) + 5901 )) &
      waitpid=$!
    done
  done
}

# Check for HDMI connection
echo "Setting display config"
if xrandr | grep "HDMI-1 connected"; then
    echo "HDMI is plugged in."
    xrandr --output HDMI-1 --mode 1920x1080 --primary --output DVI-I-1 --mode 2736x1536 --right-of HDMI-1
    echo "Done setting display config"
    echo
    echo
    echo
    echo "Starting HDMI vnc"
    x11vnc -q -clip 1920x1080+0+0 -forever -rfbport 5900 &
    setup_vnc 1920 0
else
    echo "HDMI is not plugged in."
    xrandr --output DVI-I-1 --mode 2736x1536 --primary
    echo "Done setting display config"
    echo
    echo
    echo
    setup_vnc 0 0
fi
echo "Done setting up"
echo
echo
echo
echo
echo "Waiting for $waitpid to die..."
wait $waitpid
