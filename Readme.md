# List of docker-compose ready apps
Using docker and docker-compose is not so easy for the beginners... This is a repository of the apps I use, hopefully it can save time to others !

I only tested these scripts on ubuntu 16.04, not sure it will work for everyone. 
For windows users, do not loose your time here.



## How to quickly use on your server ?
If you want to easily install on your server/computer, you can use a small batch script as described below.
Replace "shadowsocks" by the folder name of the app name you wish to use.
```bash
rm composeapps.sh
wget https://raw.githubusercontent.com/sbglive/compose/master/composeapps.sh && chmod +x composeapps.sh
./composeapps.sh shadowsocks
cd shadowsocks
./up.sh
```

## Make it your own ? Contribute
Feel free to fork, clone or contribute !


# APP List

## shadowsocks = VPN
Based on mritd/shadowsocks:latest
- To access from web, open firewall ports: 6443/tcp and 6500/udp
- Change password "test123" in the .yml file

## cloud9 = WEB IDE
Based on sapk/cloud9:latest
- To access from web, open firewall ports: 8181/tcp
- Login/Password: input your login and password instead of "login:password"
- Replace "~/workspace" by the path on your host that you want to see in cloud9

## odoo (Odoo V11) = OPENSOURCE ERP
Based on elicocorp/odoo-china:11.0 and postgres:9.5
- To access from web, open firewall ports: 8069/tcp
- To access postgresql, open firewall ports: 5432/tcp (BE CAREFUL, THIS WILL EXPOSE DB TO INTERNET)

Change the parameters below in docker-compose-yml (odoouser, password_db, password_odooadmin)
- POSTGRES_USER=odoouser
- POSTGRES_PASSWORD=password_db
- ODOO_ADMIN_PASSWD=password_odooadmin
- ODOO_DB_USER=odoouser
- ODOO_DB_PASSWORD=password_db

## cadvisor = DOCKER/SERVER MONITORING
Based on google/cadvisor:latest
- To access from web, open firewall ports: 8080/tcp

## owncloud = PERSONAL CLOUD HOSTING
Based on bitnami/mariadb:latest and bitnami/owncloud:latest
- To access from web, open firewall ports: 80/tcp 443/tcp
- You may need to change ports to something else if you cannot use 80 and 443 (restrictions to http/https)

## portainer = DOCKER WEB MANAGEMENT UI
Based on portainer/portainer:latest
- To access from web, open firewall ports: 9000/tcp

## wordpress = WORDPRESS CMS
Based on bitnami/wordpress:latest , bitnami/phpmyadmin:latest , bitnami/mariadb:latest
- To access from web, open firewall ports: 80/tcp (http wordpress), 443/tcp (https wordpress), 8080/tcp (http phpmyadmin), 8443/tcp (https phpmyadmin)

You may want to change these parameters:
- MARIADB_USER=bn_wordpress
- MARIADB_DATABASE=bitnami_wordpress
- WORDPRESS_DATABASE_USER=bn_wordpress
- WORDPRESS_DATABASE_NAME=bitnami_wordpress


## production_server = A SETUP INSTALLING MUTIPLE APPS FOR A PRODUCTION SERVER
Will install portainer, cadvisor, owncloud, odoo, mariadb, postgresql
- To access from web, open firewall ports: 5432/tcp (be careful, this will expose postgresql to internet), 8069/tcp (odoo), 9000/tcp (portainer), 8181/tcp (cloud9), 8080/tcp (cadvisor), 9004/tcp (owncloud)

Make sure to change:
- POSTGRES_USER=db_user
- POSTGRES_PASSWORD=db_password
- ODOO_ADMIN_PASSWD=odoo_password
- ODOO_DB_USER=db_user
- ODOO_DB_PASSWORD=db_password
- cloud9user:cloud9password
