
# Maas, Juju and Ansible

Esse é um projeto que busca fazer o deploy da ferramenta Maas e Juju usando o Ansible

## MAAS (Metal as a Service)

Metal as a Service (MAAS) é uma automação completa de servidores físicos para operação de data center, seu código aberto e suporte pela Canonical.

O MAAS trata servidores físicos como máquinas virtuais ou instâncias na nuvem. Em vez de ter que gerenciar cada servidor individualmente, o MAAS transforma bare metal em um recurso semelhante a uma nuvem elástica.

* IU da Web, otimizada para dispositivos móveis
* Instalação do Ubuntu, CentOS, Windows, RHEL e SUSE suporta
* Gerenciamento de endereço IP (IPAM)
* Suporte completo para API/CLI
* Alta disponibilidade
* Suporte IPv6
* Inventário de componentes
* DHCP e DNS para outros dispositivos na rede
* Integração de retransmissão DHCP
* VLAN e suporte de malha
* NTP para toda a infraestrutura
* Teste de hardware
* Suporte de hardware composto
* MAAS funciona com qualquer configuração de sistema e é recomendado pelas equipes por trás tanto o Chef quanto o Juju como um sistema de provisionamento físico.

MAAS Features

| Feature | Description |
| --- | --- |
| Automation | Automatic discovery and registration of every device on the network. BMC (IPMI, AMT and more) and PXE (IPv4and IPv6) automation |
| Fast deployment | Zero-touch deployment of Ubuntu, CentOS, Windows, RHEL and SUSE. Deploys Linux distributions in less than 5 minutes |
| Machine configuration | Configures the machine’s network interfaces with bridges, VLANs, bonds and more. Creates advanced file system layouts with RAID,  cache, LVM and more |
| DevOps integration | Integration with DevOps automation tools like conjure-up, Juju, Chef, Puppet, SALT, Ansible and more |
| Pod management | Turns bare-metal servers into hypervisors, allowing automated creation of virtual machines and present them as new servers available for the deployment |
| Network management | Observes and catalogs every IP address on the network (IPAM). Built-in highly available DHCP (active-passive) and DNS (active-active) |
| Service tracking | Monitors and tracks critical services to ensure proper operations |
| Manage | Comes with a REST API, Web UI and CLI |

