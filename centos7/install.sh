#!bin/bash
clear

. ~/server_admin_script/menu/color.sh
. ~/server_admin_script/menu/global_var
. ~/server_admin_script/menu/function.sh

if [ $(id -u) != "0" ]; then
    printf "You need to be root to perform this command. Run \"sudo su\" to become root!\n"
    exit
fi

mkdir -p /etc/server_admin/menu/
cp ~/server_admin_script/centos7/server_admin.sh /bin/server-admin && chmod +x /bin/server-admin
cp ~/server_admin_script/centos7/menu/* /etc/server_admin/menu/
chmod +x /etc/server_admin/menu/*

update_system

install_common_package
