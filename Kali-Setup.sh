#!/bin/zsh
#
# Author: Th4ntis
# git clone https://github.com/Th4ntis/Kali-Setup.git
#
# Standard Disclaimer: Author assumes no liability for any damage

# status indicators
green='\e[1;33m[+]\e[0m'

clear

echo -e "\n$green Running sudo apt update and sudo apt-upgrade..."
sudo apt-get -qq update
sudo apt-get -y -qq upgrade
echo -e "$green Complete"

echo -e "\n$green Installing tools via apt-get..."
sudo apt install -y -qq terminator neo4j bloodhound bloodhound.py amass pipx git xclip realtek-rtl88xxau-dkms dkms libcurl4-openssl-dev libssl-dev zlib1g-dev libnetfilter-queue-dev libusb-1.0-0-dev libpcap-dev flameshot bridge-utils xfce4-dev-tools pkg-config golang-gir-gio-2.0-dev libgtk-3-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev docker.io docker-compose golang-go gpsd gpsd-clients gpsd-tools xorg xrdp autorecon tesseract-ocr antiword
echo -e "$green Complete"

echo -e "\n$green Copying .zshrc to .zshrc.bak"
cp ~/.zshrc .zshrc.bak

echo -e "\n$green Setting up Oh-My-ZSh with P110k theme..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k > /dev/null

echo -e "\n$green Copying fonts for ..."
sudo mkdir /usr/share/fonts/truetype/MesloLGS
sudo cp ~/Kali-Setup/fonts/* /usr/share/fonts/truetype/MesloLGS/

echo -e "\n$green Making tools folder under ~/Tools"
mkdir ~/Tools

echo -e "\n$green Adding pipx to path"
pipx ensurepath
echo -e "$green Complete"

echo -e "\n$green adding GOPATH to .zshrc"
echo '# GO Path' >> ~/.zshrc
echo 'export GOPATH="$HOME/.go"' >> ~/.zshrc
echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.zshrc
mkdir -p ~/.go/{bin,pkg,src}
echo -e "$green Complete"

source ~/.zshrc

echo -e "\n$green Installing Netexec via pipx"
pipx install git+https://github.com/Pennyw0rth/NetExec
echo -e "$green Complete"

echo -e "\n$green Installing Dehashed-API-Tool via pipx"
pipx install git+https://github.com/hmaverickadams/DeHashed-API-Tool
echo -e "$green Complete"

echo -e "\n$green Installing ShodanCLI via pipx"
pipx install shodan
echo -e "$green Complete"

echo -e "\n$green Installing ManSpider via pipx"
pipx install git+https://github.com/blacklanternsecurity/MANSPIDER
echo -e "$green Complete"

echo -e "\n$green Installing DonPAPI via pipx"
pipx install donpapi
echo -e "$green Complete"

echo -e "\n$green Getting PEASS in directory ~/Tools/"
git clone --quiet https://github.com/carlospolop/PEASS-ng.git ~/Tools/PEASS-ng > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting PCredz in directory ~/Tools/"
sudo apt-get install python3-pip libpcap-dev
pip3 install pcapy-ng
git clone --quiet https://github.com/lgandx/PCredz.git ~/Tools/PCredz > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting OneDriveUser Enum in directory ~/Tools/"
git clone --quiet https://github.com/nyxgeek/onedrive_user_enum.git ~/Tools/OneDrive_User_Enum > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting gnmap parser in directory ~/Tools/"
git clone --quiet https://github.com/jasonjfrank/gnmap-parser.git ~/Tools/gnmap-parser > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting Kerbrute in directory ~/Tools/"
cd ~/Tools/
wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64
chmod +x kerbrute_linux_amd64
cd ~/
echo -e "$green Complete"

echo -e "\n$green Getting SMBCrunch in directory ~/Tools/"
git clone --quiet https://github.com/Raikia/SMBCrunch.git ~/Tools/SMBCrunch > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting SMBSpray in directory ~/Tools/"
git clone --quiet https://github.com/absolomb/smbspray.git ~/Tools/SMBSpray > /dev/null
echo -e "$green Complete"

echo -e "\n$green Installing Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Chrome.deb
sudo dpkg -i ~/Chrome.deb;sudo apt install -y -f 2> /dev/null
sudo rm -r ~/Chrome.deb
echo -e "$green Complete"

echo -e "\n$green Installing Bettercap and Bettercap WebUI..."
go install github.com/bettercap/bettercap@latest
sudo ~/.go/bin/bettercap -eval "caplets.update; ui.update; q"
echo -e "$green Complete"

echo -e "\n$green Installing Hashcat Utils"
git clone --quiet https://github.com/hashcat/hashcat-utils.git ~/Tools/hashcat-utils > /dev/null
cd ~/Tools/hashcat-utils/src && sudo make && sudo cp *bin ../bin
echo -e "$green Complete"

echo -e "\n$green Installing HCXDumpTool"
git clone --quiet https://github.com/ZerBea/hcxdumptool ~/Tools/hcxdumptool > /dev/null
cd ~/Tools/hcxdumptool && sudo make && sudo make install
echo -e "$green Complete"

echo -e "\n$green Installing HCXTools"
git clone --quiet https://github.com/ZerBea/hcxtools.git ~/Tools/hcxtools > /dev/null
cd ~/Tools/hcxtools&& sudo make && sudo make install
echo -e "$green Complete"

echo -e "\n$green Installing Nessus"
nessus_amd64_file=$(curl https://www.tenable.com/downloads/nessus\?loginAttempted\=true | grep -o -m1 -E "Nessus-[0-9]{1,2}.[0-9]{1}.[0-9]{1}-debian10_amd64.deb" | grep -m1 -i ".deb")
nessus_amd64="https://www.tenable.com/downloads/api/v2/pages/nessus/files/$nessus_amd64_file"
sudo wget -q $nessus_amd64 -O /tmp/nessus_amd64.deb
sudo dpkg -i /tmp/nessus_amd64.deb
sudo rm -f /tmp/nessus_amd64.deb
echo -e "$green Complete"

#echo -e "\n$green Unzipping rockyou.txt"
#cd /usr/share/wordlists && sudo gzip -dqf /usr/share/wordlists/rockyou.txt.gz

echo -e "\n$green Getting config/dot files..."
echo -e "\n$green Copying zshrc..."
cp ~/Kali-Setup/zsh/zshrc ~/.zshrc

echo -e "\n$green Copying aliases..."
cp ~/Kali-Setup/zsh/aliases ~/.aliases

echo -e "\n$green Copying terminator config..."
mkdir ~/.config/terminator
cp ~/Kali-Setup/terminator/config ~/.config/terminator/config

echo -e "\n$green Copying tmux files and plugins..."
cp ~/Kali-Setup/tmux/tmux.conf ~/.tmux.conf
mkdir ~/.tmux
mkdir ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null
git clone https://github.com/tmux-plugins/tmux-cpu ~/.tmux/plugins/tmux-cpu > /dev/null
git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank > /dev/null

echo -e "\n$green Saving Wallapapers to /usr/share/backgrounds/ ..."
sudo wget -q -O /usr/share/backgrounds/th4ntis.png https://raw.githubusercontent.com/th4ntis/Kali-Setup/main/images/CyberSpider-UG-Outline.png
sudo wget -q -O /usr/share/backgrounds/kali-linux.png https://raw.githubusercontent.com/th4ntis/Kali-Setup/main/images/Kali-Linux.png

echo -e "\n$green ===== All finished! Reboot for any/all changes to take affect ===== $green\n"
