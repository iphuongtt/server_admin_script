#!bin/bash
clear

. /home/root/server_admin_script/centos7/menu/color.sh
. /home/root/server_admin_script/centos7/menu/global_var
. /home/root/server_admin_script/centos7/menu/function.sh

if [ $(id -u) != "0" ]; then
    printf "You need to be root to perform this command. Run \"sudo su\" to become root!\n"
    exit
fi

mkdir -p /etc/server_admin/menu/
cp /home/root/server_admin_script/centos7/server_admin.sh /bin/server-admin && chmod +x /bin/server-admin
cp /home/root/server_admin_script/centos7/menu/* /etc/server_admin/menu/
chmod +x /etc/server_admin/menu/*

update_system

install_common_package
