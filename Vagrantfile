# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Plugins
  config.vagrant.plugins = "vagrant-reload"

  # Config
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "machine-learning-box"

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.memory = "2048"
    v.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end

  # Port forwarding
  config.vm.network "forwarded_port", guest: 8888, host: 8888

  # Synced folder
  config.vm.synced_folder "workspace/", "/home/vagrant/workspace", owner: "vagrant", group: "vagrant"

  # Provisioning
  config.vm.provision :shell, path: "scripts/provision-vagrant.sh"
  config.vm.provision :shell, path: "scripts/provision-vagrant-user.sh", privileged: false

  config.vm.provision :reload

  # Welcome message
  # config.vm.post_up_message = "*****************************************\n\n" \
  #                             "    Welcome to your data science box!\n\n"  \
  #                             "    To access your Jupyter Notebook\n" \
  #                             "    point your browser to:\n\n" \
  #                             "        http://localhost:8888\n\n" \
  #                             "    Have fun!\n\n" \
  #                             "*****************************************"
end
