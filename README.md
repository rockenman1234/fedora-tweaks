# WARNING: MUST ONLY BE USED ON FRESH FEDORA INSTALL WITH INTERNET ACCESS!!!

This script enables special tweaks to make fedora more usable, run at your own risk! 

Tweaks included are: DNF speed up, installs RPM Fusion  (free and non-free), installs gnome-tweaks, fedy, TLP, steam, vlc, support for various multimedia codecs and compression support, snap, better_fonts. It is broken up in the way it is for easy tweaking and fixing for future fedora versions. More to come in the future!

About this script:
This is a script that I made to help fedora run better with as little user tweaking as possible. I made this script because I found hundreds of articles about what to do after installing fedora but none of them got me to 100%, so I made this script to solve that!


# Installation Procedure:
(Note: must be run in bash or other SH compatible shell! If you dont know what that means your probably already in bash.)

git clone https://github.com/rockenman1234/fedora-tweaks.git

cd /home/*INSERT YOUR USERNAME*/fedora-tweaks

chmod 775 Fedora-tweaks.sh

sudo ./Fedora-tweaks.sh
