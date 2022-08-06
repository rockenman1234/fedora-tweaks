# WARNING: MUST ONLY BE USED ON FRESH FEDORA INSTALL WITH INTERNET ACCESS!!!

This script enables special tweaks to make fedora more usable, run at your own risk!

I made this script because I found hundreds of articles about what to do after installing Fedora, but none of them got me to 100% - so I made this script to solve that!

This script includes two versions, desktop and laptop. Pick accordingly, laptop includes additional tweaking to the gnome subsystem that allows for more efficient use of the trackpad. Desktop does not include them, making for a slightly faster set up process.

# Desktop Version:

|Tweaks included | Description |
| ------------- | ------------- |
| DNF speed up | Sets fastest mirror to true, turns on delta RPM and sets parallel downloads to 10 |
| RPM Fusion |  Installs both free and non-free channels |
| Gnome-tweaks | Default desktop tweaking tool |
| Fedy | All in one configuration tool for Fedora | 
| Steam | Installs latest version from repositories | 
| VLC | An opensource all-in-one mutlimedia tool |
| Propriety multimedia codecs | Includes support for libdvdcss, and all compatible free and proprietry firmware drivers from DNF | 
| Better Compression support | Installs p7zip and all related program plugins | 
| Better_fonts| Installs MSCore fonts and Cabextract |
| Snap Support | Installs and enables support for snap packages | 
| Wine | Installs latest Wine-Developer from DNF |
| Fish | A user friendly shell for the 21st century | 
| Audacity | Open source audio-editing tool |
| Chromium | Pure open source version of google chrome |
| SSD Trimmer | Enables Systemd call for fstrim.timer |


## Unique to Laptop version: 

|Tweaks included | Description |
| ------------- | ------------- |
| Trackpad Tweaks  | Configures trackpoint for scrolling when combined with physical middle button, and enables tap-to-click on gnome-display-manager |
| TLP | Battery optomization software than runs in the background | 


### And more to come in the future!


# Installation Procedure:
***Must be run in bash or other SH compatible shell! If you dont know what that means, your probably already in bash.***

### Desktop Version

```
git clone https://github.com/rockenman1234/fedora-tweaks.git

cd ~/fedora-tweaks/

chmod +x Fedora-tweaks-desktop.sh

sudo ./Fedora-tweaks-desktop.sh
```

### Laptop Version

```
git clone https://github.com/rockenman1234/fedora-tweaks.git

cd ~/fedora-tweaks/

chmod +x Fedora-tweaks-laptop.sh

sudo ./Fedora-tweaks-laptop.sh
```
