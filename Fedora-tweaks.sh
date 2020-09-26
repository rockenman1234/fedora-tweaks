#!/bin/bash

# WARNING: MUST ONLY BE USED ON FRESH FEDORA 32 INSTALL WITH INTERNET ACCESS, AS ROOT!!! Run at your own risk! This script enables special tweaks to make fedora more usable. These tweaks include: DNF speed up, delta mirrors, installs RPM Fusion  (free and non-free), installs gnome-tweaks, fedy, TLP, steam, vlc, support for various multimedia codecs and compression support, snap, better_fonts, wine-devel, fish shell, audacity, and chromium. It is broken up in the way it is for easy tweaking and fixing for future fedora versions. Made by Alex jenkins, follow me on github at https://github.com/rockenman1234 

echo '



'

echo 'WARNING: READ THE FOLLOWING VERY CAREFULLY! MUST ONLY BE USED ON FRESH FEDORA 32 INSTALL WITH INTERNET ACCESS, AS ROOT!!! Run at your own risk! The process could take aslong as half an hour depending on your internet connection, but should only take 3-5 minutes with good internet connection. I cannot be held responsible for a bricked install, you have been warned!'

echo '



'

echo 'This is not a fully autonomous script, when installing RPM-Fusion repos, this script cannot accept the keys for you, you MUST TYPE "y" When asked or the script will fail!!! Please close and save all work before running this script!'

echo '



'

echo "Accepting the terms, do you still wish to run? Type 1 or 2."
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo 'This script enables special tweaks to make fedora more usable. These tweaks include: DNF speed up, installs RPM Fusion  (free and non-free), installs gnome-tweaks, fedy, TLP, steam, vlc, support for various multimedia codecs and compression support, snap, better_fonts'

# These following lines speed up dnf
echo 'fastestmirror=true' >> /etc/dnf/dnf.conf

echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf

echo 'deltarpm=true' >> /etc/dnf/dnf.conf

sudo dnf update -y

# These next lines add RPM Fusion Free and Non-free repos
sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  
sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf update -y

# This line installs gnome-tweaks
sudo dnf install gnome-tweak-tool -y

# These line installs fedy
sudo dnf copr enable kwizart/fedy -y

sudo dnf install fedy -y

# This line installs and enables TLP
sudo dnf install tlp tlp-rdw -y

sudo systemctl enable tlp

# This line installs steam
sudo dnf install steam -y

# This line installs vlc
sudo dnf install vlc -y

# This line installs various multimedia codecs, some of might already be installed
sudo dnf install gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-bad-free gstreamer1-plugins-bad-free-extras gstreamer1-plugins-good-extras libdvdread libdvdnav lsdvd -y

# This line installs support for compression algorithims 
sudo dnf install p7zip p7zip-plugins -y

# This line installs MSCore fonts and cabextract
sudo dnf install cabextract -y

rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# This lines installs snap
sudo dnf install snapd -y

# These line installs and enables better_fonts
sudo dnf copr enable dawid/better_fonts -y

sudo dnf install fontconfig-enhanced-defaults fontconfig-font-replacements -y

# This line install wine
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/32/winehq.repo -y

sudo dnf install winehq-devel -y

# This line install fish shell
sudo dnf install fish -y

# This line installs audacity
sudo dnf install audacity -y

# This line installs chromium
sudo dnf install chromium -y

# Ending messages and heads-up

echo '



'

echo 'The tweaks are done! Thanks for using my project! NOTICE: Please read if you have and NVIDIA card: https://rpmfusion.org/Howto/NVIDIA, this script cannot install nvidia drivers for you! Please either use this article (recomended), or use fedy to install the drivers you need!'

echo '



'

echo 'Follow me on github! https://github.com/rockenman1234'

echo '



'
	
echo 'It is imperative to reboot as soon as possible!!!'
