"TO create FTP User which is Ristricted to it's HOME directory."
---------------------------------------------------------------

## (1) First check vsftpd status

```
service vsftpd status
```
```
If vsftpd is not installed then install it first with

apt-get install vsfptd      OR     yum install vsftpd
```

## (2) Do change in /etc/vsftpd/vsftpd.conf file
```
uncomment

chroot_local_user=YES
chroot_list_enable=YES

make change
chroot_list_file=/etc/vsftpd/ftpusers
```
```
And add this
allow_writeable_chroot=YES

Add at last
pasv_enable=YES
pasv_min_port=10090
pasv_max_port=10100
```
## (3) Restart vsftpd service with
```
sudo systemctl enable vsftpd
sudo systemctl restart vsftpd      OR      sudo service vsftpd restart
```

## (4) Add user with HOME directory
```
useradd --home /path/to/dir USERNAME
passwd USERNAME
```

## (5) FOR CENTOS
```
in order to allow access to FTP services from external systems,
we have to open port 21, where the FTP daemons are listening as follows:

firewall-cmd --zone=public --permanent --add-port=21/tcp
firewall-cmd --zone=public --permanent --add-service=ftp
firewall-cmd --reload
```
## (6) Now you can connect to FTP
```
now you can connect FTP and user is restricted with home directory only.
But in sftp user is not restricted so we have to turn off SFTP
```

## (7) TO restrict SFTP Add in /etc/ssh/sshd_config file
```
Match User USERNAME,USERNAME2
PasswordAuthentication no
```
```
This will also deny SSH connection from that users.
```

## (8) Restart SSHD service with
```
sudo systemctl restart sshd      OR      sudo service sshd restart
```
