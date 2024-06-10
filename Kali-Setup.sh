#!/bin/bash
#
# Kali-Setup.sh  Author: Th4ntis
# git clone https://github.com/Th4ntis/Kali-Setup.git
#
# Standard Disclaimer: Author assumes no liability for any damage

# status indicators
green='\e[1;33m[+]\e[0m'

echo -e "\n$green Running apt update..."
sudo apt-get update
echo -e "$green Complete"

echo -e "\n$green Running apt upgrade..."
sudo apt-get -y -qq upgrade
echo -e "$green Complete"

echo -e "\n$green Installing tools via apt-get..."
sudo apt install -y terminator neo4j bloodhound amass pipx libu2f-udev responder realtek-rtl88xxau-dkms dkms libcurl4-openssl-dev libssl-dev zlib1g-dev libnetfilter-queue-dev libusb-1.0-0-dev libpcap-dev flameshot bridge-utils xfce4-dev-tools pkg-config golang-gir-gio-2.0-dev libgtk-3-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev docker.io docker-compose golang-go gpsd gpsd-clients gpsd-tools
echo -e "$green Complete"

echo -e "\n$green Making tools folder under ~/Tools"
mkdir ~/Tools

echo -e "\n$green Copying .zshrc to .zshrc.bak"
cp ~/.zshrc .zshrc.bak

echo -e "\n$green Installing Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Chrome.deb
sudo dpkg -i ~/Chrome.deb;sudo apt install -y -f 2> /dev/null
echo -e "$green Complete"

echo -e "\n$green Unzipping rockyou.txt"
cd /usr/share/wordlists && sudo gzip -dqf /usr/share/wordlists/rockyou.txt.gz
echo -e "$green Complete"

echo -e "\n $green adding GOPATH to .zshrc"
echo 'export GOPATH="$HOME/.go"' >> ~/.zshrc
echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.zshrc
source ~/.zshrc
mkdir -p ~/.go/{bin,pkg,src}
echo -e "$green Complete"

echo -e "\n $green Installing Bettercap and Bettercap WebUI..."
go install github.com/bettercap/bettercap@latest
sudo ~/.go/bin/bettercap -eval "caplets.update; ui.update; q"
echo -e "$green Complete"

echo -e "\n $green Getting Responder as backup to installed Responder"
git clone --quiet https://github.com/lgandx/Responder.git ~/Tools/ > /dev/null
echo -e "$green Complete"

echo -e "\n $green Getting Impacket as backup to installed Ipacket"
git clone --quiet https://github.com/fortra/impacket.git ~/Tools/ > /dev/null
echo -e "$green Complete"

echo -e "\n $green Installing Hashcat Utils"
git clone --quiet https://github.com/hashcat/hashcat-utils.git ~/Tools/ > /dev/null
cd ~/Tools/hashcat-utils/src
sudo make && sudo cp *bin ../bin
echo -e "$green Complete"

echo -e "\n $green Installing HCXDumpTool"
git clone --quiet https://github.com/ZerBea/hcxdumptool ~/Tools/ > /dev/null
cd hcxdumptool
sudo make && sudo make install
echo -e "$green Complete"

echo -e "\n $green Installing HCXTools"
git clone --quiet https://github.com/ZerBea/hcxtools.git ~/Tools/ > /dev/null
cd ~/Tools/hcxtools&& sudo make && sudo make install
echo -e "$green Complete"


echo -e "\n $green Installing RTL8812AU Drivers"
git clone --quiet -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git ~/Tools/ > /dev/null
cd ~/Tools/rtl8812au && sudo make && sudo make install
echo -e "$green Complete"

echo -e "\n $green Installing ShodanCLI"
pipx install shodan
sudo pipx install shodan
echo -e "$green Complete"

echo -e "\n $green Installing PEASS"
git clone --quiet https://github.com/carlospolop/PEASS-ng.git ~/Tools/ > /dev/null
echo -e "$green Complete"

echo -e "\n $green Installing PCredz"
git clone --quiet https://github.com/lgandx/PCredz.git ~/Tools/ > /dev/null
echo -e "$green Complete"

echo -e "\n $green Installing OneDriveUser Enum"
git clone --quiet https://github.com/nyxgeek/onedrive_user_enum.git ~/Tools/ > /dev/null
echo -e "$green Complete"

#echo -e "\n $green Installing NetExec"
#pipx install git+https://github.com/Pennyw0rth/NetExec
# sudo pipx install git+https://github.com/Pennyw0rth/NetExec
#echo -e "$green Complete"

echo -e "\n $green Installing DonPAPI"
pipx install donpapi
sudo pipx install donpapi
echo -e "$green Complete"

echo -e "\n $green Installing gnmap parser"
git clone --quiet https://github.com/jasonjfrank/gnmap-parser.git ~/Tools/ > /dev/null
echo -e "$green Complete"

echo -e "\n $green Installing Nessus"
nessus_amd64_file=$(curl https://www.tenable.com/downloads/nessus\?loginAttempted\=true | grep -o -m1 -E "Nessus-[0-9]{1,2}.[0-9]{1}.[0-9]{1}-debian10_amd64.deb" | grep -m1 -i ".deb")
nessus_amd64="https://www.tenable.com/downloads/api/v2/pages/nessus/files/$nessus_amd64_file"
sudo wget -q $nessus_amd64 -O /tmp/nessus_amd64.deb
sudo dpkg -i /tmp/nessus_amd64.deb
sudo rm -f /tmp/nessus_amd64.deb
echo -e "$green Complete"

echo -e "\n $green Installing TMUX Plugins"
git clone --quiet https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null
git clone --quiet https://github.com/tmux-plugins/tmux-battery ~/.tmux/plugins/tmux-battery > /dev/null
git clone --quiet https://github.com/tmux-plugins/tmux-cpu ~/.tmux/plugins/tmux-cpu > /dev/null
git clone --quiet https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank > /dev/null
echo -e "$green Complete"

echo -e "\n $green Changing Power Settings"
wget -q https://raw.githubusercontent.com/Dewalt-arch/pimpmyi3-config/main/xfce4/xfce4-power-manager.xml -O /home/$USER/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
echo -e "$green Complete"

echo -e "\n $green Installing Virtualbox"
sudo apt update && sudo apt full-upgrade -y && sudo apt install -y virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11
sudo adduser $USER vboxusers
echo -e "$green Complete"

echo -e "\n $green Setting up RDP over port 3389"
sudo apt update && sudo apt full-upgrade -y && sudo apt install -y xorg xrdp
sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini
echo -e "$green Complete"

echo -e "\n $green Finishing Up"
sudo apt autoremove -y
echo 'export PATH="$PATH:/home/th4ntis/.local/bin"' >> ~/.zshrc
echo 'export PATH="$PATH:/root/.local/bin"' >> ~/.zshrc
echo -e "$green Complete"
