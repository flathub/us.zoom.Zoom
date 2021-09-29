# Flatpak Package for Zoom

## Enabling Wayland Support
Currently, Zoom only has limited support for Wayland and this functionality is disabled by default.
In particular screen sharing will probably not work.

You can still enable Wayland support by giving the app permission to access the Wayland socket and removing permission to the X11 socket.
This can be don, for example, through Flatseal or through the command line.
