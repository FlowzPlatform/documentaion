

(1) Login:

```
   psql -h <Host_ip> -p <port_no> -U <database_user> -d <database_name> -W
```

(2) create database:

```
     CREATE DATABASE databasename;
```

(3) drop database:

```
    DROP DATABASE databasename;
```

(4) some commands:

```
    display databases :   \l
   
    show tables :  \dt
    
    quit :   \q
    
    show roles(users): \du
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

(7) create user:

```
    CREATE USER youruser WITH ENCRYPTED PASSWORD 'yourpass';
```

(8) grant permission:

```
    GRANT ALL PRIVILEGES ON DATABASE yourdbname TO youruser;
```

(9) delete user:

```
    DROP USER username;
```

(10) revoke permission:

```
     REVOKE ALL PRIVILEGES ON databasename FROM username;
```

(11) export dabase:

```  
     1. Login webhosting account via SSH.
        in the container you have to change User to postgres with "su - postgres"
        
     2. Type this command and replace the username and dbname.
         pg_dump -U USERNAME DBNAME > dbexport.pgsql
         
                  OR
                  
     1. you can create dump via phppgadmin web interface. 
```

(12) import database:

```
    psql -h <host_ip> -p <Port_no> -d <database_name> -U <database_user> -f <file_name>
    
    gunzip < dump.gz | psql -h <host_ip> -d <database_name> -U <username>
```
