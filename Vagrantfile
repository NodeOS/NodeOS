# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
#    v.cpus = `getconf _NPROCESSORS_ONLN`.to_i / 2 + 1
    v.memory = 3072
  end

  config.vm.provision "shell", path: "bin/install-dependencies"
end
