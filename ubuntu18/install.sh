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
    apt-get update -y -q &
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
clear

mkdir -p /etc/server_admin/menu/
mkdir -p /etc/server_admin/templates/
cp $SCRIPTPATH/server_admin.sh /bin/server-admin && chmod +x /bin/server-admin
cp -R $SCRIPTPATH/menu/* /etc/server_admin/menu/
cp -R $SCRIPTPATH/../templates/* /etc/server_admin/templates/
chmod -R +x /etc/server_admin/menu/*

update_system

install_common_package

echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
echo -e "${BYellow} INSTALL SERVER ADMIN SCRIPT SUCCESSFUL ${Color_Off}"
echo -e "Type: ${BYellow}server-admin or${Color_Off} ${BRed}sudo server-admin${Color_Off} to start"
echo -e "${BGreen}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${Color_Off}"
