#!/bin/bash

# See Fedora-tweaks-desktop.sh for changelog!

KERNEL_VERSION=$(uname -r)

# WARNING: MUST ONLY BE USED ON FRESH FEDORA INSTALL WITH INTERNET ACCESS, AS ROOT!!! Run at your own risk! This script enables special tweaks to make fedora more usable. These tweaks include: DNF speed up, delta mirrors, installs RPM Fusion  (free and non-free), installs gnome-tweaks, fedy, TLP, steam, vlc, support for various multimedia codecs and compression support, snap, better_fonts, wine-devel, fish shell, audacity, and chromium, better touchpad and ssd support. It is broken up in the way it is for easy tweaking and fixing for future fedora versions. Made by Alex jenkins, follow me on github at https://github.com/rockenman1234 

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

echo 'This script enables special tweaks to make fedora more usable. These tweaks include: DNF speed up, installs RPM Fusion  (free and non-free), installs gnome-tweaks, fedy, TLP, steam, vlc, support for various multimedia codecs and compression support, snap, better_fonts'

# These following lines speed up dnf
echo 'fastestmirror=true' >> /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf
echo 'deltarpm=true' >> /etc/dnf/dnf.conf

# Update system and install RPM Fusion Free and Non-free repos
sudo dnf update -y
sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core -y

# Install gnome-tweaks
sudo dnf install -y gnome-tweak-tool

# Install fedy
sudo dnf copr enable kwizart/fedy -y
sudo dnf install -y fedy

# Update the rescue image
grub2-mkconfig -o /boot/grub2/grub.cfg

# Enable tap-to-click on GDM and better touchpad support
sudo su - gdm -s /bin/bash << EOF
export $(dbus-launch)
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
gsettings set org.gnome.desktop.peripherals.touchpad edge-scrolling-enabled false
gsettings set org.gnome.desktop.peripherals.touchpad left-handed 'mouse'
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.5
gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
EOF

# Workaround for touchpad phantom tap-clicks
cat << EOF >/etc/udev/rules.d/90-psmouse.rules
ACTION=="add|change", SUBSYSTEM=="module", DEVPATH=="/module/psmouse", ATTR{parameters/synaptics_intertouch}="0"
EOF
restorecon -F /etc/udev/rules.d/90-psmouse.rules

# Configure trackpoint for scrolling when combined with physical middle button
cat << EOF >/etc/X11/xorg.conf.d/90-trackpoint.conf
Section "InputClass"
    Identifier "Trackpoint Scrolling"
    MatchProduct "TPPS/2 IBM TrackPoint"
    MatchDevicePath "/dev/input/event*"
    Option "EmulateWheel" "on"
    Option "EmulateWheelButton" "2"
    Option "EmulateWheelTimeout" "200"
    Option "EmulateWheelInertia" "7"
    Option "XAxisMapping" "7 6"
    Option "YAxisMapping" "5 4"
    Option "AccelerationProfile" "3"
    Option "AccelerationNumerator" "55"
    Option "AccelerationDenominator" "10"
    Option "ConstantDeceleration" "3"
EndSection
EOF
restorecon -F /etc/X11/xorg.conf.d/90-trackpoint.conf

# Install and enable TLP
sudo dnf install -y tlp tlp-rdw
sudo systemctl enable tlp

# Install various applications and codecs
sudo dnf install -y \
    steam \
    vlc \
    p7zip p7zip-plugins \
    cabextract \
    snapd \
    fontconfig-enhanced-defaults fontconfig-font-replacements \
    winehq-devel \
    fish \
    audacity \
    chromium \
    rpmfusion-free-release-tainted \
    rpmfusion-nonfree-release-tainted \
    libdvdcss \
    \*-firmware

# Install MSCore fonts
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Enable SSD trimmer
sudo systemctl enable --now fstrim.timer

# Remove unnecessary packages
sudo dnf remove -y abrt*

# Final system update and upgrade
sudo dnf update -y
sudo dnf upgrade --refresh -y
sudo dnf check-update -y
sudo dnf install -y dnf-plugin-system-upgrade

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