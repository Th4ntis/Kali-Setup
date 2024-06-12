# Kali Setup
Disclaimer: I did NOT create or develop any of these tools

This is still a work in a progress as I am adding additional tools and updating the script as I got. Any constructive criticism welcome or any other tool suggestions are welcome as well. This is a script to setup a fresh install of [Kali Linux](https://www.kali.org/). This will setup some keyboard shortcuts I use, power settings, etc.

# Running
On phyhsical hardware:
```
git clone --quiet https://github.com/Th4ntis/Kali-Setup.git ~/Kali-Setup > /dev/null
chmod +x Kali-Setup.sh
./Kali-Setup.sh
```
On a VM:
```
git clone --quiet https://github.com/Th4ntis/Kali-Setup.git ~/Kali-Setup > /dev/null
chmod +x Kali-VM.sh
./Kali-VM.sh
```
## Description
* `Kali-Setup.sh` - Used when Kali is installed on my Thinkpad T480(but can be used on any hardware)
  * This will install tools/dependencies via apt
    * Then install Battercap via GO, and ShodanCLi and DonPapi via pipx
  * Add users to the vboxusers group
  * Enable RDP over port 3390
  * Setup my personal .files and configs (Oh-My-ZSH, tmux, terminator, aliases, wallpaper, etc.)
  * Disabled sleeping when the lid is closed
  * Adds GO Path and pipx path to .zshrc
  * Grabs the following tools from github: Responder, Impacket, PEASS, PCredz, OneDrive User Enum, GNmap Parser
  * Installs: [Google Chrome](https://www.google.com/chrome/), [Nessus](https://www.tenable.com/products/nessus), [Joplin](https://joplinapp.org/), [HCXDumpTool](https://github.com/ZerBea/hcxdumptool), [HCXTools](https://github.com/ZerBea/hcxtools), [Hashcat Utilities](https://github.com/hashcat/hashcat-utils)
  * Changes XFCE power settings, keyboard shortcuts, and panel items/options.
* `Kali-VM.sh` - Used when Kali is installed in a virtual machine.
  * This will install tools/dependencies via apt
  * Then install Battercap via GO, and ShodanCLi and DonPapi via pipx
  * Enable RDP over port 3390
  * Setup my personal .files and configs (Oh-My-ZSH, tmux, terminator, aliases, wallpaper, etc.)
  * Adds GO Path and pipx path to .zshrc
  * Grabs the following tools from github: Responder, Impacket, PEASS, PCredz, OneDrive User Enum, GNmap Parser
  * Installs: [Google Chrome](https://www.google.com/chrome/), [Nessus](https://www.tenable.com/products/nessus), [HCXDumpTool](https://github.com/ZerBea/hcxdumptool), [HCXTools](https://github.com/ZerBea/hcxtools), [Hashcat Utilities](https://github.com/hashcat/hashcat-utils)
  * Changes XFCE power settings, keyboard shortcuts, and panel items/options.
 
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
