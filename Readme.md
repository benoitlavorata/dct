# List of docker-compose ready apps
Using docker and docker-compose is not so easy for the beginners... This is a repository of the apps I use, hopefully it can save time to others !

I only tested these scripts on ubuntu 16.04, not sure it will work for everyone. 
For windows users, do not loose your time here.


## How to use this script as a command line anywhere on your system ?
If you want to be able to run this script easily, anywhere on your system, move it to your $PATH like below:

```bash
cd ~/ && mkdir bin
cp ~/.bash_profile ~/.bash_profile.compose.backup
echo 'PATH=$PATH:$HOME/bin' >> ~/.bash_profile 
source ~/.bash_profile
cd ~/bin
rm compose.sh
wget https://raw.githubusercontent.com/sbglive/compose/master/compose.sh && chmod +x compose.sh
mv compose.sh app
```

Now you can install any applications from this command:
```bash
app shadowsocks
```

## Make it your own ? Contribute
Feel free to fork, clone or contribute !


# APP List
- [shadowsocks](#shadowsocks)
- [cloud9](#cloud9)
- [odoo](#odoo)
- [cadvisor](#cadvisor)
- [owncloud](#owncloud)
- [portainer](#portainer)
- [wordpress](#wordpress)
- [production_server](#production_server)
- [elk](#elk)
- [monitor](#monitor)

## shadowsocks
Description: VPN
Based on mritd/shadowsocks:latest
- To access from web, open firewall ports: 6443/tcp and 6500/udp
- Change password "test123" in the .yml file

## cloud9
Description: WEB IDE
Based on sapk/cloud9:latest
- To access from web, open firewall ports: 8181/tcp
- Login/Password: input your login and password instead of "login:password"
- Replace "~/workspace" by the path on your host that you want to see in cloud9

## odoo
Description: OPENSOURCE ERP (v11)
Based on elicocorp/odoo-china:11.0 and postgres:9.5
- To access from web, open firewall ports: 8069/tcp
- To access postgresql, open firewall ports: 5432/tcp (BE CAREFUL, THIS WILL EXPOSE DB TO INTERNET)

Change the parameters below in docker-compose-yml (odoouser, password_db, password_odooadmin)
- POSTGRES_USER=odoouser
- POSTGRES_PASSWORD=password_db
- ODOO_ADMIN_PASSWD=password_odooadmin
- ODOO_DB_USER=odoouser
- ODOO_DB_PASSWORD=password_db

## cadvisor
Description: DOCKER/SERVER MONITORING
Based on google/cadvisor:latest
- To access from web, open firewall ports: 8080/tcp

## owncloud
Description: PERSONAL CLOUD HOSTING
Based on bitnami/mariadb:latest and bitnami/owncloud:latest
- To access from web, open firewall ports: 80/tcp 443/tcp
- You may need to change ports to something else if you cannot use 80 and 443 (restrictions to http/https)

## portainer
Description: DOCKER WEB MANAGEMENT UI
Based on portainer/portainer:latest
- To access from web, open firewall ports: 9000/tcp

## wordpress
Description: WORDPRESS CMS
Based on bitnami/wordpress:latest , bitnami/phpmyadmin:latest , bitnami/mariadb:latest
- To access from web, open firewall ports: 80/tcp (http wordpress), 443/tcp (https wordpress), 8080/tcp (http phpmyadmin), 8443/tcp (https phpmyadmin)

You may want to change these parameters:
- MARIADB_USER=bn_wordpress
- MARIADB_DATABASE=bitnami_wordpress
- WORDPRESS_DATABASE_USER=bn_wordpress
- WORDPRESS_DATABASE_NAME=bitnami_wordpress

## production_server
Description: A SETUP INSTALLING MUTIPLE APPS FOR A PRODUCTION SERVER
Will install portainer, cadvisor, owncloud, odoo, mariadb, postgresql
- To access from web, open firewall ports: 5432/tcp (be careful, this will expose postgresql to internet), 8069/tcp (odoo), 9000/tcp (portainer), 8181/tcp (cloud9), 8080/tcp (cadvisor), 9004/tcp (owncloud)

Make sure to change:
- POSTGRES_USER=db_user
- POSTGRES_PASSWORD=db_password
- ODOO_ADMIN_PASSWD=odoo_password
- ODOO_DB_USER=db_user
- ODOO_DB_PASSWORD=db_password
- cloud9user:cloud9password


## elk
Description: ELASTIC SEARCH, LOGSTASH, KIBANA = ELK STACK = HEAVY STUFF
Based on sebp/elk:564
- To access from web, open firewall ports: 5601/tcp (kibana), 9200/tcp (elastic search), 5044/tcp (logstash)
