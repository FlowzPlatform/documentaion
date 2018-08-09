# Start Rancher with MySQL DB.

## (1) Start MySQL service: 

```
docker run --name mysql-flowz -p 3306:3306 -v /var/mysql_flowz_new:/var/lib/mysql  -e MYSQL_ROOT_PASSWORD=<password> -d mysql:5.6.39
```

## (2) Start Rancher:

```
docker run  -d --name rancher-server --restart=unless-stopped -p 8085:8080 rancher/server:v1.6.17 --db-host <MySQL_DB_IP> --db-port 3306 --db-user cattle --db-pass <cattle_db_password> --db-name cattle
```
