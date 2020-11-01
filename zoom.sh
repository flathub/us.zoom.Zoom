#!/usr/bin/env bash

ZOOMUS=$HOME/.var/app/us.zoom.Zoom/.config/zoomus.conf

if [[ -f "$ZOOMUS" ]]; then
    :
else
    ln -s $HOME/.var/app/us.zoom.Zoom/config/* ~/.var/app/us.zoom.Zoom/.config
    if [[ -f "$ZOOMUS" ]]; then
    	sed -i 's/enableWaylandShare\=false/enableWaylandShare\=true/' ~/.var/app/us.zoom.Zoom/config/zoomus.conf
    else
    	echo "zoomus.conf does not exist yet. Please re-run Zoom for it to automatically enable Wayland."
    fi
fi

exec env TMPDIR=$XDG_CACHE_HOME /app/extra/zoom/ZoomLauncher "$@"
