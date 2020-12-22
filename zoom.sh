##!/usr/bin/env bash

# Zoom hardcodes ~/.config instead of using XDG_CONFIG_HOME.
ZOOMUS=$HOME/.var/app/us.zoom.Zoom/.config/zoomus.conf

# Check if ~/.var/app/us.zoom.Zoom/.config/zoomus.conf exists.
if [[ -f "$ZOOMUS" ]]; then
    :
else
    ln -s $HOME/.var/app/us.zoom.Zoom/config/ ~/.var/app/us.zoom.Zoom/.config
fi

# Enable Wayland
sed -i 's/enableWaylandShare\=false/enableWaylandShare\=true/' ~/.var/app/us.zoom.Zoom/config/zoomus.conf

exec env TMPDIR=$XDG_CACHE_HOME /app/extra/zoom/ZoomLauncher "$@"
