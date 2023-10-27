for_window [class="meld"] fullscreen enable

assign [class="Wireshark"] → workspace number 8
assign [class="Nautilus"] → workspace number 9

exec_always xautolock -time 20 -locker fuzzy_lock -notify 20 -notifier '$LOCK_SCRIPT' &


# Set monitor to laptop layout on ctrl + j
bindsym $mod+j exec autorandr laptop

# Set monitor to work layout on ctrl + k
bindsym $mod+w exec autorandr work

