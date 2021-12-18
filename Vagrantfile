Vagrant.configure("2") do |config|
  config.vm.box = "generic/alpine315"
  config.vm.version = "3.6.2"

  config.vm.define "alpine"
  config.vm.provider "virtualbox" do |v|
    v.gui = true
  end
end
