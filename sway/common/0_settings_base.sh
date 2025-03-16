# sway config file
#

set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:System San Fransisco Display 9

# Before sway v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod
floating_minimum_size 75 x 50

# Stay within output boundaries
force_focus_wrapping no

# Misc settings
focus_follows_mouse yes
popup_during_fullscreen smart
workspace_auto_back_and_forth yes

### GAPS configuration ###
## sway gaps specific
gaps inner 2
gaps outer 2

# Only enable gaps on a workspace when there is at least one container
smart_gaps on
#########################


