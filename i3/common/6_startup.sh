# Enable numpad
exec  --no-startup-id setxkbmap -option keypad:pointerkeys

# Initial layout
exec --no-startup-id i3-msg "workspace 1; layout tabbed"

# Start applications
exec_always --no-startup-id yes | $WALLPAPER_SCRIPT
exec_always --no-startup-id 1password --silent
exec_always --no-startup-id xautolock -time 20 -locker fuzzy_lock -notify 20 -notifier '$LOCK_SCRIPT' &
exec_always --no-startup-id nm-applet blueman-applet
# exec_always --no-startup-id compton -b # compton is needed for transparency

