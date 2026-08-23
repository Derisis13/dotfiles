hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY")
hl.exec_cmd("uwsm app udiskie")
hl.exec_cmd("uwsm app kdeconnect-indicator")
