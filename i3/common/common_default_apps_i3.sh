# Pulse Audio controls
# bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
# bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
# bindsym XF86AudioMute        exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound
bindsym XF86AudioRaiseVolume exec amixer -q -D pulse sset Master 5%+ && pkill -RTMIN+10 i3blocks
bindsym XF86AudioLowerVolume exec amixer -q -D pulse sset Master 5%- && pkill -RTMIN+10 i3blocks
bindsym XF86AudioMute exec amixer -q -D pulse sset Master toggle && pkill -RTMIN+10 i3blocks


# Sreen brightness controls
bindsym XF86MonBrightnessUp   exec xbacklight -inc 3 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 3 # decrease screen brightness

# Media player controls
bindsym XF86AudioPlay  exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext  exec playerctl next
bindsym XF86AudioPrev  exec playerctl previous


# caps lock and num lock to status bar
bindsym --release Caps_Lock exec pkill -SIGRTMIN+11 i3blocks
bindsym --release Num_Lock  exec pkill -SIGRTMIN+11 i3blocks

# logout i3 (logs you out of your X session)
bindsym $mod+Shift+l exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"
# Lock
bindsym $mod+l exec $LOCK_SCRIPT

bindsym $mod+j exec $MONITORS_SCRIPT

# exec at startup

# exec --no-startup-id blueman-applet
exec_always --no-startup-id nm-appplet
exec_always  --no-startup-id yes | $WALLPAPER_SCRIPT
# exec --no-startup-id /home/zfadli/my_scripts/ram_monitor.sh
exec_always  --no-startup-id  compton # compton is needed for transparency

# always remove dunst (keep default notifications)
# for always remove appmenu-qt5 (keep barre de menu)
# no desktop with nautilus: gsettings set org.gnome.desktop.background show-desktop-icons false

#enable numpad
exec  --no-startup-id setxkbmap -option keypad:pointerkeys
