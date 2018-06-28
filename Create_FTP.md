# (1) First check vsftpd status

```
   service vsftpd status
```
```
If vsftpd is not installed then install it first with

   apt-get install vsfptd      OR     yum install vsftpd
```

# (2) Do change in /etc/vsftpd.conf file
```
uncomment

chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list
```
```
And add this

allow_writeable_chroot=YES
```
# (3) Restart vsftpd service with
```
sudo systemctl restart vsftpd      OR      sudo service vsftpd restart
```

# (4) Add user with HOME directory
```
useradd --home /path/to/dir USERNAME
passwd USERNAME
```

# (5) FOR CENTOS
```
in order to allow access to FTP services from external systems,
we have to open port 21, where the FTP daemons are listening as follows:

firewall-cmd --zone=public --permanent --add-port=21/tcp
firewall-cmd --zone=public --permanent --add-service=ftp
firewall-cmd --reload
```
# (6) Now you can connect to FTP
```
now you can connect FTP and user is restricted with home directory only but in sftp user is not restricted so we have to turn off SFTP
```


TO restrict SFTP ADD 

Match User USERNAME,USERNAME2
PasswordAuthentication no

in /etc/ssh/sshd_config file

**************************************************************************

Restart SSHD service with

sudo systemctl restart sshd      OR      sudo service sshd restart


************************************************************************


END
