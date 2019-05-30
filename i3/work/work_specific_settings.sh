for_window [class="meld"] fullscreen enable
#for_window [class="^(?i)google-chrome"] border pixel 3

assign [class="Wireshark"] → $workspace8
assign [class="Nautilus"] → $workspace9
assign [class="Filezilla"] → $workspace9

for_window [title="Microsoft Teams Notification"] floating enable

exec_always xautolock -time 20 -locker fuzzy_lock -notify 20 -notifier 'xset dpms force off && $LOCK_SCRIPT' &


bindsym $mod+F1  exec playerctl play
bindsym $mod+F2  exec playerctl pause
bindsym $mod+F3  exec playerctl next
bindsym $mod+F4  exec playerctl previous
