# -*- mode: ruby -*-
# vi: set ft=ruby :

# Configuration section --------------------------------------------------------

# Adjust it if you want to use different user, e.g. "ubuntu"
HOST_USERNAME = ENV["USER"]
# HOST_USERNAME = "ubuntu"

# Get the primary host IP. You can adjust it with a static value, 
# e.g. "192.168.1.10"
HOST_IP = `ip route get 8.8.8.8 | head -1 | cut -z -d' ' -f7`
# HOST_IP = "192.168.1.10"

OAM_NETWORK_PREFIX = "192.168.10."  # Operation and Maintenance (OAM) network
FIP_NETWORK_PREFIX = "192.168.11."  # FloatingIP network

MAAS_IP = OAM_NETWORK_PREFIX + "2"

# Operations and Management (OAM) network MAAS DHCP range
OAM_DYNAMIC_RANGE_START = OAM_NETWORK_PREFIX + "200"
OAM_DYNAMIC_RANGE_END   = OAM_NETWORK_PREFIX + "254"

# OAM network reserved range (for gateway and MAAS)
OAM_RESERVED_RANGE_START = OAM_NETWORK_PREFIX + "1"
OAM_RESERVED_RANGE_END   = OAM_NETWORK_PREFIX + "9"

# Total number of Cloud Nodes
CLOUD_NODES_COUNT = 1

# CPU and RAM configuration for Cloud Nodes
# Adjust the values that would fit into your host's capacity. Note that if you 
# want to deploy e.g. OpenStack on MAAS, and then spin up VMs on OpenStack, you 
# need to significantly bump up RAM and CPUs for Cloud Nodes.
CLOUD_NODE_CPUS   = 4  # vCPUs per Cloud Node
CLOUD_NODE_MEMORY = 2048  # 4GB plus ~200MB headroom 

# End of Configuration section -------------------------------------------------

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  config.ssh.private_key_path = ["./roles/maas_juju/files/id_rsa", "~/.vagrant.d/insecure_private_key"]
  config.vm.provision "file", source: "./roles/maas_juju/files/id_rsa.pub", destination: "~/.ssh/authorized_keys"

  # MAAS Server
  config.vm.define "maas", primary: true do |maas|
    maas.vm.box = "generic/ubuntu2004"
    maas.vm.hostname = "maas"

    # Forward MAAS GUI port for easier access
    # MAAS GUI is accessible at http://localhost:5240/MAAS/
    maas.vm.network "forwarded_port", guest: 5240, host: 5240

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
  end

  # PXE nodes
  (1..CLOUD_NODES_COUNT).each do |i|
    config.vm.define "node#{"%02d" % i}" do |node|
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
        domain.storage :file, :size => '16G', :bus => 'scsi'  # Data disk (e.g. for Ceph OSD)
        boot_network = {'network' => 'OAM'}
        domain.boot boot_network
        domain.autostart = false
        domain.mgmt_attach = false
      end
    end
  end
end
