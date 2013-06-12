# -*- mode: ruby -*-
# vi: set ft=ruby :
#
require 'vagrant-rackspace'

Vagrant.configure("2") do |config|
#Vagrant::Config.run do |config|
  config.vm.hostname = 'mynode.clouddb.rackspace.net'
  config.vm.box = "dummy"
  config.vm.provision :shell, :path => "bootstrap.sh"
  config.ssh.private_key_path = "~/.ssh/id_rsa"
#  config.vm.synced_folder "src/", "/srv/website"
  config.vm.provider :rackspace do |os|
    os.username = "erikthered"
    os.api_key = "4a1dc2607d8b52ef9d37d8d0f43a3dc0"
    os.flavor = /4GB/
    os.image = /Ubuntu 12.04/ 
    #os.keypair_name = ""
    os.server_name = "mynode"
    os.public_key_path = "~/.ssh/id_rsa.pub"
    os.tenant = "706010"
  end
end
