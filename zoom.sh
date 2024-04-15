#!/usr/bin/env bash

CONF_FILE=~/.var/app/$FLATPAK_ID/config/zoomus.conf

# Check if the current desktop is using Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    XDG_CURRENT_DESKTOP="gnome"
    QPA=waylanda

    # Check if the line 'enableWaylandShare' is set to 'true' in $HOME/.var/app/us.zoom.Zoom/config/zoomus.conf
    if ! grep -q enableWaylandShare=true $CONF_FILE; then
        # Replace enableWaylandShare=false to enableWaylandShare=true
        sed -i 's/enableWaylandShare\=false/enableWaylandShare\=true/' $CONF_FILE

        # Recheck if the line 'enableWaylandShare' is set to true in $HOME/.var/app/us.zoom.Zoom/config/zoomus.conf
        if ! grep -q enableWaylandShare=true $CONF_FILE; then
            # If not, create a GTK dialog that says the string inside '--text'
            zenity --error --text="Wayland screen sharing is not yet enabled. Please restart Zoom for it to automatically enable, or manually change the value of \"enableWaylandShare\" to \"true\" in \"${CONF_FILE}\"."
        fi
    fi
else
    QPA=xcb
fi

# Chromium's singleton mechanism is active in Zoom but doesn't actually work -
# it uses a Qt mechanism instead. Chromium in Zoom looks for its socket in folders
# named with the PID, so normally it won't find it. But PID namespaces mean two
# Zoom instances can think they have the same PID, and then the second tries
# to use this mechanism, but it does nothing (and it won't try to use the Qt
# singleton mechanism). Deleting these sockets bypasses this.
# https://github.com/flathub/us.zoom.Zoom/issues/445
rm -f $HOME/.zoom/data/cefcache/*/SingletonSocket

TMPDIR="$XDG_RUNTIME_DIR/app/$FLATPAK_ID" QT_QPA_PLATFORM=$QPA exec /app/extra/zoom/ZoomLauncher "$@"
