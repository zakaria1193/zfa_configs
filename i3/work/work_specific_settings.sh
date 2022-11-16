for_window [class="meld"] fullscreen enable

assign [class="Wireshark"] → workspace number 8
assign [class="Nautilus"] → workspace number 9

exec_always xautolock -time 20 -locker fuzzy_lock -notify 20 -notifier 'xset dpms force off && $LOCK_SCRIPT' &

bindsym $mod+F1  exec playerctl play
bindsym $mod+F2  exec playerctl pause
bindsym $mod+F3  exec playerctl next
bindsym $mod+F4  exec playerctl previous
