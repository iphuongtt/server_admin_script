#!/bin/sh

clear
if [ $(id -u) != "0" ]; then
    printf "You need to be root to perform this command. Run \"sudo su\" to become root!\n"
    exit
fi

prompt="Chose your action:"
options=("Create database", "Install Mariadb 10.1", "Install Nginx") # End Options

printf "=========================================================================\n"
printf "                             Server Admin Menu\n"
printf "=========================================================================\n"
PS3="
$prompt"
select opt in "${options[@]}" "Exit"; do 

    case "$REPLY" in
	    1 ) /etc/server_admin/menu/create_database;;
		2 ) /etc/server_admin/menu/install_mariadb;;
		3 ) /etc/server_admin/menu/install_nginx;;
	    # End Menu

	    $(( ${#options[@]}+1 )) ) printf "\nBye\n\n"; break;;
	    *) echo "Please, chose again";continue;;

    esac

done