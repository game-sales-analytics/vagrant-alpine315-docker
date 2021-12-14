# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.define 'alpine315' do |alpine|
        alpine.vm.box = 'xeptore/alpine315-docker'
        alpine.vm.provider 'virtualbox' do |vb|
            vb.name = 'alpine315'
            vb.cpus = 4
            vb.memory = 4096
            vb.customize [
                'modifyvm', :id,
                '--natdnshostresolver1', 'on',
                '--nic1', 'nat',
                '--cableconnected1', 'on'
            ]
        end
    end
end
