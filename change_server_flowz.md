# Move all host to new Server

## (1) Take backup of rethinkdb,ldap server and websites.

```
rethindb backup for develop:
rsync -avzh root@<rethinkdb_host_ip>:/rethinkdb-data-dev/_data <local_path>

rethindb backup for qa:
rsync -avzh root@<rethinkdb_host_ip>:/rethinkdb-data-qa/_data <local_path>

rethindb backup for staging:
rsync -avzh root@<rethinkdb_host_ip>:/rethinkdb-data <local_path>

ldap backup:
rsync -avzh root@<cluster_server_ip>:/openldapdocker <local_path>

NFS server backup:
rsync -avzh root@<client_webroot_ip>:/nfs <local_path>
```

## (2) Purchase server from any cloud service provider.

![selection_066_11](https://user-images.githubusercontent.com/28925482/43890777-4ad0a3a8-9be5-11e8-8b9a-10a49014847c.png)

## (3) Sync all backup with new server.

```
rsync -avzh <local_path_to_data> root@<remote_host>:/rethinkdb-data-dev/
```

## (4) Add server in rancher.

![selection_065](https://user-images.githubusercontent.com/28925482/43890863-80b63834-9be5-11e8-8782-9933025797dd.png)

## (5) Add certificate in rancher.

![selection_057](https://user-images.githubusercontent.com/28925482/43885508-b4c01294-9bd6-11e8-9ce3-62bfad6ae1dd.png)

## (6) create NFS server using rancher CATALOG.

![selection_058](https://user-images.githubusercontent.com/28925482/43885563-e4fcc826-9bd6-11e8-93cb-189c25b44e09.png)

## (7) Start all service using docker-compose.yml and rancher-compose.yml files.

![selection_066](https://user-images.githubusercontent.com/28925482/43890924-b4382a0a-9be5-11e8-8847-cb0944cb33a7.png)

## (8) Upgrade those service which used NFS server by adding "rancher-nfs" in Volume Driver.

![selection_061](https://user-images.githubusercontent.com/28925482/43885647-155efc14-9bd7-11e8-8b1f-d3e72163d826.png)

## (9) Change environment variable value of service-api-backend.
 
``` 
change IP of environment variable serverARecord in service-api-backend-flowz with client-webroot server IP.
```

## (10) Change entry in Atomia DNS.

```
for develop:

Lable            Server

api              api-gateway server IP
auth             api-gateway server IP
ws               lbl-ws server IP
@                client-webroot server IP
devrethink       rethinkdb-dev server IP
ldap             cluster-flowz server IP
All front        lbl-ws server IP


for qa:

Lable            Server

api              metal-jobqueue server IP
auth             metal-jobqueue server IP
ws               client-webroot-qa server IP
@                client-webroot-qa server IP
qarethink        rethinkdb-dev server IP
ldap             cluster-flowz-qa server IP
All front        lbl-ws server IP


for staging:

Lable            Server

api              api-gateway server IP
auth             api-gateway server IP
ws               lbl-ws server IP
@                client-webroot server IP
rethinkdb        rethinkdb-server IP
ldap             cluster-flowz server IP
All front        lbl-ws server IP
```
