require 'getoptlong'

opts = GetoptLong.new(
  ['--hostname', '-h', GetoptLong::REQUIRED_ARGUMENT],
  ['--ip', '-i', GetoptLong::REQUIRED_ARGUMENT]
)

hostname=''
ip=''
opts.each do |opt, arg|
  case opt
    when '--hostname'
      hostname=arg
    when '--ip'
      ip=arg
  end
end

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: ip
  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.hostname = hostname
  config.vm.provision "shell", path: "resources/puppet_server_provision.sh"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
  end
end
