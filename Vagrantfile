# -*- mode: ruby -*-
# vi: set ft=ruby :

# Env section --------------------------------------------------------

OAM_NETWORK_PREFIX = "192.168.10."  # Operation and Maintenance (OAM) network
FIP_NETWORK_PREFIX = "192.168.11."  # FloatingIP network

MAAS_IP = OAM_NETWORK_PREFIX + "2"

# Operations and Management (OAM) network MAAS DHCP range
OAM_DYNAMIC_RANGE_START = OAM_NETWORK_PREFIX + "200"
OAM_DYNAMIC_RANGE_END   = OAM_NETWORK_PREFIX + "254"

# OAM network reserved range (for gateway and MAAS)
OAM_RESERVED_RANGE_START = OAM_NETWORK_PREFIX + "1"
OAM_RESERVED_RANGE_END   = OAM_NETWORK_PREFIX + "9"

# Cloud Nodes
CLOUD_NODES_COUNT = 1
CLOUD_NODE_CPUS   = 4 
CLOUD_NODE_MEMORY = 2048

# Env section -------------------------------------------------

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

    maas.vm.network "private_network", ip: MAAS_IP,
      :libvirt__netmask => "255.255.255.0",
      :libvirt__forward_mode => 'nat',
      :libvirt__network_name => 'OAM',
      :libvirt__dhcp_enabled => false,
      :dhcp_enabled => false,
      :autostart => true


    maas.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.verbose = "vvv"
    end

    maas.vm.post_up_message = 
      "Parabéns! O servidor MAAS foi instalado com sucesso e\n" \
      "provisionado. O comissionamento dos Cloud Nodes provavelmente está em\n" \
      "progredir agora.\n\n" \
      "Acesse a GUI do MAAS visitando " \
      "http://192.168.10.2:5240/MAAS\n" \
      "Username: root\nPassword: root"

  end

  # PXE nodes
  (1..CLOUD_NODES_COUNT).each do |i|
    config.vm.define "node-#{"%02d" % i}" do |node|
      node.vm.network :private_network, ip: OAM_NETWORK_PREFIX + "#{i+10}",
        :libvirt__forward_mode => 'nat',
        :libvirt__network_name => 'OAM',
        :libvirt__dhcp_enabled => false,
        :dhcp_enabled => false,
        :autostart => true,
        :mac => "0e00000000#{"%02d" % i}"

      node.vm.network :private_network, ip: FIP_NETWORK_PREFIX + "#{i+10}",
        :libvirt__netmask => "255.255.255.0",
        :libvirt__forward_mode => 'nat',
        :libvirt__network_name => 'FloatingIP',
        :libvirt__dhcp_enabled => false,
        :autostart => true

      node.vm.provider :libvirt do |domain|
        domain.default_prefix = ""
        domain.cpus = CLOUD_NODE_CPUS
        domain.memory = CLOUD_NODE_MEMORY
        domain.storage :file, :size => '16G', :bus => 'scsi'  # Operating System
        domain.storage :file, :size => '18G', :bus => 'scsi'  # Data disk (e.g. for Ceph OSD)
        boot_network = {'network' => 'OAM'}
        domain.boot boot_network
        domain.autostart = false
        domain.mgmt_attach = false
      end
    end
  end
end
