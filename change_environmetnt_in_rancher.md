# Move all host from one environment to another environment in rancher


## (1) Add certificate in rancher.


![selection_057](https://user-images.githubusercontent.com/28925482/43885508-b4c01294-9bd6-11e8-9ce3-62bfad6ae1dd.png)


## (2) create NFS server using rancher CATALOG.


![selection_058](https://user-images.githubusercontent.com/28925482/43885563-e4fcc826-9bd6-11e8-93cb-189c25b44e09.png)


## (3) Stop all host in old environment and add all host in new environment.

![selection_065_1](https://user-images.githubusercontent.com/28925482/43891567-40292f22-9be7-11e8-8b95-032544c93557.png)


## (4) Start all service using docker-compose.yml and rancher-compose.yml files.

![selection_066](https://user-images.githubusercontent.com/28925482/43890924-b4382a0a-9be5-11e8-8847-cb0944cb33a7.png)


## (5) Upgrade those service which used NFS server by adding "rancher-nfs" in Volume Driver.

![selection_061](https://user-images.githubusercontent.com/28925482/43885647-155efc14-9bd7-11e8-8b1f-d3e72163d826.png)
