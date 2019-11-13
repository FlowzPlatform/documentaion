# Database Import-Export
This Documentation is about how can we export data or database from old database to new database

---

# RethinkDb
#### Export Data:
```sh
$ rethinkdb dump -c <host>:<port> -e <database name>
```
Export Data From AWS Compose Rethinkdb:
```sh
$ rethinkdb dump -c <host>:<port> -e <database name> --tls-cert ./ca.crt -p
```
It will ask your rethinkDb password

After successful export it will generate zip file , you need to unzip it



#### Import Data:
```sh
$ rethinkdb import -d <directory path which to import> -c <host>:<port>  
```
Import Data To AWS Compose Rethinkdb:
```sh
$ rethinkdb dump -d <directory path which to import> -c <host>:<port>  --tls-cert ./ca.crt -p
```
It will ask your rethinkDb password

---

# MongoDb
#### Export Data

```sh
$ mongoexport -h localhost:27017 --db <database name> --collection <collection name> --out <which file to export(.json)>
```

#### Import Data:
```sh
$ mongoimport -h localhost:27017 --db <database name> --collection <collection name> --file <which file to import(.json)>
```
# VirtualDb Restore

```sh
$ mongorestore -d virtualDB mongo_backup/videovirtualdb/

```

---
# Postgresql
```
$ sudo apt-get install postgresql
$ sudo apt install postgresql-client-common
```

#### Export Data:
```sh
$ pg_dump -h <host-name> -p <port>  <database-name> > kong_database_file
```
Export Data From AWS Compose Postgresql:
```sh
$  pg_dump -U <username> -h <host-name> -p <port>  <database-name> > kong_database_file
```
It will ask your Postgresql password

After successful export it will create file 



#### Import Data:
```sh
$ psql -U <user-name> -h <host> -p <port>  <database-name> < kong_database_file
```
Import Data To AWS Compose Postgresql:
```sh
$ psql -U <user-name> -h <host> -p <port>  <database-name> < kong_database_file
```
It will ask your Postgresql password

---

