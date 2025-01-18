#!/bin/sh

replace_config_line () {
  file="$1"
  setting="$2"
  value="$3"
  if grep -Eq "^${setting}=" "$file"; then
    sed -e "s/^${setting}=.*$/${setting}=${value}/" < "$file" | sudo tee "$file"
  else
    printf "%s=%s\n" "${setting}" "${value}" | sudo tee -a "$file"
  fi
}

replace_config_line "/etc/dnf/dnf.conf" "installonly_limit" "3"
replace_config_line "/etc/dnf/dnf.conf" "best" "False"
replace_config_line "/etc/dnf/dnf.conf" "skip_unavailable" "True"
replace_config_line "/etc/dnf/dnf.conf" "fastestmirror" "True"
replace_config_line "/etc/dnf/dnf.conf" "defaultyes" "True"
replace_config_line "/etc/dnf/dnf.conf" "keepcache" "True"
replace_config_line "/etc/dnf/dnf.conf" "max_parallel_downloads" "5"

ensure_installed () {
  for dep in !*; do
    dnf list --installed "$dep" 2>&1 | grep -q "$dep" || sudo dnf install "$dep" --assumeyes --allowerasing
  done
}

# Enable extra repos
sudo dnf update
sudo dnf copr enable solopasha/hyprland
sudo dnf copr enable tofik/sway
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Edit then install packages
vi ./dnf_packages.list
cat ./dnf_packages.list | xargs dnf install --assumeyes --skip-missing

# disable selinux
replace_config_line "/etc/selinux/config" "SELINUX" "disabled"
printf "You'll need to reboot to have selinux disabled\n"

# set up ZSH
ensure_installed zsh fzf sqlite3
replace_config_line '/etc/zshenv' 'export ZDOTDIR' '${HOME}/.config/zsh'
mkdir -p ~/.local/state/zsh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.oh-my-zsh ~/.local/share/oh-my-zsh/   # TODO: figure out how to contol install location of script above. Maybe reboot/relog after xgd_user_dirs is installed?
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
curl -O -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip && unzip FiraCode.zip *.ttf -d ~/.local/share/fonts/
printf "You'll need to relog to have your default shell changed\n"

# Install background and hyprland stuff
ensure_installed hyprland hyprpaper hypridle hyprlock hyprsunset
mkdir -p ~/.local/share/backgrounds/
curl -o ~/.local/share/backgrounds/eKxlw8.jpg -fsSL "https://live.staticflickr.com/5077/5914101671_d80c6591e8_k.jpg"
# desktop elements that just work
ensure_installed swaync
ensure_installed waybar fontawesome4-fonts

# Install sddm
ensure_installed sddm qt6-qtsvg qt5-qtquickcontrols2
sudo cp ~/.config/sddm/sddm.conf /etc/sddm.conf
sudo cp -r ~/.config/sddm/themes/catpuccin-macchiatto /usr/share/sddm/themes/

# Install grub
ensure_installed grub2-common
replace_config_line "/etc/default/grub" "GRUB_THEME" "/boot/themes/catppuccin-macchiato-grub-theme/theme.txt"
sudo cp -r ~/.config/grub/themes/ /boot/themes
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Install plymouth
ensure_installed plymouth plymouth-plugin-two-step
sudo cp -r ~/.config/plymouth/themes/fedora-mac-style /usr/share/plymouth/themes/
sudo plymouth-set-default-theme -R fedora-mac-style && sudo dracut --regenerate-all -f

# install gnome's stuff
ensure_installed gnome-keying nautilus dconf gedit
dconf load /org/gtk/gtk4 < ~/.config/dconf-export/gtk4.dconf
dconf load /org/gnome/desktop < ~/.config/dconf-export/gnome-desktop.dconf
dconf load /org/gnome/nautilus < ~/.config/dconf-export/nautilus.dconf
dconf load /org/gnome/gedit < ~/.config/dconf-export/gedit.dconf

# rofi & rofi-calc (compilation, because why not)
sudo dnf install --allowerasing --assumeyes https://kojipkgs.fedoraproject.org//packages/rofi-wayland/1.7.5+wayland2/3.fc40/$(uname -m)/rofi-wayland-1.7.5+wayland2-3.fc40.$(uname -m).rpm
ensure_installed rofi-devel qalculate automake libtool
git clone https://github.com/svenstaro/rofi-calc && cd rofi-calc && mkdir m4 && autoreconf -i && mkdir build && cd build && ../configure && make && sudo make install && cd ../.. && rm -rf rofi-calc

# kdeconnect
ensure_installed kdeconnectd
sudo firewall-cmd --permanent --add-service=kdeconnect
printf "You'll need to relog for kdeconnect to work\n"

# flatpaks
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flatseal librewolf

# set up neovim
ensure_installed neovim clang unzip npm ripgrep go
nvim

# to finalize it all
printf 'Press enter to reboot, ctrl+c to exit'
read -r response && sudo reboot now
