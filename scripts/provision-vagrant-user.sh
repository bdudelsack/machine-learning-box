#!/bin/bash

#echo "Install pyenv"
touch ~/.bash_profile
grep -q -F "export PATH=\"/home/vagrant/.local/bin:\$PATH\"" ~/.bash_profile || echo "export PATH=\"/home/vagrant/.local/bin:\$PATH\"" >> ~/.bash_profile
source ~/.bash_profile

#grep -q -F "eval \"\$(pyenv init -)\"" ~/.bash_profile || echo "eval \"\$(pyenv init -)\"" >> ~/.bash_profile
#grep -q -F "eval \"\$(pyenv virtualenv-init -)\"" ~/.bash_profile || echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bash_profile
#curl -s -S -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
#source ~/.bash_profile
#
#echo "Install Python (Miniconda with Python 3)"
#pyenv install anaconda3-2020.02
#
#echo "Activate Python"
#cd /home/vagrant/workspace
#pyenv local anaconda3-2020.02

echo "Setup login directory"
echo "cd /home/vagrant/workspace/"  >> /home/vagrant/.bash_profile
echo "source ~/.bashrc"  >> /home/vagrant/.bash_profile

apm install atom-ide-ui
apm install ide-python
apm install terminal-plus