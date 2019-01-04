#!/usr/bin/env bash

# Renders a text based list of options that can be selected by the
# user using up, down and enter keys and returns the chosen option.
#
#   Arguments   : list of options, maximum of 256
#                 "opt1" "opt2" ...
#   Return value: selected index (0 for opt1, 1 for opt2 ...)
. /etc/server_admin/menu/color.sh

function select_option {
    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
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

    local selected=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}

clear

installNginx="${BCyan}3.  INSTALL NGINX${Color_Off}"

return_menu() {
	server-admin
	exit
}

show_menus() {
	clear
	echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"	
	echo -e "${BYellow} S E R V E R - A D M I N - M E N U ${Color_Off}"
	echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"	
	echo -e "${BCyan}1.  CREATE DATABASE${Color_Off}"
	echo -e "${BCyan}2.  INSTALL MARIADB 10.1${Color_Off}"
	echo -e "${installNginx}"
	echo -e "${BCyan}4.  CREATE VIRTUAL HOST${Color_Off}"
	echo -e "${BCyan}5.  LIST ALL VIRTUAL HOST${Color_Off}"
	echo -e "${BCyan}6.  BACKUP DATABASES${Color_Off}"
	echo -e "${BCyan}7.  SELF UPDATE TOOL${Color_Off}"
	echo -e "${BCyan}8.  INSTALL VSFTP${Color_Off}"
	echo -e "${BCyan}9.  MOUNT FOLDER TO FPT ACCOUTN${Color_Off}"
	echo -e "${BCyan}10. UNMOUNT FOLDER FROM FPT ACCOUTN${Color_Off}"
	echo -e "${BCyan}11. CREATE FTP ACCOUNT${Color_Off}"
	echo -e "${BCyan}12. INSTALL PHP${Color_Off}"
	echo -e "${BCyan}13. REMOVE ALL PHP${Color_Off}"
	echo -e "${BRed}14. CHANGE YOUR IP SERVER${Color_Off}"
	echo -e "${BCyan}15. INSTALL COMPOSER${Color_Off}"
	echo -e "${BCyan}16. INSTALL NODEJS${Color_Off}"
	echo -e "${BRed}17.  EXIT${Color_Off}"
}

show_title() {
	echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"	
	echo -e "${BYellow} S E R V E R - A D M I N - M E N U ${Color_Off}"
	echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"	
}
show_root_menus() {
	clear
	echo -e "${BCyan}1.  DEVELOPMENTS${Color_Off}"
	echo -e "${BCyan}2.  NETWORKS${Color_Off}"
	echo -e "${BCyan}3.  SYSTEMS${Color_Off}"
	echo -e "${BCyan}4.  WEB SERVERS${Color_Off}"
	echo -e "${BCyan}5.  UTILITIES${Color_Off}"
	echo -e "${BCyan}6.  SELF UPDATE TOOL${Color_Off}"
	echo -e "${BRed}7.  EXIT${Color_Off}"
}

read_root_menu_options() {
	local choice
	read -p "Enter choice [ 1 - 7] " choice
	case $choice in
		1) /etc/server_admin/menu/developments/menu; break ;;
		2) /etc/server_admin/menu/networks/menu; break ;;
		3) /etc/server_admin/menu/systems/menu; break ;;
		4) /etc/server_admin/menu/webservers/menu; break ;;
		5) /etc/server_admin/menu/utilities/menu; break ;;
		6) /etc/server_admin/menu/selt_update_tool; break ;;
		7) exit 0;;
		*) echo -e "${RED}Error...${Color_Off}"
	esac
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 17] " choice
	case $choice in
		1) /etc/server_admin/menu/create_database; break ;;
		2) /etc/server_admin/menu/install_mariadb; break ;;
		3) /etc/server_admin/menu/install_nginx; break ;;
		4) /etc/server_admin/menu/create_virtualhost; break ;;
		5) /etc/server_admin/menu/list_domain; break ;;
		6) /etc/server_admin/menu/list_databases; break ;;
		7) /etc/server_admin/menu/selt_update_tool; break ;;
		8) /etc/server_admin/menu/install_ftp; break ;;
		9) /etc/server_admin/menu/mount_folder_to_ftp; break ;;
		10) /etc/server_admin/menu/unmount_folder_to_ftp; break ;;
		11) /etc/server_admin/menu/create_ftp_user; break ;;
		12) /etc/server_admin/menu/install_php; break ;;
		13) /etc/server_admin/menu/remove_all_php; break ;;
		14) /etc/server_admin/menu/change_ip; break ;;
		15) /etc/server_admin/menu/install_composer; break ;;
		16) /etc/server_admin/menu/install_nodejs; break ;;
		17) exit 0;;
		*) echo -e "${RED}Error...${Color_Off}"
	esac
}

action() {
	case $1 in
		1) /etc/server_admin/menu/developments/menu; break ;;
		2) /etc/server_admin/menu/networks/menu; break ;;
		3) /etc/server_admin/menu/systems/menu; break ;;
		4) /etc/server_admin/menu/webservers/menu; break ;;
		5) /etc/server_admin/menu/utilities/menu; break ;;
		6) /etc/server_admin/menu/selt_update_tool; break ;;
		7) exit 0;;
		*) echo -e "${RED}Error...${Color_Off}"
	esac
}
clear
trap 'return_menu' SIGINT SIGQUIT SIGTSTP

show_title
options=("DEVELOPMENTS" "NETWORKS" "SYSTEMS" "WEB SERVERS" "UTILITIES" "SELF UPDATE TOOL" "EXIT")
select_option "${options[@]}"
choice=$?
action choice