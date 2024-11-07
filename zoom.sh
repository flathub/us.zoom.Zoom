#!/usr/bin/env bash

# Chromium's singleton mechanism is active in Zoom but doesn't actually work -
# it uses a Qt mechanism instead. Chromium in Zoom looks for its socket in folders
# named with the PID, so normally it won't find it. But PID namespaces mean two
# Zoom instances can think they have the same PID, and then the second tries
# to use this mechanism, but it does nothing (and it won't try to use the Qt
# singleton mechanism). Deleting these sockets bypasses this.
# https://github.com/flathub/us.zoom.Zoom/issues/445
rm -f $HOME/.zoom/data/cefcache/*/SingletonSocket

TMPDIR="$XDG_RUNTIME_DIR/app/$FLATPAK_ID" exec /app/extra/zoom/ZoomLauncher "$@"
