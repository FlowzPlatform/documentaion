

(1) Login:

```
    mysql -u root -h  <host_ip> --port 3306 -p
```

(2) create database:

```
    CREATE DATABASE databasename;
```

(3) drop database:

```
    DROP DATABASE databasename;
```

(4) display databases:

```
    show databases;
```

(5) create table:

```
    CREATE TABLE tablename (
      column1 datatype,
      column2 datatype,
      column3 datatype,
      ....
    );
```

(6) drop table:

```
    DROP TABLE tablename;
```

(7) display table:

```
    show tables;
```

(8) create user:

```
    CREATE USER 'username'@'%' IDENTIFIED BY 'password';
```

(9) grant permission:

```
    GRANT ALL PRIVILEGES ON databasename.* TO 'username'@'%';
```

(10) delete user:

```
    DROP USER 'username'@'%';
```

(11) display users:

```
     SELECT User, Host, Password FROM mysql.user;
```

(12) revoke permission:

```
     REVOKE ALL PRIVILEGES ON databasename.* FROM 'username'@'%';
```

(13) export dabase:

```
     mysqldump -P 3306 -h <host_ip> -u root -p databasename > db_backup.sql
```

(14) import database:

```
     mysql -u root -p -h <host_ip> databasename < db_backup.sql
```
