# List of docker-compose ready apps
Using docker and docker-compose is not so easy for the beginners... This is a repository of the apps I use, hopefully it can save time to others !

Should work on all ubuntu/debians. 
For windows/mac users, do not loose your time here.


## Examples
To install node-red service in current folder (https://gitlab.com/benoit.lavorata/nodered.service), just do
```
dct nodered .
```

## Requirements
You must have cUR, wget, git installed. Of course you need to have docker/docker-compose installed.
```bash
sudo apt-get install -y curl jq git
```

## Install with BASH
```bash
echo "" >> $HOME/.bashrc && echo 'alias dct="bash <(curl -s https://gitlab.com/snippets/1872219/raw\?inline\=false)"' >> $HOME/.bashrc && source $HOME/.bashrc
```

## Install with ZSH
```bash
echo "" >> $HOME/.zshrc && echo 'alias dct="bash <(curl -s https://gitlab.com/snippets/1872219/raw\?inline\=false)"' >> $HOME/.zshrc && source $HOME/.zshrc
```