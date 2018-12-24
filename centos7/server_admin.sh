#!/bin/sh

clear

. /etc/server_admin/menu/color.sh

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

trap 'return_menu' SIGINT SIGQUIT SIGTSTP

while true
do
	show_menus
	read_options
done