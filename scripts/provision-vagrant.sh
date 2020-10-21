#!/bin/bash

echo "Install system requirements"

#wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
#echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list
#
#curl -sL https://deb.nodesource.com/setup_14.x -o - | bash

apt-get --quiet update
apt-get install -y --no-install-recommends \
	curl \
	git \
	lightdm lightdm-settings ubuntu-mate-core ubuntu-mate-desktop ubuntu-mate-lightdm-theme mate-menu mate-desktop-environment-extras ubuntu-mate-default-settings mate-applet-brisk-menu \
	virtualbox-guest-additions-iso \
	hunspell-de-de \
	build-essential module-assistant gcc make perl dkms \
	language-pack-de language-pack-gnome-de python3-pip

update-locale LANG=de_DE.UTF-8 LANGUAGE= LC_MESSAGES= LC_COLLATE= LC_CTYPE=

cat >/etc/default/keyboard <<EOL
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="de"
XKBVARIANT="nodeadkeys"
XKBOPTIONS=""

BACKSPACE="guess"
EOL

mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /mnt
/mnt/VBoxLinuxAdditions.run
umount /mnt

update-initramfs -u

chown vagrant.vagrant /home/vagrant/workspace

echo "Setup Jupyter auto start"
cat >/etc/systemd/system/jupyter.service <<EOL
[Unit]
Description=Jupyter Workspace

[Service]
Type=simple
PIDFile=/run/jupyter.pid
ExecStart=/usr/local/bin/jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --NotebookApp.token= --notebook-dir=/home/vagrant/workspace
User=vagrant
Group=vagrant
WorkingDirectory=/home/vagrant/workspace
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOL

systemctl enable jupyter.service

wget "https://atom.io/download/deb?channel=beta" -O /tmp/atom.deb
dpkg --ignore-depends=gvfs-bin -i /tmp/atom.deb

snap install firefox --classic

update-alternatives --install /usr/bin/python python /usr/bin/python3 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

cat >/usr/share/lightdm/lightdm.conf.d/01_autologin.conf <<EOL
[Seat:*]
autologin-user=vagrant
autologin-user-timeout=0
EOL

mkdir -p /home/vagrant/Schreibtisch/
cat >/home/vagrant/Schreibtisch/atom.desktop <<EOL
[Desktop Entry]
Name=Atom
Comment=A hackable text editor for the 21st Century.
GenericName=Text Editor
Exec=env ATOM_DISABLE_SHELLING_OUT_FOR_ENVIRONMENT=false /usr/bin/atom-beta /home/vagrant/workspace
Icon=atom-beta
Type=Application
StartupNotify=true
Categories=GNOME;GTK;Utility;TextEditor;Development;
MimeType=text/plain;
StartupWMClass=atom
EOL

chown vagrant.vagrant /home/vagrant/Schreibtisch/*.desktop
chmod a+x /home/vagrant/Schreibtisch/*.desktop

pip3 install -I python-language-server[all] tensorflow jupyter jupyter-console keras

cp /usr/share/applications/mate-terminal.desktop /home/vagrant/Schreibtisch/
cp /var/lib/snapd/desktop/applications/firefox_firefox.desktop /home/vagrant/Schreibtisch/
