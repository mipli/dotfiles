import os
import re
import socket
import subprocess
import os.path
import cairocffi
from xdg.IconTheme import getIconPath
from libqtile.config import Key, Screen, Group, Match, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook, extension
from libqtile.widget import Spacer, base

from typing import List  # noqa: F401

from Xlib import display


def get_screen_count():
    d = display.Display()
    s = d.screen()
    r = s.root
    res = r.xrandr_get_screen_resources()._data

    num_screens = 0
    for output in res['outputs']:
        print("Output %d:" % (output))
        mon = d.xrandr_get_output_info(output, res['config_timestamp'])._data
        print("%s: %d" % (mon['name'], mon['num_preferred']))
        if mon['num_preferred']:
            num_screens += 1

    print("Screens found: %d" % (num_screens))
    return num_screens

num_screens = get_screen_count()

mod = "mod4"

keys = [
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    Key([mod], "Return", lazy.spawn("alacritty")),

    Key([mod, "control"], "h", lazy.prev_screen()),
    Key([mod, "control"], "l", lazy.next_screen()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "q", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod], "r", lazy.spawn("rofi -show run -theme-str '@theme \"nord\"'")),
    # Key([mod], "k", lazy.spawn("kill -9 $(ps a | rofi -dmenu | awk \"{ print $1 }\")")),

    #Sound shortcuts
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +1%")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -1%")),

    #Change keyboard layout
    Key([mod], "space", lazy.spawn("/home/michael/.dotfiles/qtile/keyboard-layout.sh")),
]


groups = [
    Group("1", matches=[Match(wm_class=["firefox"])], label=""),
    Group("2", label=""),
    Group("3", label=""),
    Group("4", label=""),
    Group("5", label=""),
    ]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.MonadTall(border_focus = "5e81ac", border_normal = "b48ead", border_width = 3, margin = 5,),
    layout.MonadWide(border_focus = "5e81ac", border_normal = "b48ead", border_width = 3, margin = 5,),
]

widget_defaults = dict(
    font='Cascadia Code',
    fontsize=14,
    padding=1,
)
extension_defaults = widget_defaults.copy()

screens = []
for screen in range(0, num_screens):
    screens.append(
        Screen(
            top=bar.Bar(
                [
                    widget.GroupBox(background = "2e3440", active = "5e81ac", inactive = "b48ead",
                                    this_current_screen_border = "bf616a", highlight_method = "line", highlight_color=["2e3440", "2e3440"], center_aligned=True,),
                    # widget.Prompt(background = "2e3440"),
                    widget.Sep(background = "2e3440",),
                    widget.TaskList(background = "2e3440", foreground = "2e3440", border = "5e81ac",
                                    unfocused_border = "b48ead", highlight_method = "block", max_title_width=100, title_width_method="uniform", rounded=False,),
                    widget.Systray(background = "2e3440"),
                    widget.TextBox(text='☇', background="2e3440", foreground="8fbcbb", padding=2),
                    widget.Battery(energy_now_file = "charge_now",
                        energy_full_file = "charge_full",
                        power_now_file = "current_now",
                        update_delay = 5,
                        background = "2e3440",
                        foreground = "8fbcbb",
                        format = "{char} {percent:2.0%}",
                        full_char = u'',
                        unknown_char = u'',
                        charge_char = u'↑',
                        discharge_char = u'↓',),
                    widget.TextBox(text=' ', background="2e3440", foreground="8fbcbb", padding=2),
                    widget.KeyboardLayout(background="2e3440", foreground="8fbcbb", padding=4),
                    widget.TextBox(text=' ', background="2e3440", foreground="8fbcbb", padding=2),
                    widget.Volume(background="2e3440", foreground="8fbcbb", padding=4, update_interval=1),
                    widget.CPUGraph(background="2e3440", graph_color="8fbcbb", padding=4),
                    widget.MemoryGraph(background="2e3440", graph_color="8fbcbb", padding=4),
                    widget.TextBox(text=' ', background="2e3440", foreground="8fbcbb", padding=2),
                    widget.Clock(format='%a %H:%M', background = "2e3440", foreground = "8fbcbb", pading=4),
                    widget.TextBox(text=' ', background="2e3440", foreground="8fbcbb", padding=2),
                    widget.Wlan(background="2e3440", foreground="8fbcbb", padding=4, interface="wlan0", format="{essid}"),
                ],
                24,
            ),
        ),
    )

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.dotfiles/qtile/autostart.sh')
    subprocess.call([home])
