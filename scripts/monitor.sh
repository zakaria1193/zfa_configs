#!/bin/bash

INTERNAL_OUTPUT="eDP-1"
EXTERNAL_OUTPUT="HDMI-1"

option=$1

if [[ $option == "--external" ]]
then
    if [[ -n $(xrandr | grep "$EXTERNAL_OUTPUT connected") ]]
    then
        xrandr --output $EXTERNAL_OUTPUT --auto --output $INTERNAL_OUTPUT --off
    else
        echo $EXTERNAL_OUTPUT not connected
    fi
    exit
fi

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="INTERNAL"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
# if [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
# elif [ $monitor_mode = "INTERNAL" ]; then
        # monitor_mode="CLONES"
        # xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT
# else
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="all"
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --right-of $INTERNAL_OUTPUT
fi
echo "${monitor_mode}" > /tmp/monitor_mode.dat
echo "${monitor_mode}"
