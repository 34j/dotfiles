#!/bin/bash
echo "Installing GitHub CLI..."
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

echo "Installing Python..."
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install python3.11-full python3.12-full python3.13-full -y

echo "Installing TA-Lib..."
sudo apt install build-essential -y
wget -N http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib-0.4.0-src.tar.gz
cd ta-lib/
sudo ./configure
sudo make
sudo make install

echo "Installing Git..."
sudo apt install git-all -y

echo "Installing Google Chrome..."
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo apt install /tmp/google-chrome-stable_current_amd64.deb -y

echo "Installing ChromeDriver..."
version=$(curl -s "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_STABLE")
echo "Installing ChromeDriver for version $version"
wget -N https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${version}/linux64/chromedriver-linux64.zip -O /tmp/chromedriver-linux64.zip
sudo unzip -oj /tmp/chromedriver-linux64.zip -d /usr/bin

echo "Installing snapd..."
sudo apt install snapd -y

echo "Installing snap packages..."
sudo snap install discord slack chromium thunderbird firefox anki-woodrow
sudo snap install --classic code
sudo snap install --beta lutris

echo "Installing flatpak..."
sudo apt install flatpak gnome-software-plugin-flatpak -y

echo "Please restart the session to enable flatpak support."
gnome-terminal & disown

echo "Installing flatpak packages..."
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub chat.schildi.desktop -y
sudo flatpak install flathub com.github.debauchee.barrier -y
sudo flatpak install flathub com.vysp3r.ProtonPlus -y
sudo flatpak install flathub com.github.hluk.copyq -y

echo "Installing VS Code..."
# https://gitlab.com/yoshiyasu1111/install_vscode/-/blob/master/install_VSCode.sh?ref_type=heads
sudo apt install -y curl apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# echo "Installing wine..."
# sudo apt install wine winetricks -y
# wget -N https://github.com/PietJankbal/Chocolatey-for-wine/releases/download/v0.5a.745/Chocolatey-for-wine.7z -O /tmp/Chocolatey-for-wine.7z
# 7z x /tmp/Chocolatey-for-wine.7z -o/tmp/
# wine /tmp/Chocolatey-for-wine/ChoCinstaller_0.5a.745.exe
# winetricks -q dotnet40 gdiplus corefonts cjkfonts

echo "Installing proton pass..."
wget -N https://proton.me/download/PassDesktop/linux/x64/ProtonPass.deb -O /tmp/ProtonPass.deb
sudo  apt install /tmp/ProtonPass.deb -y
rm /tmp/ProtonPass.deb

echo "Installing Steam..."
sudo add-apt-repository multiverse -y
sudo apt update
sudo apt install steam -y

echo "Setting up desktop background..."
mkdir -p ~/ # support non-english locales
wget -N https://onimai.jp/special/img/endcard_03.jpg -P ~/Pictures/
xfconf-query --channel xfce4-desktop --list | grep last-image | xargs xfconf-query -c xfce4-desktop -s ~/Pictures/endcard_03.jpg -p

echo "Dark mode..."
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "Installing diodon..."
sudo apt install diodon -y
echo "Please manually set the shortcut for diodon in "settings/keyboard/keyboard shortcut/custom shortcut".

# this conflicts with cinnamon
# echo "Installing xbindkeys..."
# sudo apt install xbindkeys -yv
# xbindkeys --defaults > ~/.xbindkeysrcv
# echo '"/usr/bin/diodon" ' >> ~/.xbindkeysrc
# echo "  Mod4 + v" >> ~/.xbindkeysrc
# echo '"gnome-terminal" ' >> ~/.xbindkeysrc
# echo "  shift+F12 " >> ~/.xbindkeysrc

echo "Logging in to GitHub..."vvvvv
gh auth login --web
