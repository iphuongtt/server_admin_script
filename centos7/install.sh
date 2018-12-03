#!bin/sh
if [ $(id -u) != "0" ]; then
    printf "You need to be root to perform this command. Run \"sudo su\" to become root!\n"
    exit
fi
mkdir -p /etc/server_admin/menu/
cp server_admin.sh /bin/server-admin && chmod +x /bin/server-admin
cp menu/* /etc/server_admin/menu/
chmod +x /etc/server_admin/menu/*