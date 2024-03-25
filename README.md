# hackbox-lab

A cyber security lab hosted in Proxmox VE



![](hackbox-lab-topology.png)

This repo was inpired by a youtube series from @gerardobrien. This is my take on his concept. 

On this topology, I decided to segretate the scan systems from the Kali workbench.

# Prerequisites 

 - A freshly brewed cup of patience to get through the build.
 - Operating systems used in this sandbox (Windows 2022 Server, Windows 10, 11 Client, Ubuntu 22.04 LTS, Kali Linux)
 - Proxmox VE 8.1.5 (Fresh install)
 - Hardware used: 1 Dell Latitude 5500 laptop - 1tb ssd - 32 gb RAM

# Build Links

## Docker

https://docs.docker.com/engine/install/ubuntu/
https://docs.portainer.io/start/install-ce/server/docker/linux

## Docker Images

bwapp - https://hub.docker.com/r/raesene/bwapp
dvwa - https://hub.docker.com/r/vulnerables/web-dvwa/
webgoat - https://hub.docker.com/r/webgoat/webgoat

## Wazuh

https://documentation.wazuh.com/current/quickstart.html
https://documentation.wazuh.com/current/installation-guide/wazuh-agent/index.html
https://documentation.wazuh.com/current/user-manual/capabilities/container-security/monitoring-docker.html
https://github.com/gerardobrien/ultimate-cybersecurity-lab

## Nessus

https://www.tenable.com/downloads/nessus?loginAttempted=true



## To Do

- Improve Documentation
  - README
  - Topology (WIP)
  - Writeup
  - Enumeration worksheet
  - 
- Automation
  - VM deployment script
  - Ansible

## Credits
#### Shoutout to @gerardobrien's youtube channel
