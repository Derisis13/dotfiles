#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Power Menu

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt="Select power profile"
mesg="Current power profile : `powerprofilesctl get`"

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
    list_col='1'
    list_row='3'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
    list_col='3'
    list_row='1'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [ "$layout" = 'NO' ]; then
    option_1="󰡴 Performance"
    option_2="󰊚 Balanced"
    option_3="󰡳 Power saver"
else
    option_1="󰡴"
    option_2="󰊚"
    option_3="󰡳"
fi

# Rofi CMD
rofi_cmd() {
    rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
        -theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        -markup-rows \
        -theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
}


# Execute Command
run_cmd() {
    if [ "$1" = '--opt1' ]; then
        powerprofilesctl set performance
    elif [ "$1" = '--opt2' ]; then
        powerprofilesctl set balanced
    elif [ "$1" = '--opt3' ]; then
        powerprofilesctl set power-saver
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
        run_cmd --opt1
        ;;
    $option_2)
        run_cmd --opt2
        ;;
    $option_3)
        run_cmd --opt3
        ;;
esac

