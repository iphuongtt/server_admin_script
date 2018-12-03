#!bin/sh

mkdir -p /etc/server_admin/menu/
cp server_admin.sh /bin/server-admin && chmod +x /bin/server-admin
cp menu/* /etc/server_admin/menu/
chmod +x /etc/server_admin/menu/*