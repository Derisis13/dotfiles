local monitors = {
    {
        output="DP-2", -- todo: description as ID
        mode="preferred",
        position="0x0",
        scale=1
    }, -- desktop horizontal/left
    {
        output="HDMI-A-2", -- todo: description as ID
        mode="1920x1080",
        position="1920x-420",
        scale=1,
        transform=1
    }, -- desktop vertical/right
    {
        output="eDP-1",
        mode="preferred",
        position="0x0",
        scale=1.25,
    }, -- laptop main
    { 
        output = "",
        mode = "preferred",
        position = "auto",
        scale = 1
    } -- everything else
}

-- # Catppuccin theme colors
palette = require "macchiato"

-- Window rules
hl.window_rule({
    name = "launcher",
    center = true,
    stay_focused = true,
    match = {class = "^(Rofi)$"},
})

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 4,
        border_size = 2,
        ["col.active_border"] = palette.blue,
        ["col.inactive_border"] = palette.overlay0,
        layout = dwindle,
    },
    input = {
        kb_layout = "hu",
        kb_variant = "102_qwertz_dot_nodead",
        kb_options = "grp:menu_toggle",
        follow_mouse = true,
        touchpad = { natural_scroll = false, },
        sensitivity = 0, -- -1.0 .. 1.0, 0 means no modification.
    },
    decoration = {
        rounding = 5,
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
        },
        shadow = {
          enabled = false,
          range = 4,
          render_power = 3,
          color = 'rgba('..palette.baseAlpha.."ee)",
        },
    },
    xwayland = { force_zero_scaling = true, },
    misc = {
        vrr = 1, -- VRR on for every program needing it
        disable_splash_rendering = true,
        disable_hyprland_logo = true,
        --force_hypr_chan = true -- there is suddenly an anime girl on the background :D
    },
    debug = { disable_logs = false }
})

hl.curve("myBezier", {type="bezier", points={{0.05, 0.9}, {0.1, 1.05}}})
hl.curve("cubic", {type="bezier", points={{0.65, 0}, {0.35, 1}}})
hl.animation({leaf="windows", enabled=true, speed=7, bezier="myBezier"})
hl.animation({leaf="windowsOut", enabled=true, speed=7, bezier="default", style="popin 80%"})
hl.animation({leaf="border", enabled=true, speed=10, bezier="default"})
hl.animation({leaf="borderangle", enabled=true, speed=8, bezier="default"})
hl.animation({leaf="fade", enabled=true, speed=7, bezier="default"})
hl.animation({leaf="workspaces", enabled=true, speed=6, bezier="myBezier", style="slidevert"})
hl.animation({leaf="specialWorkspace", enabled=true, speed=3, bezier="cubic", style="slide"})

hl.gesture({fingers=4, direction="vertical", action="workspace"}) -- TODO: invert
-- hl.gesture({fingers=4, direction="horizontal", action="special"}) -- TODO: toggle
hl.gesture({fingers=3, direction="down", action=function () hl.dsp.exec_cmd("~/.config/rofi/launchers/type-1/launcher.sh") end})
hl.gesture({fingers=3, direction="up", action=function() hl.dsp.exec_cmd("rofi -theme ~/.config/rofi/launchers/type-1/style-5.rasi -show calc -modi calc -no-show-match -no-sort -no-persist-history -calc-command \"echo -n '{result}' | wl-copy\"") end})
hl.gesture({fingers=2, direction="pinch", action="cursor_zoom"})
-- TODO: two finger left-right for back-forward
hl.gesture({fingers=5, direction="pinchout", action=function() hl.dsp.exec_cmd("/usr/bin/hyprlock") end})
hl.gesture({fingers=5, direction="pinchin", action=function() hl.dsp.window.close() end})

require "exec"
require "keybinds"
