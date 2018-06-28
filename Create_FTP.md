# first install vsftpd


apt-get install vsfptd      OR     yum install vsftpd

************************************************************

uncomment

chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd.chroot_list

&& Add this

allow_writeable_chroot=YES

in /etc/vsftpd.conf file

*******************************************************************

Restart vsftpd service with

sudo systemctl restart vsftpd      OR      sudo service vsftpd restart

********************************************************************

ADD user with HOME directory


useradd --home /path/to/dir USERNAME
passwd USERNAME

**********************************************************************
FOR CENTOS

in order to allow access to FTP services from external systems,
we have to open port 21, where the FTP daemons are listening as follows:

firewall-cmd --zone=public --permanent --add-port=21/tcp
firewall-cmd --zone=public --permanent --add-service=ftp
firewall-cmd --reload

****************************************************************************

now you can connect FTP and user is restricted with home directory only but in sftp user is not restricted so we have to turn off SFTP

**********************************************************************

TO restrict SFTP ADD 

Match User USERNAME,USERNAME2
PasswordAuthentication no

in /etc/ssh/sshd_config file

**************************************************************************

Restart SSHD service with

sudo systemctl restart sshd      OR      sudo service sshd restart


************************************************************************


END
