#!/usr/bin/env bash

# Zoom hardcodes ~/.config instead of using XDG_CONFIG_HOME.
ZOOMUS=$HOME/.var/app/us.zoom.Zoom/.config/zoomus.conf

# Check if ~/.var/app/us.zoom.Zoom/.config/zoomus.conf exists.
if [[ -f "$ZOOMUS" ]]; then
    :
else
    # If ~/.var/app/us.zoom.Zoom/.config/zoomus.conf doesn't exist, symlink ~/.var/app/us.zoom.Zoom/config/ to ~/.var/app/us.zoom.Zoom/.config.
    ln -s $HOME/.var/app/us.zoom.Zoom/config/* ~/.var/app/us.zoom.Zoom/.config
    # Check (again) if ~/.var/app/us.zoom.Zoom/.config/zoomus.conf exists.
    if [[ -f "$ZOOMUS" ]]; then
        # If it does, replace enableWaylandShare=false to enableWaylandShare=true in ~/.var/app/us.zoom.Zoom/config/zoomus.conf.
    	sed -i 's/enableWaylandShare\=false/enableWaylandShare\=true/' ~/.var/app/us.zoom.Zoom/config/zoomus.conf
    else
        # If it doesn't, echo:
    	echo "zoomus.conf does not exist yet. Please re-run Zoom for it to automatically enable Wayland."
    fi
fi

exec env TMPDIR=$XDG_CACHE_HOME /app/extra/zoom/ZoomLauncher "$@"
