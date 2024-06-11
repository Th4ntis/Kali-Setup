#!/bin/zsh
#
# Kali-Setup.sh  Author: Th4ntis
# git clone https://github.com/Th4ntis/Kali-Setup.git
#
# Standard Disclaimer: Author assumes no liability for any damage

# status indicators
green='\e[1;33m[+]\e[0m'

clear

echo -e "\n$green Running apt update..."
sudo apt-get update
echo -e "$green Complete"

echo -e "\n$green Running apt upgrade..."
sudo apt-get -y -qq upgrade
echo -e "$green Complete"

echo -e "\n$green Installing tools via apt-get..."
sleep 3
sudo apt install -y -qq terminator neo4j bloodhound amass pipx netexec libu2f-udev xclip realtek-rtl88xxau-dkms dkms libcurl4-openssl-dev libssl-dev zlib1g-dev libnetfilter-queue-dev libusb-1.0-0-dev libpcap-dev flameshot bridge-utils xfce4-dev-tools pkg-config golang-gir-gio-2.0-dev libgtk-3-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev docker.io docker-compose golang-go gpsd gpsd-clients gpsd-tools
echo -e "$green Complete"

echo -e "\n$green Making tools folder under ~/Tools"
sleep 3
mkdir ~/Tools

echo -e "\n$green Copying .zshrc to .zshrc.bak"
cp ~/.zshrc .zshrc.bak

echo -e "\n$green Getting config/dot files..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k > /dev/null

# git clone --quiet https://github.com/Th4ntis/Kali-Setup.git ~/Kali-Setup > /dev/null
echo -e "Copying zshrc..."
cp ~/Kali-Setup/zsh/zshrc ~/.zshrc
echo -e "Copying aliases..."
cp ~/Kali-Setup/zsh/aliases ~/.aliases
echo -e "Copying terminator config..."
mkdir ~/.config/terminator
cp ~/Kali-Setup/terminator/config ~/.config/terminator/config
echo -e "Copying tmux files and plugins..."
cp ~/Kali-Setup/tmux/tmux.conf ~/.tmux.conf
mkdir ~/.tmux
mkdir ~/.tmux/plugins
cp -r ~/Kali-Setup/tmux/tpm ~/.tmux/plugins/
cp -r ~/Kali-Setup/tmux/tmux-battery ~/.tmux/plugins/
cp -r ~/Kali-Setup/tmux/tmux-cpu ~/.tmux/plugins/
cp -r ~/Kali-Setup/tmux/tmux-yank ~/.tmux/plugins/
echo -e "Copying fonts..."
sudo mkdir /usr/share/fonts/truetype/MesloLGS
sudo cp ~/Kali-Setup/fonts/* /usr/share/fonts/truetype/MesloLGS/
echo -e "Copying fusuma config..."
mkdir ~/.config/fusuma
cp -r ~/Kali-Setup/fusuma/config.yml ~/.config/fusuma/

echo -e "Setting Wallapaper..."
sudo wget -q -O /usr/share/backgrounds/th4ntis.png https://raw.githubusercontent.com/th4ntis/Kali-Setup/main/images/CyberSpider-UG-Outline.png
for i in $(xfconf-query -c xfce4-desktop -lv | grep last-image | awk '{print $1}'); do xfconf-query -c xfce4-desktop -p $i -s /usr/share/backgrounds/th4ntis.png; done
for i in $(xfconf-query -c xfce4-desktop -lv | grep image-style | awk '{print $1}'); do xfconf-query -c xfce4-desktop -p $i -s 4; done

echo -e "Setting LightDM Greeting settings..."
sudo wget -q -O /usr/share/backgrounds/kali-linux.png https://raw.githubusercontent.com/th4ntis/Kali-Setup/main/images/Kali-Linux.png
sudo sed -i 's|/usr/share/desktop-base/kali-theme/login/background|/usr/share/backgrounds/kali-linux.png|g' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i 's|theme-name = Kali-Light|theme-name = Kali-Dark|g' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i 's|font-name = Cantarell 11|font-name = Hack 11|g' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i 's|icon-theme-name = Flat-Remix-Blue-Light|icon-theme-name = Flat-Remix-Blue-Dark|g' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i 's|default-user-image = #emblem-kali|default-user-image = /usr/share/backgrounds/th4ntis.png|g' /etc/lightdm/lightdm-gtk-greeter.conf

sudo sed -i 's|GRUB_TIMEOUT=5|GRUB_TIMEOUT=0|g' /etc/lightdm/lightdm-gtk-greeter.conf

echo -e "\n$green adding GOPATH to .zshrc"
echo '# GO Path' >> ~/.zshrc
echo 'export GOPATH="$HOME/.go"' >> ~/.zshrc
echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.zshrc
mkdir -p ~/.go/{bin,pkg,src}
echo -e "$green Complete"

echo -e "\n$green Adding pipx path to .zshrc"
echo '# PIPX Path' >> ~/.zshrc
echo 'export PATH="$PATH:/home/th4ntis/.local/bin"' >> ~/.zshrc
echo 'export PATH="$PATH:/root/.local/bin"' >> ~/.zshrc
echo -e "$green Complete"

source ~/.zshrc

echo -e "\n$green Installing Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Chrome.deb
sudo dpkg -i ~/Chrome.deb;sudo apt install -y -f 2> /dev/null
sudo rm -r ~/Chrome.deb
echo -e "$green Complete"

echo -e "\n$green Unzipping rockyou.txt"
cd /usr/share/wordlists && sudo gzip -dqf /usr/share/wordlists/rockyou.txt.gz

echo -e "\n$green Getting Responder as backup to installed Responder in directory ~/Tools/"
git clone --quiet https://github.com/lgandx/Responder.git ~/Tools/Responder > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting Impacket as backup to installed Ipacket in directory ~/Tools/"
git clone --quiet https://github.com/fortra/impacket.git ~/Tools/Impacket > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting PEASS in directory ~/Tools/"
git clone --quiet https://github.com/carlospolop/PEASS-ng.git ~/Tools/PEASS-ng > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting PCredz in directory ~/Tools/"
git clone --quiet https://github.com/lgandx/PCredz.git ~/Tools/PCredz > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting OneDriveUser Enum in directory ~/Tools/"
git clone --quiet https://github.com/nyxgeek/onedrive_user_enum.git ~/Tools/OneDrive_User_Enum > /dev/null
echo -e "$green Complete"

echo -e "\n$green Getting gnmap parser in directory ~/Tools/"
git clone --quiet https://github.com/jasonjfrank/gnmap-parser.git ~/Tools/gnmap-parser > /dev/null
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

echo -e "\n$green Installing ShodanCLI"
pipx install shodan
sudo pipx install shodan
echo -e "$green Complete"

echo -e "\n$green Installing DonPAPI"
pipx install donpapi
sudo pipx install donpapi
echo -e "$green Complete"

echo -e "\n$green Installing Nessus"
nessus_amd64_file=$(curl https://www.tenable.com/downloads/nessus\?loginAttempted\=true | grep -o -m1 -E "Nessus-[0-9]{1,2}.[0-9]{1}.[0-9]{1}-debian10_amd64.deb" | grep -m1 -i ".deb")
nessus_amd64="https://www.tenable.com/downloads/api/v2/pages/nessus/files/$nessus_amd64_file"
sudo wget -q $nessus_amd64 -O /tmp/nessus_amd64.deb
sudo dpkg -i /tmp/nessus_amd64.deb
sudo rm -f /tmp/nessus_amd64.deb
echo -e "$green Complete"

echo -e "\n$green Changing Power Settings"
wget -q https://raw.githubusercontent.com/th4ntis/Kali-Setup/xfce4-power-manager.xml -O /home/$USER/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
echo -e "$green Complete"

echo -e "\n$green Changing XFCE Shotcuts"
wget -q https://raw.githubusercontent.com/th4ntis/Kali-Setup/xfce-shortcuts.xml -O /home/$USER/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
echo -e "$green Complete"

echo -e "\n$green Installing XRDP and ZORG for RDP"
sudo apt install -y -qq xrdp xorg

echo -e "\n$green Changing RDP Port to 3390"
sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini

echo -e "\n$green ===== All finished! Reboot for any/all changes to take affect ===== $green\n"
