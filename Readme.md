# List of docker-compose ready apps
Using docker and docker-compose is not so easy for the beginners... This is a repository of the apps I use, hopefully it can save time to others !

## How to quickly use on your server ?
If you want to easily install on your server/computer, you can use a small batch script (UNIX only) as described below.
Replace shadowsocks by the folder name of the app name you wish to use.
```bash
rm composeapps.sh
wget https://raw.githubusercontent.com/sbglive/compose/master/composeapps.sh && chmod +x composeapps.sh
./composeapps.sh shadowsocks
cd shadowsocks
docker-compose up -d
```

## Make it your own ? Contribute
Feel free to fork, clone or contribute !


# APP List

## shadowsocks
Based on mritd/shadowsocks:latest
- To access from web, open firewall ports: 6443/tcp and 6500/udp
- Change password "test123" in the .yml file

## Cloud9
Based on sapk/cloud9:latest
- To access from web, open firewall ports: 8181/tcp
- Login/Password: input your login and password instead of "login:password"
- Replace "~/workspace" by the path on your host that you want to see in cloud9
