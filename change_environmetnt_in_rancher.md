## Move all host from one environment to another environment in rancher

(1) Add certificate in rancher.

![selection_057](https://user-images.githubusercontent.com/28925482/43885508-b4c01294-9bd6-11e8-9ce3-62bfad6ae1dd.png)

(2) create NFS server using rancher CATALOG.

![selection_058](https://user-images.githubusercontent.com/28925482/43885563-e4fcc826-9bd6-11e8-93cb-189c25b44e09.png)

(3) Stop all host in old environment and add all host in new environment.

(4) Start all service using docker-compose.yml and rancher-compose.yml files.

(5) Upgrade those service which used NFS server by adding "rancher-nfs" in Volume Driver.
