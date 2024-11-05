# HA5PLS's fedora install documentation
- partitioning: differs every time
- dnf: `# dnf history replay ./transaction.json` Automatic generation of this file is TODO
- packages: todo barusu + base system + repo carry
- alacritty: .config/alacritty/alacritty.toml + fira_code_mono_nerd_font installed (todo: script)
- zsh: $ZDOTDIR set in /etc/zshenv + omz install (todo:script) + .config/zsh + install fzf-tab plugin (git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab) + for some reason $XDG_STATE_HOME/zsh needs to be created manually
- hypr*: .config/hypr, install hyprlock, hyprsunset, hypridle, 
- hyprpaper: .config/hypr + download from [here](https://www.flickr.com/photos/nasahqphoto/5914101671/in/photostream/) to .local/wallpapers (also used for grub & sddm & hyprlock)
- waybar: .config/waybar + install awesomefonts (todo: script)
- rofi: .config/rofi + extract neccessary parts from https://github.com/adi1090x/rofi install script
- rofi-qalc: needs rofi-wayland-1.7.5+wayland2-3.fc40.x86_64 (find it in downloads or fedora build system) until ABI is fixed, rofi-devel, then compile this by hand: https://github.com/svenstaro/rofi-calc
- sddm: dependency: `qt6-qtquickcontrols2 qt6-qtsvg`, copy sddm/sddm.conf -> /etc/sddm.conf & sddm/themes/catppuccin-macchiato -> /usr/share/sddm/themes/catppuccin-macchiato/ then `# systemctl set-default graphical.target`
- nvim: .config/nvim + alacritty done + deps: clang (gcc-c++), unzip, npm, ripgrep, then proceed with nvchad init
- swaync: .config/swaync
- gtk: .config/gtk-*
- MPV: $XDG_CONFIG_HOME/mpv/
- QT5: .config/qt6ct/, xsettingsd/
- dconf-based: barusu (TODO)
- kdeconnect: `# firewall-cmd --permanent --add-service=kdeconnect` + needs kdeconnectd restart to work
- plymouth: copy plymouth/themes/fedora-mac-style -> /usr/share/plymouth/themes/fedora-mac-style + plymouth-plugin-two-step and abattis-cantarell-fonts installed + (`plymouth-set-default-theme -l` -> if this displays the theme, installation can begin: `sudo plymouth-set-default-theme -R fedora-mac-style && sudo dracut --regenerate-all -f`)
- grub: copy grub/grub -> /etc/default/grub & grub/themes -> /boot/themes then `grub2-mkconfig -o /boot/grub2/grub.cfg`
- udev: /etc/udev/rules.d/ (for setting driver permissions)
- selinux: /etc/selinux/config to stay permissive (why even bother with selinux?)
- firefox(librewolf btw): do your own profile, install [catpuccin theme](https://github.com/catppuccin/firefox) and [darkreader](https://darkreader.org/)

<details><summary><i>Showcase</i></summary>
    [background](https://raw.githubusercontent.com/Derisis13/dotfiles/refs/heads/master/.assets/bare.png)<br>
    [nvim](https://raw.githubusercontent.com/Derisis13/dotfiles/refs/heads/master/.assets/nvim.png)<br>
    [fetch](https://raw.githubusercontent.com/Derisis13/dotfiles/refs/heads/master/.assets/fetch.png)<br>
    [launcher](https://raw.githubusercontent.com/Derisis13/dotfiles/refs/heads/master/.assets/ff_launcher.png)<br>
    [control center](https://raw.githubusercontent.com/Derisis13/dotfiles/refs/heads/master/.assets/control_center_menu.png.png)<br>
    [btop](https://raw.githubusercontent.com/Derisis13/dotfiles/refs/heads/master/.assets/btop.png)
</details>


# Thanks to:
- [Kosmx](https://github.com/KosmX/) for providing help and [dotfiles to steal from](https://github.com/KosmX/hypr-dots)
- [Catppuccin](https://github.com/catppuccin/) for providing a nice theme ported to many platforms.
- [NvChad](https://github.com/NvChad/) for providing a powerful & extensible neovim config that helps me at my job.
- Tobilinuxer on gnome-look.org for making [this](https://www.gnome-look.org/p/2106821) plymouth theme
- adi1090x for his [rofi scripts](https://github.com/adi1090x/rofi)
- [The ani-cli discord](https://discord.com/invite/aqu7GpqVmR) for providing general support and help writing these files.
- The creators of the tools these config files belong to for providing me all of this free software.
- Anyone else who I forgot, but stole, copied, yoinked or inspired from or helped me in any other way.
