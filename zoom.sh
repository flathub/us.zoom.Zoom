#!/usr/bin/env bash

CONF_FILE=$HOME/.zoom/config/zoomus.conf

# Check if the current desktop is using Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then

    # Check if the line 'enableWaylandShare' is set to 'true' in $HOME/.var/app/us.zoom.Zoom/config/zoomus.conf
    if ! grep -q enableWaylandShare=true "$CONF_FILE"; then

        # Replace enableWaylandShare=false to enableWaylandShare=true
        sed -i 's/enableWaylandShare\=false/enableWaylandShare\=true/' $CONF_FILE

        # Recheck if the line 'enableWaylandShare' is set to true in $HOME/.var/app/us.zoom.Zoom/config/zoomus.conf
        if ! grep -q enableWaylandShare=true "$CONF_FILE"; then
            # If not, create a GTK dialog that says the string inside '--text'
            zenity --error --text="Wayland screen sharing is not yet enabled. Please restart Zoom for it to automatically enable, or manually change the value of \"enableWaylandShare\" to \"true\" in \"$CONF_FILE\"."
        fi
    fi
fi

if [ -z "$DISPLAY" ] && [ -n "$WAYLAND_DISPLAY" ]; then
    echo "Running in experimental Wayland mode (screensharing might not work)"
    QPA=wayland
else
    QPA=xcb
fi

exec env TMPDIR="$XDG_RUNTIME_DIR/app/$FLATPAK_ID" TMPDIR=$XDG_CACHE_HOME QT_QPA_PLATFORM=$QPA /app/extra/zoom/ZoomLauncher "$@"
