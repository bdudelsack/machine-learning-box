#!/bin/bash

echo "Install system requirements"
apt-get --quiet update
apt-get install -y --no-install-recommends \
	curl \
	git \
	lightdm lightdm-settings ubuntu-mate-core ubuntu-mate-desktop ubuntu-mate-lightdm-theme mate-menu mate-desktop-environment-extras ubuntu-mate-default-settings mate-applet-brisk-menu \
	hunspell-de-de \
	language-pack-de language-pack-gnome-de virtualbox-guest-additions-iso python3-pip \
	virtualbox-guest-dkms

update-locale LANG=de_DE.UTF-8 LANGUAGE= LC_MESSAGES= LC_COLLATE= LC_CTYPE=

#echo "Install pyenv"
#curl -# -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

#mkdir /home/vagrant/workspace
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
systemctl daemon-reload
systemctl restart jupyter.service

mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /mnt
/mnt/VBoxLinuxAdditions.run
umount /mnt

snap install firefox --classic

update-alternatives --install /usr/bin/python python /usr/bin/python3 1
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

cat >/etc/default/keyboard <<EOL
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="de"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
EOL

cat >/usr/share/lightdm/lightdm.conf.d/01_autologin.conf <<EOL
[SeatDefaults]
autologin-user=vagrant
autologin-user-timeout=0
EOL

mkdir -p /home/vagrant/Schreibtisch/
cat >/home/vagrant/Schreibtisch/atom_atom.desktop <<EOL
[Desktop Entry]
X-SnapInstanceName=atom
Name=Atom
Comment=A hackable text editor for the 21st Century.
GenericName=Text Editor
Exec=env ATOM_DISABLE_SHELLING_OUT_FOR_ENVIRONMENT=false BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/atom_atom.desktop /snap/bin/atom /home/vagrant/workspace
Icon=/snap/atom/263/usr/share/pixmaps/atom.png
Type=Application
StartupNotify=true
Categories=GNOME;GTK;Utility;TextEditor;Development;
MimeType=text/plain;
StartupWMClass=atom
EOL

chown vagrant.vagrant /home/vagrant/Schreibtisch/atom_atom.desktop
chmod a+x /home/vagrant/Schreibtisch/atom_atom.desktop

cat <<EOF | dconf load /org/mate/desktop/peripherals/keyboard/
[kbd]
layouts=['de']
model=''
options=['grp_led\tgrp_led:scroll', 'grp\tgrp:ctrl_shift_toggle']
EOF

pip3 install -I python-language-server[all] tensorflow jupyter jupyter-console

wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list
apt-get update
apt-get install atom
