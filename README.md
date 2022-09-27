
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

### MAAS Features

| Feature | Description |
| --- | --- |
| Automação | Descoberta e registro automáticos de todos os dispositivos na rede. Automação BMC (IPMI, AMT e mais) e PXE (IPv4 e IPv6) |
| Implantação rápida(Fast deployment) | Implantação Zero-touch do Ubuntu, CentOS, Windows, RHEL e SUSE. Implementa distribuições Linux em menos de 5 minutos |
| Configuração da máquina | Configura as interfaces de rede da máquina com pontes, VLANs, ligações e muito mais. Cria layouts avançados de sistema de arquivos com RAID, cache, LVM e muito mais |
| Integração DevOps| Integração com ferramentas de automação DevOps como conjure-up, Juju, Chef, Puppet, SALT, Ansible e muito mais |
| Gerenciamento de pod | Transforma servidores bare-metal em hypervisors, permitindo a criação automatizada de máquinas virtuais e apresentá-las como novos servidores disponíveis para deployment |
| Gerenciamento de rede | Observa e cataloga cada endereço IP na rede (IPAM). DHCP altamente disponível (ativo-passivo) e DNS (ativo-ativo) integrados |
| Acompanhamento de serviço | Monitora e rastreia serviços críticos para garantir operações adequadas |
| Gerencia | Vem com uma API REST, UI da Web e CLI |


## ferramenta de modelagem Juju

Juju é uma ferramenta de modelagem de aplicativos de código aberto que permite implantar, configurar, dimensionar e operar infraestruturas em nuvem de forma rápida e eficiente em nuvens como AWS, GCE e Azure; juntamente com nuvens privadas como Metal as a Service (MAAS), OpenStack e VMware VSphere.

A Juju store permite o acesso a uma ampla gama de soluções de práticas recomendadas que você pode implantar com um único comando. Você pode usar o Juju a partir da linha de comando ou por meio de sua poderosa representação gráfica do modelo na GUI.

### Por que usar Juju?

Juju é uma ferramenta de modelagem de aplicativos de código aberto que permite implantar, seja envolvendo aprendizado profundo, orquestração de contêineres, big data em tempo real ou processamento de fluxo, grandes softwares precisam que as operações sejam de código aberto e automatizadas.

Juju é a melhor maneira de encapsular todo o conhecimento operacional necessário para automatizar o comportamento do seu aplicativo.

### Versões de firmware dos componentes do servidor

| Componente | Versão |
| --- | --- |
| iDRAC | -- |
| External NIC firmware | -- |
| BIOS | -- |
| controlador RAID PERC | -- |

### Software versions

As seguintes versões de software fazem parte desta arquitetura de referência:

| Componente | Versão |
| ---------- | ------ |
| Ubuntu | 20.04 LTS |
| Openstack | -- |
| MAAS | 3.4 |
| Juju | -- |
| Openstack Charms | -- |

<!-- final do documento, dedicado para abreviações -->
*[MAAS]: Metal as a Service