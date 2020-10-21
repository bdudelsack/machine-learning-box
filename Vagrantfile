# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Plugins
  config.vagrant.plugins = "vagrant-reload"

  # Config
  config.vm.box = "ubuntu/groovy64"
  config.vm.hostname = "machine-learning-box"

  config.vm.provider "virtualbox" do |vbox|
    vbox.memory = "4096"
    vbox.gui = true
    vbox.customize ['modifyvm', :id, '--vram', '64']
  end

  # Port forwarding
  config.vm.network "forwarded_port", guest: 8888, host: 8888

  # Synced folder
  config.vm.synced_folder "workspace/", "/home/vagrant/workspace", owner: "vagrant", group: "vagrant"

  # Provisioning
  config.vm.provision :shell, path: "scripts/provision-vagrant.sh"
  config.vm.provision :shell, path: "scripts/provision-vagrant-user.sh", privileged: false

  config.vm.provision :reload
end
