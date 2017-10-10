getssl
---------------------------------------
Obtain SSL certificates from the letsencrypt.org ACME server. Suitable for automating the process on remote servers
-----------------------------------------------------------------------------------------------------


Installation
-----------------------------------------------------------------------------------------------------
curl --silent https://raw.githubusercontent.com/srvrco/getssl/master/getssl > getssl ; chmod 700 getssl

This will copy the getssl Bash script to the current location and change the permissions to make it executable for you.
-----------------------------------------------------------------------------------------------------




How To Use
------------------------------------------------------------------------------------------------------
Create a certificate
  ./getssl -c sslflowz.tk
edit ~/.getssl/getssl.cfg to set the values you want
edit ~/.getssl/sslflowz.tk/getssl.cfg to have the values you want

specify correct ACL for all remote server file (ex. ~/.getssl/sslflowz.tk/getssl.cfg)
ex. ACL=('ssh:ec2:/var/www/html/.well-known/acme-challenge')
         where ec2 host which detail you can store in ~/.ssh/config

     USE_SINGLE_ACL="true"
     DOMAIN_CERT_LOCATION="/etc/ssl/sslflowz.tk.crt"
     DOMAIN_KEY_LOCATION="/etc/ssl/sslflowz.tk.key"
     CA_CERT_LOCATION="/etc/ssl/sslflowz.tk.bundle"

     RELOAD_CMD="service apache2 reload"


Then just run;
  ./getssl -d sslflowz.tk
------------------------------------------------------------------------------------------------------





Automating updates
------------------------------------------------------------------------------------------------------
set cron job on host server

23  5 * * * /root/scripts/getssl -u -a -q
The cron will automatically update getssl and renew any certificates, only giving output if there are issues / errors.

The -u flag updates getssl if there is a more recent version available.
The -a flag automatically renews any certificates that are due for renewal.
The -q flag is "quiet" so that it only outputs and emails me if there was an error / issue.
--------------------------------------------------------------------------------------------------------




How To use a SSL Certificate on Apache
--------------------------------------------------------------------------------------------------------
      sudo a2enmod ssl
      sudo service apache2 restart
      sudo nano /etc/apache2/sites-available/default-ssl.conf
      With the comments removed, the file looks something like this:
      <IfModule mod_ssl.c>
          <VirtualHost _default_:443>
              ServerAdmin admin@example.com
              ServerName your_domain.com
              ServerAlias www.your_domain.com
              DocumentRoot /var/www/html
              ErrorLog ${APACHE_LOG_DIR}/error.log
              CustomLog ${APACHE_LOG_DIR}/access.log combined
              SSLEngine on
              SSLCertificateFile /etc/apache2/ssl/apache.crt
              SSLCertificateKeyFile /etc/apache2/ssl/apache.key
              <FilesMatch "\.(cgi|shtml|phtml|php)$">
                              SSLOptions +StdEnvVars
              </FilesMatch>
              <Directory /usr/lib/cgi-bin>
                              SSLOptions +StdEnvVars
              </Directory>
              BrowserMatch "MSIE [2-6]" \
                              nokeepalive ssl-unclean-shutdown \
                              downgrade-1.0 force-response-1.0
              BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown
          </VirtualHost>
       </IfModule>

       sudo a2ensite default-ssl.conf
--------------------------------------------------------------------------------------------------------
