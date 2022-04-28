#!/bin/bash

KERNEL_VERSION=$(uname -r)

# WARNING: MUST ONLY BE USED ON FRESH FEDORA INSTALL WITH INTERNET ACCESS, AS ROOT!!! Run at your own risk! This script enables special tweaks to make fedora more usable. These tweaks include: DNF speed up, delta mirrors, installs RPM Fusion  (free and non-free), installs gnome-tweaks, fedy, TLP, steam, vlc, support for various multimedia codecs and compression support, snap, better_fonts, wine-devel, fish shell, audacity, and chromium, better touchpad and ssd support. It is broken up in the way it is for easy tweaking and fixing for future fedora versions. Made by Alex jenkins, follow me on github at https://github.com/rockenman1234 

echo '



'
echo '
/ _| ___  __| | ___  _ __ __ _  | |___      _____  __ _| | _____ 
| |_ / _ \/ _` |/ _ \| '__/ _` | | __\ \ /\ / / _ \/ _` | |/ / __|
|  _|  __/ (_| | (_) | | | (_| | | |_ \ V  V /  __/ (_| |   <\__ \
|_|  \___|\__,_|\___/|_|  \__,_|  \__| \_/\_/ \___|\__,_|_|\_\___/'
echo 'WARNING: READ THE FOLLOWING VERY CAREFULLY! MUST ONLY BE USED ON FRESH FEDORA INSTALL WITH INTERNET ACCESS, AS ROOT!!! Run at your own risk! The process could take aslong as half an hour depending on your internet connection, but should only take 3-5 minutes with good internet connection. I cannot be held responsible for a bricked install, you have been warned!'

echo '



'

echo 'This is not a fully autonomous script, when installing RPM-Fusion repos, this script cannot accept the keys for you, you MUST type "y" When asked or the script will fail!!! Please close and save all work before running this script!'

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

sudo dnf update -y

# These next lines add RPM Fusion Free and Non-free repos
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
  
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

sudo dnf update -y

sudo dnf groupupdate core

# This line installs gnome-tweaks
sudo dnf install gnome-tweak-tool -y

# These line installs fedy
sudo dnf copr enable kwizart/fedy -y

sudo dnf install fedy -y

# This line updates the rescue image
/etc/kernel/postinst.d/51-dracut-rescue-postinst.sh ${KERNEL_VERSION} /boot/vmlinuz-${KERNEL_VERSION}

# These lines enable tap-to-click on GDM 
sudo su - gdm -s /bin/bash << EOF
export $(dbus-launch)

# These lines enable better touchpad support
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
    # Configure wheel emulation, using middle button and "natural scrolling".
    Option "EmulateWheel" "on"
    Option "EmulateWheelButton" "2"
    Option "EmulateWheelTimeout" "200"
    Option "EmulateWheelInertia" "7"
    Option "XAxisMapping" "7 6"
    Option "YAxisMapping" "5 4"
    # Set up an acceleration config ("mostly linear" profile, factor 5.5).
    Option "AccelerationProfile" "3"
    Option "AccelerationNumerator" "55"
    Option "AccelerationDenominator" "10"
    Option "ConstantDeceleration" "3"
EndSection
EOF
restorecon -F /etc/X11/xorg.conf.d/90-trackpoint.conf

# This line installs and enables TLP
sudo dnf install tlp tlp-rdw -y

sudo systemctl enable tlp

# This line installs steam
sudo dnf install steam -y

# This line installs vlc
sudo dnf install vlc -y

# These lines installs various multimedia codecs, some of which might already be installed
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y

sudo dnf groupupdate sound-and-video -y

sudo dnf install rpmfusion-free-release-tainted -y

sudo dnf install libdvdcss -y

sudo dnf install rpmfusion-nonfree-release-tainted -y

sudo dnf install \*-firmware -y

# This line installs support for compression algorithims 
sudo dnf install p7zip p7zip-plugins -y

# This line installs MSCore fonts and cabextract
sudo dnf install cabextract -y

rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# This line installs snap
sudo dnf install snapd -y

# These lines installs and enables better_fonts
sudo dnf copr enable dawid/better_fonts -y

sudo dnf install fontconfig-enhanced-defaults fontconfig-font-replacements -y

# This line installs OCS-URL
rpm -i https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1MzA3NzQ2ODAiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjZmNmQ4Y2E0MzNmZTY5OTY3ZmQ4NzZhMDUzZDlmNmM1NjAzOGNkODFkMjk2NzYzODNjMDdhNmVkNTJiN2U4NDAyMTgxNjRiYzJhNTkyY2E4M2Q0M2EyYzQyMGQwZmYyY2FhYWVkY2UxNjljODI0NzhjZWY1ZmViODg2NzVkYzFjIiwidCI6MTYwMTI2MDkxOCwic3RmcCI6IjEyMDM0NDQzYzE3YzI3NzljNzUxZWM2YzQ2NTA0NTQ4Iiwic3RpcCI6IjI2MDA6NmM1YTo2MzgwOjE5MzpmOTUwOjkyMzY6ZTA6NzM3NSJ9.K_cK1APNRJ39lpuoT3Cd1SRjeoNsOPjNyC75Uphy7Ak/ocs-url-3.1.0-1.x86_64.rpm

# These lines install wine
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/32/winehq.repo -y

sudo dnf install winehq-devel -y

# This line install fish shell
sudo dnf install fish -y

# This line installs audacity
sudo dnf install audacity -y

# This line installs chromium
sudo dnf install chromium -y

# These lines install dnf upgrade
sudo dnf update -y

sudo dnf upgrade --refresh -y

sudo dnf check-update -y

sudo dnf install dnf-plugin-system-upgrade -y

# Enable SSD trimmer
sudo systemctl enable --now fstrim.timer

# This line removes unnecessary packages
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
