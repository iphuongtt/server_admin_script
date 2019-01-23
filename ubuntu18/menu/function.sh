#!/bin/bash

. /etc/server_admin/menu/color.sh
. /etc/server_admin/menu/global_var

is_folder_exists() {
	if [ -d $1 ]; then
	   	return 0;
	else
		return 1;
	fi
}

update_system() {
    apt-get update -y -q &
    PID=$!
    i=1
    sp="/-\|"
    echo -e -n "${BGreen}Updating package database...${Color_Off} "
    while [ -d /proc/$PID ]
    do
      printf "\b${sp:i++%${#sp}:1}"
    done
    echo -e "${BBlue} Done${Color_Off}"
    printf "\n"
}

install_common_package() {
    apt-get install wget unzip -y -q   > /dev/null 2>&1 &
    PID=$!
    i=1
    sp="/-\|"
    echo -e -n "${BGreen}Installing common packages...${Color_Off} "
    while [ -d /proc/$PID ]
    do
      printf "\b${sp:i++%${#sp}:1}"
    done
    echo -e "${BBlue} Done${Color_Off}"
    printf "\n"
}

select_option() {
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
            if [ $idx -eq $selected ]; then
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

show_title() {
	echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
	echo -e "${BYellow} $1 ${Color_Off}"
	echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
}

show_menu() {
	title=$1
	local idx=0
	local i=0
    for opt; do
        if [[ idx -gt 0 ]]; then
        	options[i]=$opt
        	((i++))
        fi
        ((idx++))
    done
	show_title "$title"
	select_option "${options[@]}"
	choice=$?
	return $choice
}

check_command_error() {
    if [ "`cat $1 | grep ERROR`" != "" ]
    then
      return 1
    else
      return 0
    fi
    rm -rf $1
}
