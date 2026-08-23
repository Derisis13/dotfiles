-- Keybinds configuration file

-- local mainMod = "SUPER + "

local execs = {
    -- Applications
    F = "uwsm app nautilus",
    T = "uwsm app kitty",
    W = "uwsm app io.gitlab.librewolf-community.desktop",
    SPACE = "~/.config/rofi/launchers/type-1/launcher.sh",
    -- Launcher
    ["SHIFT + V"] = "cliphist list | rofi -theme ~/.config/rofi/launchers/type-1/style-5.rasi -dmenu | cliphist decode | wl-copy",
    ["SHIFT + CTRL + V"] = "cliphist list | rofi -theme ~/.config/rofi/launchers/type-1/style-5.rasi -dmenu | cliphist delete",
    minus = "rofi -theme ~/.config/rofi/launchers/type-1/style-5.rasi -show calc -modi calc -no-show-match -no-sort -no-persist-history -calc-command \"echo -n '{result}' | wl-copy\"",
    -- System components
    B = "pkill waybar || uwsm app waybar",
    N = "swaync-client -t -sw",
    ["CTRL + BACKSPACE"] = "/usr/bin/hyprlock",
    -- Screenshot
    ["SHIFT + S"] = "slurp | grim -g - - | wl-copy && wl-paste > $(xdg-user-dir PICTURES)/screenshots/$(date  + '%Y-%m-%d-%H%M%S_grim.png')",
    ["SHIFT + CTRL + S"] = "grim - | wl-copy && wl-paste > $(xdg-user-dir PICTURES)/screenshots/$(date  + '%Y-%m-%d-%H%M%S_grim.png')",
    ["CTRL + C"] = "hyprpicker | wl-copy",
}
for key, cmd in pairs(execs) do
    hl.bind("SUPER + "..key, hl.dsp.exec_cmd(cmd))
end

-- Move focus with "SUPER + "  +  arrow keys
for key,dir in pairs({H="left", J="down", K="up", L="left"}) do
    hl.bind("SUPER + "..key, hl.dsp.focus({direction=dir}))
    hl.bind("SUPER + ".."SHIFT + "..key, hl.dsp.window.move({direction=dir})) -- will this move workspace up?
    -- hl.bind("SUPER + ".."SHIFT + "..direction, hl.dsp.window.move(direction=direction))
end

-- for key,dir in pairs({H={x=-10, y=0}, J={x=0, y=-10}, K={x=0, y=10}, L={x=10, y=0}}) do
--     hl.bind("SUPER + ".."CTRL + SHIFT + "..key, hl.dsp.window.resize({direction=dir}), {locked=false, repeating=false, ignore_mods=false})
-- end

for ws = 1,9 do
    hl.bind("SUPER + ".."CTRL + "..ws, hl.dsp.focus({workspace=ws}), {locked=false, repeating=false, ignore_mods=false})
    hl.bind("SUPER + ".."SHIFT + "..ws, hl.dsp.window.move({workspace=ws}), {locked=false, repeating=false, ignore_mods=false})
end

for key,direction in pairs({mouse_down="r+1", mouse_up="r-1", K="r-1", J='r+1', up="r-1", down="r+1", END="empty", HOME="1"}) do
    hl.bind("SUPER + ".."CTRL + "..key, hl.dsp.focus({workspace=direction}), {locked=false, repeating=false, ignore_mods=false})
    hl.bind("SUPER + ".."SHIFT + "..key, hl.dsp.window.move({workspace=direction}), {locked=false, repeating=false, ignore_mods=false})
end

hl.bind("SUPER + ".."BACKSPACE", hl.dsp.window.close(), {locked=false, repeating=false, ignore_mods=false})
hl.bind("SUPER + ".."CTRL + ALT + BACKSPACE", hl.dsp.exit(), {locked=false, repeating=false, ignore_mods=false}) -- uwsm stop? loginctl?
hl.bind("SUPER + ".."Y", hl.dsp.window.float("toggle"), {locked=false, repeating=false, ignore_mods=false})
hl.bind("SUPER + ".."P", hl.dsp.window.pin("toggle"), {locked=false, repeating=false, ignore_mods=false})
hl.bind("SUPER + ".."E", hl.dsp.window.fullscreen("fullscreen", "toggle"), {locked=false, repeating=false, ignore_mods=false})

hl.bind("SUPER + ".."TAB", hl.dsp.workspace.toggle_special(), {locked=false, repeating=false, ignore_mods=false})
hl.bind("SUPER + ".."mouse:274", hl.dsp.workspace.toggle_special(), {locked=false, repeating=false, ignore_mods=false})
-- hl.bind("SUPER + ".."SHIFT + TAB", hl.dsp.window.move({workspace=special}), {locked=false, repeating=false, ignore_mods=false})
-- hl.bind("SUPER + ".."SHIFT + mouse:274", hl.dsp.window.move({workspace=special}), {locked=false, repeating=false, ignore_mods=false})

hl.bind("SUPER + ".."mouse:272", hl.dsp.window.drag(), {mouse=true, drag=true, locked=false, repeating=false, ignore_mods=false})
hl.bind("SUPER + ".."SHIFT + mouse:272", hl.dsp.window.resize(), {mouse=true, drag=true, locked=false, repeating=false, ignore_mods=false})
hl.bind("SUPER + ".."mouse:273", hl.dsp.window.resize(), {mouse=true, drag=true, locked=false, repeating=false, ignore_mods=false})

-- Media keybinds: repeating and allow when locked
local media_execs = {
    XF86AudioRaiseVolume="wpclt set-volume @DEFAULT_AUDIO_SINK@ 5% + ",
    XF86AudioLowerVolume="wpclt set-volume @DEFAULT_AUDIO_SINK@ 5%-",
    XF86AudioMute="wpclt set-mute @DEFAULT_AUDIO_SINK@ toggle",
    XF86MonBrightnessUp="brightnessctl set 1% + ",
    XF86MonBrightnessDown="brightnessctl set 1%-",
    XF86AudioPlay="playerctl play-pause",
    XF86AudioNext="playerctl next",
    XF86AudioPrev="playerctl previous",
}
for key,cmd in pairs(media_execs) do
    hl.bind("SUPER + "..key, hl.dsp.exec_cmd(cmd), {locked=true, repeating=true, ignore_mods=true})
end
