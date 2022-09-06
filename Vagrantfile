# -*- mode: ruby -*-
# vi: set ft=ruby :

# Env section --------------------------------------------------------

OAM_NETWORK_PREFIX = "192.168.88."  # Operation and Maintenance (OAM) network
FIP_NETWORK_PREFIX = "192.168.11."  # FloatingIP network

MAAS_IP = OAM_NETWORK_PREFIX + "2"

# Operations and Management (OAM) network MAAS DHCP range
OAM_DYNAMIC_RANGE_START = OAM_NETWORK_PREFIX + "200"
OAM_DYNAMIC_RANGE_END   = OAM_NETWORK_PREFIX + "254"

# OAM network reserved range (for gateway and MAAS)
OAM_RESERVED_RANGE_START = OAM_NETWORK_PREFIX + "1"
OAM_RESERVED_RANGE_END   = OAM_NETWORK_PREFIX + "9"

# Cloud Nodes
CLOUD_NODES_COUNT = 0
CLOUD_NODE_CPUS   = 4
CLOUD_NODE_MEMORY = 2048

# Env section -------------------------------------------------
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'
ENV['VAGRANT_NO_PARALLEL'] = 'yes'


Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "~/.ssh/id_rsa"
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"

  # MAAS Server
  config.vm.define "maas", primary: true do |maas|
    maas.vm.box = "generic/ubuntu2004"
    maas.vm.hostname = "maas"

    maas.vm.provider :libvirt do |domain|
      domain.default_prefix = ""
      domain.cpus = "4"
      domain.memory = "2048"
    end

    # maas.vm.network "public_network", 
    #   :dev => "enp0s20f0u2u4", 
    #   :mode => 'bridge', 
    #   :ip => MAAS_IP

    maas.vm.provision "ansible" do |ansible|
      ansible.playbook = "main.yml"
      ansible.verbose = "vvv"
    end

  end
end