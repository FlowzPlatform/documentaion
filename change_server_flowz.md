## Move all host to new server

```
(1) Take backup of rethinkdb,ldap server and websites.
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
(2) Purchase server from any cloud service provider.
```



```
(3) Sync all backup with new server.
```

rsync -avzh <local_path_to_data> root@<remote_host>:/rethinkdb-data-dev/


```
(4) Add server in rancher.
```

```
(5) Add certificate in rancher.
```


```
(6) create NFS server using rancher CATALOG.
```


```
(7) Start all service using docker-compose.yml and rancher-compose.yml files.
```

```
(8) Upgrade those service which used NFS server by adding "rancher-nfs" in Volume Driver.
```

```
(9) Change environment IP of service-api-backend.
``` 

change IP of environment variable serverARecord in service-api-backend-flowz with client-webroot server IP.

```
(9) Change entry in Atomia DNS.
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
