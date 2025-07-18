#!/bin/zsh
#
# Kali-Setup.sh  Author: Th4ntis
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
sudo apt install -y -qq terminator neo4j bloodhound bloodhound.py amass pipx netexec libu2f-udev xclip realtek-rtl88xxau-dkms dkms libcurl4-openssl-dev libssl-dev zlib1g-dev libnetfilter-queue-dev libusb-1.0-0-dev libpcap-dev flameshot bridge-utils xfce4-dev-tools pkg-config golang-gir-gio-2.0-dev libgtk-3-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev docker.io docker-compose golang-go gpsd gpsd-clients gpsd-tools virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11 xorg xrdp autorecon
echo -e "$green Complete"

echo -e "\n$green Adding usser $USER to vboxusers group for Virtualbox"
sudo adduser $USER vboxusers
echo -e "$green Complete"

echo -e "\n$green Setting up RDP over port 3389"
sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini
echo -e "$green Complete"

echo -e "\n$green Making tools folder under ~/Tools"
mkdir ~/Tools

echo -e "\n$green Copying .zshrc to .zshrc.bak"
cp ~/.zshrc .zshrc.bak

echo -e "\n$green Getting config/dot files..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k > /dev/null
#git clone --quiet https://github.com/Th4ntis/Kali-Setup.git ~/Kali-Setup > /dev/null

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
git clone https://github.com/tmux-plugins/tmux-battery ~/.tmux/plugins/tmux-battery > /dev/null
git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank > /dev/null

echo -e "\n$green Copying fonts..."
sudo mkdir /usr/share/fonts/truetype/MesloLGS
sudo cp ~/Kali-Setup/fonts/* /usr/share/fonts/truetype/MesloLGS/

echo -e "\n$green Setting Wallapaper..."
sudo wget -q -O /usr/share/backgrounds/th4ntis.png https://raw.githubusercontent.com/th4ntis/Kali-Setup/main/images/CyberSpider-UG-Outline.png
for i in $(xfconf-query -c xfce4-desktop -lv | grep last-image | awk '{print $1}'); do xfconf-query -c xfce4-desktop -p $i -s /usr/share/backgrounds/th4ntis.png; done
for i in $(xfconf-query -c xfce4-desktop -lv | grep image-style | awk '{print $1}'); do xfconf-query -c xfce4-desktop -p $i -s 4; done
for i in $(xfconf-query -c xfce4-desktop -lv | grep color-style | awk '{print $1}'); do xfconf-query -c xfce4-desktop -p $i -s 0; done
for i in $(xfconf-query -c xfce4-desktop -lv | grep rgba1 | awk '{print $1}'); do  xfconf-query -c xfce4-desktop -p $i -t double -s 0 -t double -s 0 -t double -s 0 -t double -s 1; done

ehco -e "\n$green Setting LightDM Greeting settings..."
sudo wget -q -O /usr/share/backgrounds/kali-linux.png https://raw.githubusercontent.com/th4ntis/Kali-Setup/main/images/Kali-Linux.png
sudo sed -i 's|/usr/share/desktop-base/kali-theme/login/background|/usr/share/backgrounds/kali-linux.png|g' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i 's|theme-name = Kali-Light|theme-name = Kali-Dark|g' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i 's|font-name = Cantarell 11|font-name = Hack 11|g' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i 's|icon-theme-name = Flat-Remix-Blue-Light|icon-theme-name = Flat-Remix-Blue-Dark|g' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i 's|default-user-image = #emblem-kali|default-user-image = /usr/share/backgrounds/th4ntis.png|g' /etc/lightdm/lightdm-gtk-greeter.conf

ehco -e "\n$green Changing laptop lid config..."
sudo sed -i 's|#HandleLidSwitch=suspend|HandleLidSwitch=ignore|g' /etc/systemd/logind.conf
sudo sed -i 's|#HandleLidSwitchDocked=suspend|HandleLidSwitchDocked=ignore|g' /etc/systemd/logind.conf
sudo systemctl restart systemd-logind

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
sudo pipx ensurepath
echo -e "$green Complete"

source ~/.zshrc

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

echo -e "\n$green Installing Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Chrome.deb
sudo dpkg -i ~/Chrome.deb;sudo apt install -y -f 2> /dev/null
sudo rm -r ~/Chrome.deb
echo -e "$green Complete"

echo -e "\n$green Installing ShodanCLI"
pipx install shodan
sudo pipx install shodan
echo -e "$green Complete"

echo -e "\n$green Installing DonPAPI"
pipx install donpapi
sudo pipx install donpapi
echo -e "$green Complete"

echo -e "\n$green Installing Joplin..."
wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
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

echo -e "\n$green Changing XFCE4 config"
cp -r ~/Kali-Setup/xfce4 ~/.config
chmod 755 ~/.config/xfce4
echo -e "$green Complete"

#echo -e "\n$green Unzipping rockyou.txt"
#cd /usr/share/wordlists && sudo gzip -dqf /usr/share/wordlists/rockyou.txt.gz

echo -e "\n$green ===== All finished! Reboot for any/all changes to take affect ===== $green\n"
