# List of docker-compose ready apps
Using docker and docker-compose is not so easy for the beginners... This is a repository of the apps I use, hopefully it can save time to others !

Should work on all ubuntu/debians/macosx. 
For windows users, do not loose your time here.


## DCT bash utility
A bash script can help you install these apps in one command, it is based on an alias. The code of this script is hosted here:  https://gitlab.com/benoit.lavorata/dct/raw/master/dct.sh

### Examples
To install node-red service in current folder (https://gitlab.com/benoit.lavorata/nodered.service), just do
```
dct nodered .
```

Demo in terminal:
[![asciicast](https://asciinema.org/a/O0KuF4KG7qlU29DwBf74w7bw3.png)](https://asciinema.org/a/O0KuF4KG7qlU29DwBf74w7bw3?autoplay=1)

### Requirements
You must have cUR, wget, git installed. Of course you need to have docker/docker-compose installed.
```bash
sudo apt-get install -y curl jq git
```

For mac users:
```
# You need Homebrew installed https://brew.sh/, the command below is from their website
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install jq git curl
```

### Local version
I personally re-download the latest version of the script from this repo, as I trust I will not write malicious code there - but you may have concerns on this topic, in which case I suggest you to use the local version. 

You may want to put the script in a convenient place, in this example, it creates a ~/bin folder and downloads the script there + add the alias.

#### Install alias with BASH
```bash
mkdir ~/bin
curl -o ~/bin/dct.sh https://gitlab.com/benoit.lavorata/dct/raw/master/dct.sh
chmod +x ~/bin/dct.sh 

echo "" >> $HOME/.bashrc && echo 'alias dct="bash ~/bin/dct.sh"' >> $HOME/.bashrc && source $HOME/.bashrc
```

#### Install alias with ZSH
```bash
mkdir ~/bin
curl -o ~/bin/dct.sh https://gitlab.com/benoit.lavorata/dct/raw/master/dct.sh
chmod +x ~/bin/dct.sh 

echo "" >> $HOME/.bashrc && echo 'alias dct="bash ~/bin/dct.sh"' >> $HOME/.zshrc && source $HOME/.zshrc
```


### Web version
This version does not keep a copy of the script on your computer.

#### Install alias with BASH
```bash
echo "" >> $HOME/.bashrc && echo 'alias dct="bash <(curl -s https://gitlab.com/benoit.lavorata/dct/raw/master/dct.sh)"' >> $HOME/.bashrc && source $HOME/.bashrc
```

#### Install with ZSH
```bash
echo "" >> $HOME/.zshrc && echo 'alias dct="bash <(curl -s https://gitlab.com/benoit.lavorata/dct/raw/master/dct.sh)"' >> $HOME/.zshrc && source $HOME/.zshrc
```