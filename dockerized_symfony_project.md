### process to dockerized symfony projects.

(1) Download the solrcore,database and project from oldserver.

(2) upload all solrcores in "/home/docker-client-symfony/your-awesome-core" location where solr is live.

(3) import database in new server.

(4) start redis service in rancher for a particular project.

(5) do bellow changes in project:

``
    1. change redis connection link which is in 
``    
```
          app/config/project/project_cache.yml, 
          app/config/project/parameters.yml,
          app/config/config.yml,
          etc...
```

    2. change solr connection link which is in
```
          app/config/project/search_config.yml,
          etc...
```

    3. change MySQL connection link which is in
```
          app/config/project/parameters.yml,
          etc...
```

    4. change MongoDB connection link which is in 
```
          app/config/config.yml,
          app/config/project/parameters.yml,
          etc...
```

    5. change base_url connection link which is in
```
          app/config/project/project_seetings.yml,
          etc...
```
    6. add etc/httpd/conf.d/vhost.conf in root directory and change projectname(ex. clickroel), ServerName(ex. clickroel.flowzcluster.tk).
    
```
<VirtualHost *:80>
    ServerAdmin networks@officebeacon.com
    DocumentRoot /var/www/app/public_html/$projectname/web
    ServerName $ServerName
    ServerAlias $ServerName
    ErrorLog /etc/httpd/logs/smcmadetoorder_error_log
    DirectoryIndex app.php index.php
    CustomLog /etc/httpd/logs/smcmadetoorder_access_log combined

        <Directory /var/www/app/public_html/$projectname/web>
             AllowOverride All
             Require all granted
        </Directory>

        <IfModule php5_module>
            php_value newrelic.appname "signetlive.officebrain.com; smcmadetoorder.com"
        </IfModule>

<IfModule mod_gzip.c>
    mod_gzip_on       Yes
    mod_gzip_dechunk  Yes
    mod_gzip_item_include file      \.(html?|txt|css|js|php|pl)$
    mod_gzip_item_include handler   ^cgi-script$
    mod_gzip_item_include mime      ^text/.*
    mod_gzip_item_include mime      ^application/x-javascript.*
    mod_gzip_item_exclude mime      ^image/.*
    mod_gzip_item_exclude rspheader ^Content-Encoding:.*gzip.*
</IfModule>

</VirtualHost>

<VirtualHost *:80>
    ServerAdmin networks@officebeacon.com
    DocumentRoot /var/www/app/public_html/$projectname
    ServerName $ServerName
    ErrorLog /etc/httpd/logs/ip_error_log
    DirectoryIndex aap.php index.php
    CustomLog /etc/httpd/logs/ip_access_log combined

    <Directory /var/www/app/public_html/$projectname/>
         AllowOverride All
         Require all granted
    </Directory>

</VirtualHost>
```

    7. make Dockerfile in root directory and change projectname(ex. clickroel) and redis connection url (ex. redis-clickroel.redis-database:6379).

```
FROM obdev/sweda-docker-client


RUN rm -rf  /var/www/app/public_html/swedausa
#ADD .  /var/www/app/public_html/$projectname 
RUN mkdir /var/www/app/public_html/$projectname

ADD  ./etc/httpd/conf.d/vhost.conf  /etc/httpd/conf.d/vhost.conf


RUN chmod 777 -R /var/lib/php/session

WORKDIR /

RUN wget https://github.com/nicolasff/phpredis/archive/master.zip
RUN unzip master.zip
WORKDIR  /phpredis-master 
#RUN ls
RUN  phpize
RUN ./configure
RUN make
RUN make install
RUN echo "extension=redis.so" >> /etc/php.ini

RUN yum -y install php-opcache

RUN sed 's/.*max_execution_time.*/max_execution_time = 3600/'  -i /etc/php.ini

RUN sed 's/.*max_input_time.*/max_input_time = 3600/'  -i /etc/php.ini

RUN sed 's/.*max_input_vars.*/max_input_vars = 20000/'  -i /etc/php.ini

RUN sed 's/.*realpath_cache_size.*/realpath_cache_size = 4096k/'  -i /etc/php.ini

RUN sed 's/.*realpath_cache_ttl.*/realpath_cache_ttl = 7200/'  -i /etc/php.ini

RUN sed 's/.*session.save_handler.*/session.save_handler = redis/'  -i /etc/php.ini

RUN sed '0,/.*session.save_path.*/s/.*session.save_path.*/session.save_path = "tcp:'\\/''\\/'$connection_url"/'  -i /etc/php.ini

RUN sed 's/.*opcache.memory_consumption.*/opcache.memory_consumption=512/'  -i /etc/php.d/opcache.ini && \

sed 's/.*opcache.max_accelerated_files.*/opcache.max_accelerated_files=40000/'  -i /etc/php.d/opcache.ini && \

sed 's/.*opcache.validate_timestamps.*/opcache.validate_timestamps=1/'  -i /etc/php.d/opcache.ini

RUN yum -y install screen

RUN yum install -y php56w-intl
RUN  echo "extension=php_intl.so" >> /etc/php.ini

WORKDIR /var/www/app/public_html/$projectname 
```

(6) make docker image and push in dockerhub.

(7) run docker image in rancher.
