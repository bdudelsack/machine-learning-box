#!/bin/bash

#echo "Install pyenv"
touch ~/.bash_profile
grep -q -F "export PATH=\"/home/vagrant/.local/bin:\$PATH\"" ~/.bash_profile || echo "export PATH=\"/home/vagrant/.local/bin:\$PATH\"" >> ~/.bash_profile
source ~/.bash_profile

echo "Setup login directory"
echo "cd /home/vagrant/workspace/"  >> /home/vagrant/.bash_profile
echo "source ~/.bashrc"  >> /home/vagrant/.bash_profile

apm-beta install atom-ide-ui
apm-beta install ide-python