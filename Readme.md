# List of docker-compose ready apps
Using docker and docker-compose is not so easy for the beginners... This is a repository of the apps I use, hopefully it can save time to others !

## How to quickly use on your server ?
If you want to easily install on your server/computer, you can use a small batch script (UNIX only) as described below.
Replace shadowsocks by the folder name of the app name you wish to use.
```bash
wget https://raw.githubusercontent.com/sbglive/compose/master/composeapps.sh | chmod +x composeapps.sh
./composeapps.sh shadowsocks
cd shadowsocks
docker-compose up
```

## Make it your own ? Contribute
Feel free to fork, clone or contribute !


# APP List
## shadowsocks
Based on mritd/shadowsocks:latest
- Make sure to open firewall ports are 6443/tcp and 6500/udp on your host
- Change password "test123" in the .yml file
