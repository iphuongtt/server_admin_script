#!/bin/sh

clear

RED='\033[0;41;30m'
STD='\033[0;0;39m'

installNginx="Install Nginx"
# check nginx is installed
if [ -f /etc/nginx/nginx.conf ]; then
  installNginx="${RED}Install Nginx${STD}"
fi
if [ $(id -u) != "0" ]; then
    printf "You need to be root to perform this command. Run \"sudo su\" to become root!\n"
    exit
fi

show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " S E R V E R - A D M I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Create database"
	echo "2. Install Mariadb 10.1"
	echo "3. ${installNginx}"
	echo "4. Exit"
}

ead_options(){
	local choice
	read -p "Enter choice [ 1 - 3] " choice
	case $choice in
		1) /etc/server_admin/menu/create_database ;;
		2) /etc/server_admin/menu/install_mariadb ;;
		3) /etc/server_admin/menu/install_nginx ;;
		4) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

trap '' SIGINT SIGQUIT SIGTSTP

while true
do
	show_menus
	read_options
done