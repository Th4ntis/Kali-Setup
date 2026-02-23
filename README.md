# Kali Setup
Disclaimer: I did NOT create or develop any of these tools

This is still a work in a progress as I am adding additional tools and updating the script as I got. Any constructive criticism welcome or any other tool suggestions are welcome as well. This is a script to setup a fresh install of [Kali Linux](https://www.kali.org/). This will setup some keyboard shortcuts I use, power settings, etc.

# Running
```
git clone --quiet https://github.com/Th4ntis/Kali-Setup.git ~/Kali-Setup > /dev/null
chmod +x Kali-Setup.sh
./Kali-Setup.sh
```

## Description
* `Kali-Setup.sh`
  * Adds GO Path and pipx path to .zshrc
  * Installs Bettercap via GO
  * Installs NetExec, ShodanCli, and DonPapi via pipx
  * Add users to the vboxusers group
  * Installs the following tools/dependencies/drivers via apt:
    * terminator
    * neo4j
    * bloodhound
    * bloodhound.py
    * amass
    * pipx
    * git
    * xclip
    * realtek-rtl88xxau-dkms
    * dkms
    * libcurl4-openssl-dev
    * libssl-dev
    * zlib1g-dev
    * libnetfilter-queue-dev
    * libusb-1.0-0-dev
    * libpcap-dev
    * flameshot
    * bridge-utils
    * xfce4-dev-tools
    * pkg-config
    * golang-gir-gio-2.0-dev
    * libgtk-3-dev
    * libwnck-3-dev
    * libxfce4ui-2-dev
    * libxfce4panel-2.0-dev
    * docker.io
    * docker-compose
    * golang-go
    * gpsd
    * gpsd-clients
    * gpsd-tools
    * xorg
    * xrdp
    * autorecon
  * Grabs the following tools and put them into `~/Tools/` as well as installs some to system:
    * [PEASS-ng](https://github.com/peass-ng/PEASS-ng)
    * [PCredz](https://github.com/lgandx/PCredz)
    * [OneDrive_User_Enum](https://github.com/nyxgeek/onedrive_user_enum)
    * GNmap Parser
    * [Google Chrome](https://www.google.com/chrome/)
    * [Nessus](https://www.tenable.com/products/nessus)
    * [HCXDumpTool](https://github.com/ZerBea/hcxdumptool)
    * [HCXTools](https://github.com/ZerBea/hcxtools)
    * [Hashcat Utilities](https://github.com/hashcat/hashcat-utils)
 
You can start/enable SSH and RDP for remore access with:
```
sudo systemctl start ssh
```
```
sudo systemctl enable ssh
```
```
sudo systemctl start xrdp
```
```
sudo systemctl enable xrdp
```
