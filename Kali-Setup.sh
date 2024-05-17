#!/bin/bash
#
# Kali-Setup.sh  Author: Th4ntis
# git clone https://github.com/Th4ntis/Kali-Setup.git
#
# Standard Disclaimer: Author assumes no liability for any damage

# status indicators
greenplus='\e[1;33m[++]\e[0m'

setup() {
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y terminator neo4j bloodhound amass pipx libu2f-udev responder realtek-rtl88xxau-dkms dkms flameshot bridge-utils xfce4-dev-tools pkg-config golang-gir-gio-2.0-dev libgtk-3-dev libwnck-3-dev libxfce4ui-2-dev libxfce4panel-2.0-dev docker.io docker-compose golang-go gpsd gpsd-clients gpsd-tools
    cp ~/.zshrc .zshrc.bak
    chrome_install
    rockyou_unzip
    install_go
    bettercap_install
    hashcat-utils_install
    hcxdumptools_install
    hcxtools_install
    rtl8812au-drivers_install
    shodancli_install
    peass_install
    pcredz_install
    onedriveuserenum_install
    netexec_install
    donpapi_install
    nessus_install
    fonts_setup
    tmux_plugins_install
    gnmap_parser_install
    zsh_setup
    power_setup
    xfce_shortcuts
    finish
    }

chrome_install() {
    echo -e "\n $greenplus Installing Chrome"
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
    sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
    sudo rm -f /tmp/google-chrome-stable_current_amd64.deb
    echo -e "\n $greenplus Complete \n"
    }

rockyou_unzip() {
    echo -e "\n $greenplus Unzipping rockyou.txt"
    cd /usr/share/wordlists && sudo gzip -dqf /usr/share/wordlists/rockyou.txt.gz
    echo -e "\n $greenplus Complete \n"
    }

install_go() {
	echo -e "\n $greenplus Adding GO GOPATH to .zshrc"
	sleep 2
	echo 'export GOPATH="$HOME/.go"' >> ~/.zshrc
	echo 'export PATH="$PATH:${GOPATH//://bin:}/bin"' >> ~/.zshrc
	source ~/.zshrc
	mkdir -p ~/.go/{bin,pkg,src}
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

bettercap_install() {
	echo -e "\n $greenplus Installing Bettercap and Bettercap WebUI"
	sleep 2
	sudo apt install -y libnetfilter-queue-dev libusb-1.0-0-dev libpcap-dev
	go install github.com/bettercap/bettercap@latest
	sudo ~/.go/bin/bettercap -eval "caplets.update; ui.update; q"
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

hashcat-utils_install() {
	echo -e "\n $greenplus Installing Hashcat Utils"
	sleep 2
 	cd ~/Tools && git clone https://github.com/hashcat/hashcat-utils.git && cd hashcat-utils/src && sudo make && sudo cp *bin ../bin
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

hcxdumptools_install() {
	echo -e "\n $greenplus Installing HCXDumpTool"
	sleep 2
	cd ~/Tools && git clone https://github.com/ZerBea/hcxdumptool && cd hcxdumptool && sudo make && sudo make install
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

hcxtools_install() {
	echo -e "\n $greenplus Installing HCXTools"
	sleep 2
	sudo apt install -y libcurl4-openssl-dev libssl-dev zlib1g-dev
 	cd ~/Tools && git clone https://github.com/ZerBea/hcxtools.git && cd hcxtools && sudo make && sudo make install
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

rtl8812au-drivers_install() {
	echo -e "\n $greenplus Installing RTL8812AU Drivers"
	sleep 2
	cd ~/Tools && git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git && cd rtl8812au && sudo make && sudo make install
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

 shodancli_install() {
	echo -e "\n $greenplus Installing ShodanCLI"
	sleep 2
	python3 -m pipx install shodan
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

 peass_install() {
	echo -e "\n $greenplus Installing PEASS"
	sleep 2
	cd ~/Tools && git clone https://github.com/carlospolop/PEASS-ng.git
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

 
pcredz_install() {
	echo -e "\n $greenplus Installing PCredz"
	sleep 2
	cd ~/Tools && git clone https://github.com/lgandx/PCredz.git
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

 install_onedriveuseremum() {
	echo -e "\n $greenplus Installing OneDriveUser Enum"
	sleep 2
	cd ~/Tools && git clone https://github.com/nyxgeek/onedrive_user_enum.git
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

 netexec_install() {
	echo -e "\n $greenplus Installing NetExec"
	sleep 2
	python3 -m pipx install git+https://github.com/Pennyw0rth/NetExec
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

 donpapi_install() {
	echo -e "\n $greenplus Installing DonPAPI"
	sleep 2
	python3 -m pipx install donpapi
	echo -e "\n $greenplus Complete \n"
	sleep 2
	}

nessus_install() {
    echo -e "\n $greenplus Installing Nessus"
    nessus_amd64_file=$(curl https://www.tenable.com/downloads/nessus\?loginAttempted\=true | grep -o -m1 -E "Nessus-[0-9]{1,2}.[0-9]{1}.[0-9]{1}-debian10_amd64.deb" | grep -m1 -i ".deb")
    nessus_amd64="https://www.tenable.com/downloads/api/v2/pages/nessus/files/$nessus_amd64_file"
    sudo wget -q $nessus_amd64 -O /tmp/nessus_amd64.deb
    sudo dpkg -i /tmp/nessus_amd64.deb
    sudo rm -f /tmp/nessus_amd64.deb
    echo -e "\n $greenplus Complete \n"
    }

fonts_setup() {
    echo -e "\n $greenplus Setting up fonts for terminator"
    sudo mkdir /usr/share/fonts/truetype/MesloLGS
    cd ~/$USER
    wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    sudo mv *.ttf /usr/share/fonts/truetype/MesloLGS/
    echo -e "\n $greenplus Complete \n"
    }

tmux_plugins_install() {
    echo -e "\n $greenplus Installing TMUX Plugins"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tmux-battery ~/.tmux/plugins/tmux-battery
    git clone https://github.com/tmux-plugins/tmux-cpu ~/.tmux/plugins/tmux-cpu
    git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank
    echo -e "\n $greenplus Complete \n"
    }

gnmap_parser_install() {
    echo -e "\n $greenplus Installing gnmap parser"
    git clone https://github.com/jasonjfrank/gnmap-parser.git
    echo -e "\n $greenplus Complete \n"
    }

zsh_setup() {
    echo -e "\n $greenplus Setting up ZSH"
    git clone https://github.com/Th4ntis/dotfiles.git ~/dotfiles
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
    cp ~/dotfiles/zsh/.zshrc ~/
    sudo cp ~/dotfiles/zsh/.zshrc /root/
    cp ~/dotfiles/tmux/.tmux.conf ~/
    sudo cp ~/dotfiles/tmux/.tmux.conf /root/
    mkdir ~/.config/terminator
    sudo mkdir /root/.config/terminator
    cp ~/dotfiles/terminator/config ~/.config/terminator/
    sudo cp ~/dotfiles/terminator/config /root/.config/terminator/
    echo -e "\n $greenplus Complete \n"
    }

power_setup() {
    echo -e "\n $greenplus Changing Power Settings"
    wget -q https://raw.githubusercontent.com/Dewalt-arch/pimpmyi3-config/main/xfce4/xfce4-power-manager.xml -O /home/$USER/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
    echo -e "\n $greenplus Complete \n"
    }

xfce_shortcuts() {
    echo -e "\n $greenplus Setting up XFCE Shortcuts"
    wget -q https://github.com/Th4ntis/Kali-Setup/blob/main/xfce-shortcuts.xml -O ~/xfce-shortcuts.xml
    mv ~/xfce-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
    echo -e "\n $greenplus Complete \n"
    }

finish() {
    echo -e "\n $greenplus Finishing Up"
    sudo apt autoremove -y
    sudo rm -r ~/dontfiles
    pipx ensurepath
    sudo pipx ensurepath
    clear && echo -e "\n $greenplus Complete \n"
    }

setup
