##Move all host from one environment to another environment in rancher

(1) Add certificate in rancher.

(2) create NFS server using rancher CATALOG.

(3) Stop all host in old environment and add all host in new environment.

(4) Start all service using docker-compose.yml and rancher-compose.yml files.

(5) Upgrade those service which used NFS server by adding "rancher-nfs" in Volume Driver.
