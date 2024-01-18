#! /bin/bash

# To check your $GOPATH, enter "go env" into terminal.
# To add to script, place entry in dir creation, recon or enumerate function and table output

figlet bountyHunter v.1

# Creating a spinner to notify that task is still running
spinner()
{
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

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


red "Enter Domain in format: domain.com. Do not place www before."

read -p "Enter Domain: " url

# Function to display the menu
show_menu() {
    echo "========= MENU ========="
    echo "1. Recon"
    echo "2. Enumerate"
    echo "3. YOLO (BOTH)"
    echo "4. Exit"
    echo "========================"
}

    if [ ! -d "$url" ];then
        mkdir $url
fi

# Function to run Recon
run_recon() {

# Recon Dir Creation

if [ ! -d "$url/recon" ];then
        mkdir $url/recon
fi
if [ ! -d "$url/recon/photon" ];then
        mkdir $url/recon/photon
fi
if [ ! -d "$url/recon/gobuster" ];then
        mkdir $url/recon/scans
fi
if [ ! -d "$url/recon/paramspider" ];then
        mkdir $url/recon/paramspider
fi
if [ ! -d "$url/recon/totalrecon" ];then
        mkdir $url/recon/totalrecon
fi
if [ ! -d "$url/recon/raccoon" ];then
        mkdir $url/recon/raccoon
fi
if [ ! -d "$url/recon/gitrob" ];then
        mkdir $url/recon/gitrob
fi
if [ ! -d "$url/recon/iis-shortname" ];then
        mkdir $url/recon/iis-shortname
fi
if [ ! -d "$url/recon/sqlmap" ];then
        mkdir $url/recon/sqlmap
fi
if [ ! -d "$url/recon/commix" ];then
        mkdir $url/recon/commix
fi
if [ ! -d "$url/recon/docem" ];then
        mkdir $url/recon/docem
fi
if [ ! -d "$url/recon/fluxsploider" ];then
        mkdir $url/recon/fluxsploider
fi
if [ ! -d "$url/recon/fdsploit" ];then
        mkdir $url/recon/fdsploit
fi
if [ ! -d "$url/recon/lfisuite" ];then
        mkdir $url/recon/lfisuite
fi
if [ ! -d "$url/recon/xspear" ];then
        mkdir $url/recon/xspear
fi
if [ ! -d "$url/recon/ssrfmap" ];then
        mkdir $url/recon/ssrfmap
fi
if [ ! -d "$url/recon/scans/nmap" ];then
        mkdir $url/recon/scans/nmap
fi
if [ ! -d "$url/recon/dnsrecon" ];then
        mkdir $url/recon/dnsrecon
fi
if [ ! -d "$url/recon/wayback/params" ];then
        mkdir $url/recon/wayback/params
fi
if [ ! -d "$url/recon/wayback/extensions" ];then
        mkdir $url/recon/wayback/extensions
fi
if [ ! -f "$url/recon/httprobe" ];then
        touch $url/recon/httprobe
fi
if [ ! -f "$url/recon/httprobe/alive.txt" ];then
        touch $url/recon/httprobe/alive.txt
fi
if [ ! -f "$url/recon/final.txt" ];then
        touch $url/recon/final.txt
fi

echo

blue "[+] Recon directory structure has been created!"

echo

echo "Running Recon..."
echo

purple "[+] Harvesting bruteforcing directories with ffuf..."
(ffuf -u https://$url/FUZZ -w /usr/share/wordlists/seclists/Disocvery/Web-Content/directory-list-lowercase-2.3-small.txt -fc 404 -recursion -recursion-depth 2 -o $url/recon/ffuf.txt) &
spinner $!
printf "\n"

purple "[+] Harvesting subdomains with AssetFinder..."
(assetfinder $url &> $url/recon/final.txt) &
spinner $!
printf "\n"

echo 
purple "[+] Running dig against domain..."
( dig $url &> $url/recon/dig.txt) &
spinner $!
printf "\n"

echo 
purple "[+] Running whois against domain..."
( whois $url &> $url/recon/whois.txt) &
spinner $!
printf "\n"

echo 
purple "[+] Running censys against domain..."
( censys $url &> $url/recon/censys.txt) &
spinner $!
printf "\n"

echo 
purple "[+] Running photon against domain..."
( photon -u https://www.$url -l 2 -o $url/recon/photon/) &
spinner $!
printf "\n"

echo 
purple "[+] Running paramspider against domain..."
( paramspider -d $url &> $url/recon/paramspider) &
spinner $!
printf "\n"

#echo 
#purple "[+] Running totalrecon ..."
#cd tools/totalrecon
#( ./total_recon.sh) &
#spinner $!
#printf "\n
 
#purple "[+] Double checking for subdomains with Amass..."
#(amass enum -d $url &> $url/recon/f.txt
#sort -u $url/recon/f.txt &> $url/recon/final.txt
#rm $url/recon/f.txt) &
#spinner $!
#printf "\n"
 
#purple "[+] Probing for alive domains..."
#(cat $url/recon/final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' &> $url/recon/httprobe/a.txt
#sort -u $url/recon/httprobe/a.txt &> $url/recon/httprobe/alive.txt
#rm $url/recon/httprobe/a.txt) &
#spinner $!
#printf "\n"

 
purple "[+] Scanning for open ports..."
(nmap -sV -Pn -n -iL $url/recon/httprobe/alive.txt -T4 -oA $url/recon/scans/scanned &> scanned.txt) &
spinner $!
printf "\n"


purple "[+] Running GoWitness against all compiled domains..."
(gowitness file -f $url/recon/httprobe/alive.txt -P $url/recon/gowitness --delay 3 &> /dev/null) &
spinner $!
printf "\n"

    echo
	echo "Recon executed."
    echo
}

# END OF RECON FUNCTION
#
#
#

# Function to run Enumerate
run_enum() {
    echo "Running Enumerate..."
	echo
# Enumerate Dir Creation	

if [ ! -d "$url/enumeration" ];then
        mkdir $url/enumeration
fi
if [ ! -d "$url/enumeration/nikto" ];then
        mkdir $url/enumeration/nikto
fi
if [ ! -d "$url/enumeration/nuclei" ];then
        mkdir $url/enumeration/nuclei
fi
if [ ! -d "$url/enumeration/wpscan" ];then
        mkdir $url/enumeration/wpscan
fi
if [ ! -d "$url/enumeration/searchsploit" ];then
        mkdir $url/enumeration/searchsploit
fi


blue "[+] Enumeration directory structure has been created!"
echo

#SQL Injection
purple "[+] Running sqlmap..."
(sqlmap -u $url ) &
spinner $!
printf "\n"

#Command Injection

blue "[+] Testing command injections"
purple "[+] Running commix..."
(commix -u $url ) &
spinner $!
printf "\n"

#Testing File Uploads
blue "[+] Testing file uploads"
purple "[+] Running docem.."
(docem -u $url ) &
spinner $!
printf "\n"

purple "[+] Running fuxsploider.."
(fuxsploider u $url ) &
spinner $!
printf "\n"

#Directory Reversal
blue "[+] Testing directory traversal"
purple "[+] Running fdsploit.."
(fdsploit -u $url ) &
spinner $!
printf "\n"

#File Inclusion
blue "[+] Testing file inclusion"
purple "[+] Running lfisuite.."
(lfisuite -u $url ) &
spinner $!
printf "\n"

#Cross Site Scripting (XSS)
blue "[+] Testing XSS"
purple "[+] Running xspear.."
(xspear -u $url ) &
spinner $!
printf "\n"

#Server Side Request Forgery
blue "[+] Testing SSRF"
purple "[+] Running ssrfmap.."
(ssrfmap -u $url ) &
spinner $!
printf "\n"

purple "[+] Running Searchsploit..." printf "\n"
(searchsploit --nmap $url/recon/scans/scanned.xml 2> /dev/null | tee $url/enumeration/searchsploit/sploits.txt) &
spinner $!
printf "\n"

    echo
	echo "Enumerate executed."
    echo


}

# END OF EUMERATE FUNCTION




# Main program loop
while true; do
    show_menu
    read -p "Enter your choice (1-4): " choice
    echo

    case $choice in
        1)
            echo
			echo "Lets get to work..."
			run_recon
			break
            ;;
        2)
            echo
			echo "Lets get to work..."
			run_enum
			break
            ;;
        3)
            echo
			echo "Lets get to work..."
			run_recon && run_enum
			break
            ;;
        4)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice. Please enter a number from 1 to 4."
            echo
            ;;
    esac
done

# Function to print Directories and Files created to a table
echo
blue "[+] Here are the locations and number of files created...Happy Hacking!" echo
print_row() {
  local name="$1" path="$2" 
  local count=$(find "$path" -maxdepth 1 -not -type d | grep -v ^d | wc -l)
  printf "%-30s| %5d\n" "$name" "$count"
}

seperator=$(printf '%.s-' {1..30})
printf "%-30s| %s\n" "Directory" "Files"
printf "%-30s|%s\n" "$seperator" "$seperator"

print_row "/recon/scans" "$url/recon/scans"
print_row "/recon/httprobe" "$url/recon/httprobe"
print_row "/recon/potential_takeovers" "$url/recon/potential_takeovers"
print_row "/recon/wayback" "$url/recon/wayback"
print_row "/recon/dnsrecon" "$url/recon/dnsrecon"
print_row "/recon/wayback/params" "$url/recon/wayback/params"
print_row "/recon/wayback/extensions" "$url/recon/wayback/extensions"
print_row "/enumeration/whatweb" "$url/enumeration/whatweb"
print_row "/enumeration/nikto" "$url/enumeration/nikto"
print_row "/enumeration/nuclei" "$url/enumeration/nuclei"
print_row "/enumeration/wpscan" "$url/enumeration/wpscan"
print_row "/enumeration/searchsploit" "$url/enumeration/searchsploit"


echo
red "Would you like to browse gowitness images and launch server? (yes or no) "
read yesorno

if [ "$yesorno" == yes ]; then
        #firefox file:///$(pwd)/$url/recon/gowitness
	eog $url/recon/gowitness
	gowitness server -a localhost:4040

elif [ "$yesorno" == no ]; then
        exit 1

else
        red "Not a valid answer."
        exit 1

fi
