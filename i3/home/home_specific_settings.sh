set $workspace0 "0"
set $workspace1 "1"
set $workspace2 "2"
set $workspace3 "3"
set $workspace4 "4"
set $workspace5 "5"
set $workspace6 "6"
set $workspace7 "7"
set $workspace8 "8"
set $workspace9 "9"

exec --no-startup-id i3-msg "workspace $workspace1; layout tabbed"

bindsym $mod+j exec $MONITORS_SCRIPT
exec_always $MONITORS_SCRIPT --external

# exec_always xautolock -time 10 -locker "systemctl suspend" &