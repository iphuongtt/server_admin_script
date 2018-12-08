#!/bin/sh

clear
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

installNginx="${BCyan}3. INSTALL NGINX${Color_Off}"
# check nginx is installed
if [ -f /lib/systemd/system/nginx.service ]; then
  installNginx="${BWhite}3. INSTALL NGINX${Color_Off}"
fi
if [ $(id -u) != "0" ]; then
    printf "You need to be root to perform this command. Run \"sudo su\" to become root!\n"
    exit
fi

show_menus() {
	clear
	echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"	
	echo -e "${BYellow} S E R V E R - A D M I N - M E N U ${Color_Off}"
	echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"	
	echo -e "${BCyan}1. CREATE DATABASE${Color_Off}"
	echo -e "${BCyan}2. INSTALL MARIADB 10.1${Color_Off}"
	echo -e "${installNginx}"
	echo -e "${BCyan}4. CREATE VIRTUAL HOST${Color_Off}"
	echo -e "${BCyan}5. LIST ALL VIRTUAL HOST${Color_Off}"
	echo -e "${BCyan}6. LIST DATABASES${Color_Off}"
	echo -e "${BCyan}7. SELF UPDATE TOOL${Color_Off}"
	echo -e "${BRed}8. EXIT${Color_Off}"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 6] " choice
	case $choice in
		1) /etc/server_admin/menu/create_database; break ;;
		2) /etc/server_admin/menu/install_mariadb; break ;;
		3) /etc/server_admin/menu/install_nginx; break ;;
		4) /etc/server_admin/menu/create_virtualhost; break ;;
		5) /etc/server_admin/menu/list_domain; break ;;
		6) /etc/server_admin/menu/list_databases; break ;;
		7) /etc/server_admin/menu/selt_update_tool; break ;;
		8) exit 0;;
		*) echo -e "${RED}Error...${Color_Off}"
	esac
}

#trap '' SIGINT SIGQUIT SIGTSTP

while true
do
	show_menus
	read_options
done