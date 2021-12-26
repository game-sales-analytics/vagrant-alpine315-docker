# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.box_check_update = true
  config.ssh.connect_timeout = 5
  config.ssh.shell = "/bin/sh -l"
  config.vm.boot_timeout = 120
  config.vm.box_download_checksum = true
  config.vm.box_download_checksum_type = "sha512"
  config.vm.box_url = "https://vagrantcloud.com/xeptore/alpine315-docker"
  config.vm.provider :virtualbox do |v, override|
    v.gui = false
    v.linked_clone = true
    v.check_guest_additions = false
  end
end
