# List of docker-compose ready apps
Using docker and docker-compose is not so easy for the beginners... This is a repository of the apps I use, hopefully it can save time to others !

Should work on all ubuntu/debians. 
For windows/mac users, do not loose your time here.


## DCT bash utility
A bash script can help you install these apps in one command, it is based on an alias. The code of this script is hosted here: https://gitlab.com/snippets/1872219

### Examples
To install node-red service in current folder (https://gitlab.com/benoit.lavorata/nodered.service), just do
```
dct nodered .
```

### Requirements
You must have cUR, wget, git installed. Of course you need to have docker/docker-compose installed.
```bash
sudo apt-get install -y curl jq git
```

### Local version
I personally re-download the latest version of the script from a snippet in gitlab, as I trust I will not write malicious code there - but you may have concerns on this topic, in which case I suggest you to use the local version. 

You may want to put the script in a convenient place, in this example, it creates a ~/bin folder and downloads the script there + add the alias.

#### Install alias with BASH
```bash
mkdir ~/bin
curl -o ~/bin/dct.sh https://gitlab.com/snippets/1872219/raw\?inline\=false
chmod +x ~/bin/dct.sh 

echo "" >> $HOME/.bashrc && echo 'alias dct="bash ~/bin/dct.sh"' >> $HOME/.bashrc && source $HOME/.bashrc
```

#### Install alias with ZSH
```bash
mkdir ~/bin
curl -o ~/bin/dct.sh https://gitlab.com/snippets/1872219/raw\?inline\=false
chmod +x ~/bin/dct.sh 

echo "" >> $HOME/.bashrc && echo 'alias dct="bash ~/bin/dct.sh"' >> $HOME/.zshrc && source $HOME/.zshrc
```


### Web version
This version does not keep a copy of the script on your computer.

#### Install alias with BASH
```bash
echo "" >> $HOME/.bashrc && echo 'alias dct="bash <(curl -s https://gitlab.com/snippets/1872219/raw\?inline\=false)"' >> $HOME/.bashrc && source $HOME/.bashrc
```

#### Install with ZSH
```bash
echo "" >> $HOME/.zshrc && echo 'alias dct="bash <(curl -s https://gitlab.com/snippets/1872219/raw\?inline\=false)"' >> $HOME/.zshrc && source $HOME/.zshrc
```