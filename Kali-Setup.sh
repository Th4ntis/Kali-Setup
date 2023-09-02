#!/bin/bash
#
# Kali-Setup.sh  Author: Th4ntis
# git clone https://github.com/Th4ntis/Kali-Setup.git
#
# Standard Disclaimer: Author assumes no liability for any damage

setup() {
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y neo4j bloodhound amass libu2f-udev realtek-rtl88xxau-dkms dkms

    chrome_install
    rockyou_unzip
    seclists_install
    nessus_install
    fonts_setup
    tmux_plugins_install
    dotfile_setup
    zsh_setup
    finish
    }

chrome_install() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
    sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
    sudo rm -f /tmp/google-chrome-stable_current_amd64.deb
    }

rockyou_unzip() }
    cd /usr/share/wordlists && sudo gzip -dqf /usr/share/wordlists/rockyou.txt.gz
    }

seclists_install() {
    sudo wget https://github.com/danielmiessler/SecLists/archive/master.zip -O /tmp/SecList.zip
    sudo unzip -o /tmp/SecList.zip -d /usr/share/seclists
    sudo rm -f /tmp/SecList.zip
    }

nessus_install() {
    nessus_amd64_file=$(curl https://www.tenable.com/downloads/nessus\?loginAttempted\=true | grep -o -m1 -E "Nessus-[0-9]{1,2}.[0-9]{1}.[0-9]{1}-debian10_amd64.deb" | grep -m1 -i ".deb")
    nessus_amd64="https://www.tenable.com/downloads/api/v2/pages/nessus/files/$nessus_amd64_file"
    sudo wget -q $nessus_amd64 -O /tmp/nessus_amd64.deb
    sudo dpkg -i /tmp/nessus_amd64.deb
    sudo rm -f /tmp/nessus_amd64.deb
    }

fonts_setup() {
    sudo mkdir /usr/share/fonts/truetype/MesloLGS
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
    sudo mv *.ttf /usr/share/fonts/truetype/MesloLGS/
    }

tmux_plugins_install() {
    echo -e "\n Tmux Plugins \n"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tmux-battery ~/.tmux/plugins/tmux-battery
    git clone https://github.com/tmux-plugins/tmux-cpu ~/.tmux/plugins/tmux-cpu
    git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank
    echo -e "\n Tmux Plugins Complete \n"
    sleep 2
    }

dotfile_setup() {
    echo -e "\n Setting up DotFiles \n"
    git clone https://github.com/Th4ntis/dotfiles.git ~/dotfiles
    cp ~/dotfiles/zsh/.zshrc ~/
    cp ~/dotfiles/tmux/.tmux.conf ~/
    cp ~/dotfiles/terminator/config ~/.config/terminator/
    echo -e "\n DotFiles done \n"
    sleep 2
    }

zsh_setup() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
    cp ~/dotfiles/zsh/.zshrc ~/
    }

finish() {
    echo -e "All finished!\n"
    }

install
