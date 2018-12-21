#!/bin/bash

. /home/root/server_admin_script/centos7/menu/color.sh
. /home/root/server_admin_script/centos7/menu/global_var

is_folder_exists() {
	if [ -d $1 ]; then
	   	return 0;
	else
		return 1;
	fi
}

update_system() {
	yum update -y -q &
	PID=$!
	i=1
	sp="/-\|"
	echo -e -n "${BGreen}Updating system...${Color_Off} "
	while [ -d /proc/$PID ]
	do
	  printf "\b${sp:i++%${#sp}:1}"
	done
	echo -e "${BBlue} Done${Color_Off}"
	printf "\n"
}

install_common_package() {
	yum install wget epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm unzip -y -q &
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