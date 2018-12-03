#!/bin/sh

clear
prompt="Chose your action:"
options=("Create database", "Install Mariadb 10.1") # End Options

printf "=========================================================================\n"
printf "                             Server Admin Menu\n"
printf "=========================================================================\n"
PS3="
$prompt"
select opt in "${options[@]}" "Exit"; do 

    case "$REPLY" in
	    1 ) /etc/server_admin/menu/create_database;;
		2 ) /etc/server_admin/menu/install_mariadb;;
	    # End Menu

	    $(( ${#options[@]}+1 )) ) printf "\nBye\n\n"; break;;
	    *) echo "Please, chose again";continue;;

    esac

done