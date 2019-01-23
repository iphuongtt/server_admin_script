#!/usr/bin/env bash

# Renders a text based list of options that can be selected by the
# user using up, down and enter keys and returns the chosen option.
#
#   Arguments   : list of options, maximum of 256
#                 "opt1" "opt2" ...
#   Return value: selected index (0 for opt1, 1 for opt2 ...)
. /etc/server_admin/menu/color.sh

function select_option {
    number_option=$(($# + 1))
    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $BGreen $1 $Color_Off"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=1
    while true; do
        # print options by overwriting the last lines
        local idx=1
        for opt; do
            cursor_to $(($startrow + $idx))
            if [[ $idx -eq $selected ]]; then
                print_selected "$idx. $opt"
            else
                print_option "$idx. $opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 1 ]; then selected=$#; fi;;
            down)  ((selected++));
                   if [ $selected -ge $number_option ]; then selected=1; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}

return_menu() {
    server-admin
    exit
}

show_title() {
    echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
    echo -e "${BYellow} S E R V E R - A D M I N - M E N U ${Color_Off}"
    echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
}

show_menu() {
    show_title
    options=("DEVELOPMENTS" "NETWORKS" "SYSTEMS" "WEB SERVERS" "UTILITIES" "SELF UPDATE TOOL" "EXIT")
    select_option "${options[@]}"
    choice=$?
    read_options $choice
}

read_options() {
    case $1 in
        1) bash /etc/server_admin/menu/developments/menu; exit ;;
        2) bash /etc/server_admin/menu/networks/menu; exit ;;
        3) bash /etc/server_admin/menu/systems/menu; exit ;;
        4) bash /etc/server_admin/menu/webservers/menu; exit ;;
        5) bash /etc/server_admin/menu/utilities/menu; exit ;;
        6) bash /etc/server_admin/menu/selt_update_tool; exit ;;
        7) clear; exit 0;;
        *) clear && show_root_new_menu
    esac
}

clear
trap 'return_menu' SIGINT SIGQUIT SIGTSTP
show_menu
