#!/usr/bin/env bash

ZOOMUS=$HOME/.var/app/us.zoom.Zoom/.config/zoomus.conf
if [[ -f "$ZOOMUS" ]]; then
    :
else
    ln -s $HOME/.var/app/us.zoom.Zoom/config/* ~/.var/app/us.zoom.Zoom/.config
fi

ZOOMUS_WAYLAND=$HOME/.var/app/us.zoom.Zoom/.config/zoomus.conf
if [[ -f "$ZOOMUS_WAYLAND" ]]; then
    sed -i 's/enableWaylandShare\=false/enableWaylandShare\=true/' ~/.var/app/us.zoom.Zoom/config/zoomus.conf
else
    echo "File does not exist yet. Re-run Zoom to successfully symlink."
fi

exec env TMPDIR=$XDG_CACHE_HOME /app/extra/zoom/ZoomLauncher "$@"
