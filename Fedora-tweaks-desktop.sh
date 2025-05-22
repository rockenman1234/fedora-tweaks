#!/bin/bash

# Changelog (fedora compatibility was mostly maintained throughout 2022-2025, with occasional minor updates):
# 2020-25-10: Inital release
# 2022-19-5: Broke code into 2 scripts, one for laptop and one for desktop. 
# 2025-22-5: Refactored code to remove redundant calls and improve readability. Removed deltaRPM support as it was removed in Fedora 42.

KERNEL_VERSION=$(uname -r)

# WARNING: MUST ONLY BE USED ON FRESH FEDORA INSTALL WITH INTERNET ACCESS, AS ROOT!!! Run at your own risk! This script enables special tweaks to make fedora more usable. These tweaks include: DNF speed up, delta mirrors, installs RPM Fusion (free and non-free), installs gnome-tweaks, fedy, steam, vlc, support for various multimedia codecs and compression support, snap, better_fonts, wine-devel, fish shell, audacity, and chromium, better SSD support. It is broken up in the way it is for easy tweaking and fixing for future fedora versions. Made by Alex jenkins, follow me on github at https://github.com/rockenman1234 

echo '



'
echo '/ _|  ___  __| | ___  _ __ __ _  | |___      _____  __ _| | _____'
echo '| |_ / _ \/ _\ |/ _ \| |__/ _\ | | __\ \ /\ / / _ \/ _\ | |/ / __|'
echo '|  _|  __/ (_| | (_) | | | (_| | | |_ \ V  V /  __/ (_| |   <\__ \'
echo '|_|  \___|\__,_|\___/|_|  \__,_|  \__| \_/\_/ \___|\__,_|_|\_\___/'
echo 'WARNING: READ THE FOLLOWING VERY CAREFULLY! MUST ONLY BE USED ON FRESH FEDORA INSTALL WITH INTERNET ACCESS, AS ROOT!!! Run at your own risk! The process could take aslong as half an hour depending on your internet connection, but should only take 3-5 minutes with good internet connection. I cannot be held responsible for a bricked install, you have been warned!'

echo '



'

echo 'This is fully-autonomous script, please close and save all work before running this script!'

echo '



'

echo "Accepting the terms above, do you still wish to run? Type 1 or 2."
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo 'This script enables special tweaks to make fedora more usable. These tweaks include: DNF speed up, installs RPM Fusion (free and non-free), installs gnome-tweaks, fedy, steam, vlc, support for various multimedia codecs and compression support, snap, and better_fonts'

# These following lines speed up dnf
echo 'fastestmirror=true' >> /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf

# Update system and install necessary packages
sudo dnf update -y
sudo dnf upgrade --refresh -y
sudo dnf check-update -y
sudo dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    gnome-tweak-tool \
    fedy \
    steam \
    vlc \
    rpmfusion-free-release-tainted \
    libdvdcss \
    rpmfusion-nonfree-release-tainted \
    \*-firmware \
    p7zip p7zip-plugins \
    cabextract \
    snapd \
    fontconfig-enhanced-defaults fontconfig-font-replacements \
    winehq-devel \
    fish \
    audacity \
    chromium \
    dnf-plugin-system-upgrade -y

# Enable RPM Fusion repositories
sudo dnf groupupdate core
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y

# Install MSCore fonts
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Enable better_fonts repository
sudo dnf copr enable dawid/better_fonts -y

# Enable SSD trimmer
sudo systemctl enable --now fstrim.timer

# Update the rescue image
grub2-mkconfig -o /boot/grub2/grub.cfg

# Remove unnecessary packages
sudo dnf remove -y abrt*

# Ending messages and heads-up
echo '



'

echo 'The tweaks are done! Thanks for using my project! NOTICE: Please read if you have and NVIDIA card: https://rpmfusion.org/Howto/NVIDIA, this script cannot install nvidia drivers for you! Please either use this article (recommended), or use fedy to install the drivers you need!'

echo '



'

echo 'Follow me on github! https://github.com/rockenman1234'

echo '



'
    
echo 'It is imperative to reboot as soon as possible!!!'

# End of file
