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

#Install Go
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

# Install Go tools required for functions.
# To check your $GOPATH, enter "go env" into terminal.

blue "[+] Installing amass..."
go install github.com/OWASP/Amass/v3/...@latest
blue "[+] Installing photon..."
go install github.com/s0md3v/Photon@latest
blue "[+] Installing ffuf..."
go install github.com/ffuf/ffuf@latest
blue "[+] Installing gobuster..."
go install github.com/OJ/gobuster@latest
blue "[+] Installing paramspider..."
go install github.com/devanshbatham/ParamSpider@latest
blue "[+] Installing totalrecon..."
go install github.com/vitalysim/totalrecon@latest
blue "[+] Installing raccoon..."
go install github.com/evyatarmeged/Raccoon@latest
blue "[+] Installing assetfinder..."
go install github.com/tomnomnom/assetfinder@latest
blue "[+] Installing gitrob..."
go install github.com/michenriksen/gitrob@latest
blue "[+] Installing iis-shortname-scanner..."
go install github.com/irsdl/IIS-ShortName-Scanner@latest
blue "[+] Installing sqlmap..."
go install github.com/sqlmapproject/sqlmap@latest
blue "[+] Installing commix..."
go install github.com/commixproject/commix@latest
blue "[+] Installing docem..."
go install github.com/whitel1st/docem@latest
blue "[+] Installing fuxsploider..."
go install github.com/almandin/fuxploider@latest
blue "[+] Installing fdsploit..."
go install github.com/chrispetrou/FDsploit@latest
blue "[+] Installing lfisuite..."
go install github.com/D35m0nd142/LFISuite@latest
blue "[+] Installing xspear..."
go install github.com/hahwul/XSpear@latest
blue "[+] Installing ssrfmap..."
go install github.com/swisskyrepo/SSRFmap@latest
blue "[+] Installing gowitness..."
go install github.com/sensepost/gowitness@latest
blue "[+] Installing httprobe..."
go install github.com/tomnomnom/httprobe@latest



