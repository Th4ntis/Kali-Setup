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
sudo apt install -y -qq terminator neo4j bloodhound amass pipx libu2f-udev xclip responder realtek-rtl88xxau-dkms dkms libcurl4-openssl-dev libssl-dev zlib1g-dev libnetfilter-queue-dev libusb-1.0-0-dev libpcap-dev flameshot bridge-utils xfce4-dev-tools pkg-config golang-gir-gio-2.0-dev libgtk-3-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev docker.io docker-compose golang-go gpsd gpsd-clients gpsd-tools virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11 xorg xrdp
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

#echo -e "\n $green adding GOPATH to .zshrc"
#echo 'export GOPATH="$HOME/.go"' >> ~/.zshrc
#echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.zshrc
#source ~/.zshrc
#mkdir -p ~/.go/{bin,pkg,src}
#echo -e "$green Complete"

echo -e "\n $green Installing Bettercap and Bettercap WebUI..."
go install github.com/bettercap/bettercap@latest
sudo ~/.go/bin/bettercap -eval "caplets.update; ui.update; q"
echo -e "$green Complete"

echo -e "\n $green Getting Responder as backup to installed Responder"
git clone --quiet https://github.com/lgandx/Responder.git ~/Tools/Responder > /dev/null
echo -e "$green Complete"

echo -e "\n $green Getting Impacket as backup to installed Ipacket"
git clone --quiet https://github.com/fortra/impacket.git ~/Tools/Impacket > /dev/null
echo -e "$green Complete"

echo -e "\n $green Installing Hashcat Utils"
git clone --quiet https://github.com/hashcat/hashcat-utils.git ~/Tools/hashcat-utils > /dev/null
cd ~/Tools/hashcat-utils/src
sudo make && sudo cp *bin ../bin
echo -e "$green Complete"

echo -e "\n $green Installing HCXDumpTool"
git clone --quiet https://github.com/ZerBea/hcxdumptool ~/Tools/hcxdumptool > /dev/null
cd hcxdumptool
sudo make && sudo make install
echo -e "$green Complete"

echo -e "\n $green Installing HCXTools"
git clone --quiet https://github.com/ZerBea/hcxtools.git ~/Tools/hcxtools > /dev/null
cd ~/Tools/hcxtools&& sudo make && sudo make install
echo -e "$green Complete"


#echo -e "\n $green Installing RTL8812AU Drivers"
#git clone --quiet -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git ~/Tools/rtl8812au > /dev/null
#cd ~/Tools/rtl8812au && sudo make && sudo make install
#echo -e "$green Complete"

echo -e "\n $green Installing ShodanCLI"
pipx install shodan
sudo pipx install shodan
echo -e "$green Complete"

echo -e "\n $green Installing PEASS"
git clone --quiet https://github.com/carlospolop/PEASS-ng.git ~/Tools/PEASS-ng > /dev/null
echo -e "$green Complete"

echo -e "\n $green Installing PCredz"
git clone --quiet https://github.com/lgandx/PCredz.git ~/Tools/PCredz > /dev/null
echo -e "$green Complete"

echo -e "\n $green Installing OneDriveUser Enum"
git clone --quiet https://github.com/nyxgeek/onedrive_user_enum.git ~/Tools/OneDrive_User_Enum > /dev/null
echo -e "$green Complete"

# May not be needed with NetExec being added to Kali 2024.2
#echo -e "\n $green Installing NetExec"
#pipx install git+https://github.com/Pennyw0rth/NetExec
#sudo pipx install git+https://github.com/Pennyw0rth/NetExec
#echo -e "$green Complete"

echo -e "\n $green Installing DonPAPI"
pipx install donpapi
sudo pipx install donpapi
echo -e "$green Complete"

echo -e "\n $green Installing gnmap parser"
git clone --quiet https://github.com/jasonjfrank/gnmap-parser.git ~/Tools/gnmap-parser > /dev/null
echo -e "$green Complete"

echo -e "\n $green Installing Nessus"
nessus_amd64_file=$(curl https://www.tenable.com/downloads/nessus\?loginAttempted\=true | grep -o -m1 -E "Nessus-[0-9]{1,2}.[0-9]{1}.[0-9]{1}-debian10_amd64.deb" | grep -m1 -i ".deb")
nessus_amd64="https://www.tenable.com/downloads/api/v2/pages/nessus/files/$nessus_amd64_file"
sudo wget -q $nessus_amd64 -O /tmp/nessus_amd64.deb
sudo dpkg -i /tmp/nessus_amd64.deb
sudo rm -f /tmp/nessus_amd64.deb
echo -e "$green Complete"

echo -e "\n $green Changing Power Settings"
wget -q https://raw.githubusercontent.com/th4ntis/Kali-Setup/xfce4-power-manager.xml -O /home/$USER/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
echo -e "$green Complete"

echo -e "\n $green Adding usser $USER to vboxusers group for Virtualbox"
sudo adduser $USER vboxusers
echo -e "$green Complete"

echo -e "\n $green Setting up RDP over port 3389"
sudo apt update && sudo apt full-upgrade -y && sudo apt install -y xorg xrdp
sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini
echo -e "$green Complete"

echo -e "\n$green Getting config/dot files..."
git clone --quiet https://github.com/Th4ntis/Kali-Setup.git ~/Kali-Setup  > /dev/null
echo -e "Copying .zshrc..."
cp ~/Kali-Setup/zsh/.zshrc ~/
echo -e "Copying .aliases..."
cp ~/Kali-Setup/zsh/.aliases ~/.aliases
echo -e "Copying terminator config..."
mkdir ~/.config/terminator
cp ~/Kali-Setup/terminator/config ~/.config/terminator/config
echo -e "Copying tmux files and plugins..."
cp ~/Kali-Setup/tmux/.tmux.conf ~/
mkdir ~/.tmux
mkdir ~/.tmux/plugins
cp -r ~/Kali-Setup/tmux/tpm ~/.tmux/plugins/
cp -r ~/Kali-Setup/tmux/tmux-battery ~/.tmux/plugins/
cp -r ~/Kali-Setup/tmux/tmux-cpu ~/.tmux/plugins/
cp -r ~/Kali-Setup/tmux/tmux-yank ~/.tmux/plugins/
echo -e "Copying fonts..."
sudo mkdir /usr/share/fonts/truetype/MesloLGS
sudo cp ~/Kali-Setup/Fonts/*.ttf /usr/share/fonts/truetype/MesloLGS/
echo -e "Copying fusuma config..."
cp -r ~/Kali-Setup/fusuma/config.yml ~/.config/fusuma/

echo -e "Setting Wallapaper..."
sudo wget -O /usr/share/backgrounds/th4ntis.png https://raw.githubusercontent.com/th4ntis/Kali-Setup/main/images/CyberSpider-UG-Outline.png
WALLPAPER_PATH="/usr/share/backgrounds/th4ntis.png"
# PLASMA_CONFIG_DIR="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

# Check if the provided file exists
if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "File not found!"
    exit 1
fi

# Set the wallpaper using the provided PNG file
wallpaper_path=$(realpath "$WALLPAPER_PATH")
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
var Desktops = desktops();
for (i=0; i<Desktops.length; i++) {
    d = Desktops[i];
    d.wallpaperPlugin = 'org.kde.image';
    d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
    d.writeConfig('Image', 'file://$wallpaper_path')
    d.writeConfig('FillMode', 6);  // 6 is for 'Center'
}
"
echo -e "$green Complete"

echo -e "\n$green Adding pipx path to .zshrc"
echo 'export PATH="$PATH:/home/th4ntis/.local/bin"' >> ~/.zshrc
echo 'export PATH="$PATH:/root/.local/bin"' >> ~/.zshrc
echo -e "$green Complete"

echo -e "\n$green All finished. Reboot for any/all changes to take affect $green\n"
