#! /bin/bash

# Adding color to output
set +x
#}
function red(){
    echo -e "\x1B[31m $1 \x1B[0m"
    if [ ! -z "${2}" ]; then
    echo -e "\x1B[31m $($2) \x1B[0m"
    fi
}
function blue(){
    echo -e "\x1B[34m $1 \x1B[0m"
    if [ ! -z "${2}" ]; then
    echo -e "\x1B[34m $($2) \x1B[0m"
    fi
}
function purple(){
    echo -e "\x1B[35m $1 \x1B[0m \c"
    if [ ! -z "${2}" ]; then
    echo -e "\x1B[35m $($2) \x1B[0m"
    fi
}

# Install Go tools required for functions.
# To check your $GOPATH, enter "go env" into terminal.
# Install Go
cd ~/Downloads
wget https://golang.org/dl/go1.20.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz
echo "export PATH=/usr/local/go/bin:${PATH}" | sudo tee -a $HOME/.profile
source $HOME/.profile
go version

# Move Go path to user path
sudo cp -r /home/$USER/go/bin/* /usr/sbin

#Install extras
sudo apt install figlet
sudo apt install libtext-asciitable-perl

#GO Packages from GitHub
blue "[+] Installing amass..."
go install github.com/OWASP/Amass/v3/...@latest
blue "[+] Installing ffuf..."
go install github.com/ffuf/ffuf@latest
blue "[+] Installing gobuster..."
go install github.com/OJ/gobuster@latest
blue "[+] Installing assetfinder..."
go install github.com/tomnomnom/assetfinder@latest
blue "[+] Installing gitrob..."
go install github.com/michenriksen/gitrob@latest
blue "[+] Installing gowitness..."
go install github.com/sensepost/gowitness@latest
blue "[+] Installing httprobe..."
go install github.com/tomnomnom/httprobe@latest


# Non-GO packages from GitHub
blue "[+] Downloading repolist.txt ..."

mkdir bountyHunter
mkdir bountyHunter/tools
cd bountyHunter/tools

while read repo; do
    git clone "$repo"
done < repolist.txt


