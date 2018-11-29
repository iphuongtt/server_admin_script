#!/bin/sh

clear
prompt="Chose your action:"
options=("Create database") # End Options

printf "=========================================================================\n"
printf "                             Server Admin Menu\n"
printf "=========================================================================\n"
PS3="
$prompt"
select opt in "${options[@]}" "Exit"; do 

    case "$REPLY" in
	    1 ) /etc/server_admin/menu/create_database;;
	    # End Menu

	    $(( ${#options[@]}+1 )) ) printf "\nBye\n\n"; break;;
	    *) echo "Please, chose again";continue;;

    esac

done