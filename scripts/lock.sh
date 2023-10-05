
#!/bin/bash

# i3lock blurred screen inspired by /u/patopop007 and the blog post
# http://plankenau.com/blog/post-10/gaussianlock

# Timings are on an Intel i7-2630QM @ 2.00GHz

# Dependencies:
# imagemagick
# i3lock
# scrot (optional but default)

SCRIPT_DIR=$(dirname $0)
IMAGE="$SCRIPT_DIR/lock.png"

# Scale to  1920x1080 using imagemagick
i3lock -i $IMAGE
