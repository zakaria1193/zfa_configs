set $workspace0 "0. Sandbox"
workspace $workspace0 output DP1
set $workspace1 "1. Text editor"
workspace $workspace1 output DP1
set $workspace2 "2. Dev terminal"
workspace $workspace2 output DP2
set $workspace3 "3. Test terminal"
workspace $workspace3 output DP2
set $workspace4 "4. Chrome"
workspace $workspace4 output DP2
set $workspace5 "5."
workspace $workspace5 output DP2
set $workspace6 "6."
workspace $workspace6 output DP2
set $workspace7 "7."
workspace $workspace7 output DP2
set $workspace8 "8. Wireshark"
workspace $workspace8 output DP2
set $workspace9 "9. files"
workspace $workspace9 output DP1

for_window [class="meld"] fullscreen enable
for_window [class="^(?i)google-chrome"] border pixel 3

assign [class="Wireshark"] → $workspace8
assign [class="Nautilus"] → $workspace9
assign [class="Filezilla"] → $workspace9

exec_always xautolock -time 5 -locker fuzzy_lock -notify 20 -notifier 'xset dpms force off && $LOCK_SCRIPT' &


bindsym $mod+F1  exec playerctl play
bindsym $mod+F2  exec playerctl pause
bindsym $mod+F3  exec playerctl next
bindsym $mod+F4  exec playerctl previous
