#!/usr/bin/env bash

# Check if the current desktop is using Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then

	# Check if the line 'enableWaylandShare' is set to 'true' in $HOME/.var/app/us.zoom.Zoom/config/zoomus.conf
	if ! grep -q enableWaylandShare=true "$HOME/.var/app/$FLATPAK_ID/config/zoomus.conf"; then

		# Replace enableWaylandShare=false to enableWaylandShare=true
		sed -i 's/enableWaylandShare\=false/enableWaylandShare\=true/' ~/.var/app/"$FLATPAK_ID"/config/zoomus.conf

		# Recheck if the line 'enableWaylandShare' is set to true in $HOME/.var/app/us.zoom.Zoom/config/zoomus.conf
		if ! grep -q enableWaylandShare=true "$HOME/.var/app/$FLATPAK_ID/config/zoomus.conf"; then

			# If not, create a GTK dialog that says the string inside '--text'
        	       	zenity --error --text="Wayland screen sharing is not yet enabled. Please restart Zoom for it to automatically enable, or manually change the value of \"enableWaylandShare\" to \"true\" in \"$HOME/.var/app/$FLATPAK_ID/config/zoomus.conf\"."

		fi
	fi
	# Force XDG_CURRENT_DESKTOP to 'gnome' so that Zoom will not block portal screensharing
	XDG_CURRENT_DESKTOP="gnome"
fi

TMPDIR="$XDG_RUNTIME_DIR/app/$FLATPAK_ID" exec /app/extra/zoom/ZoomLauncher "$@"