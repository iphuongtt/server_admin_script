#!bin/bash

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

. $SCRIPTPATH/menu/color.sh
. $SCRIPTPATH/menu/global_var
. $SCRIPTPATH/menu/verify_root

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

mkdir -p /etc/server_admin/menu/
cp $SCRIPTPATH/server_admin.sh /bin/server-admin && chmod +x /bin/server-admin
cp $SCRIPTPATH/menu/* /etc/server_admin/menu/
chmod +x /etc/server_admin/menu/*

update_system

install_common_package