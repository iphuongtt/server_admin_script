#!bin/bash

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

. $SCRIPTPATH/menu/color.sh
. $SCRIPTPATH/menu/global_var
. $SCRIPTPATH/menu/function.sh

if [ $(id -u) != "0" ]; then
    printf "You need to be root to perform this command. Run \"sudo su\" to become root!\n"
    exit
fi

mkdir -p /etc/server_admin/menu/
cp $SCRIPTPATH/server_admin.sh /bin/server-admin && chmod +x /bin/server-admin
cp $SCRIPTPATH/menu/* /etc/server_admin/menu/
chmod +x /etc/server_admin/menu/*

update_system

install_common_package