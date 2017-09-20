#Login into Nagios Server and install ssmtp and sendmail

```
sudo apt-get install ssmtp
sudo apt-get install sendmail
```

#For stoping the sendmail service as well as disabling from runlevel bootup
```
sudo /etc/init.d/sendmail stop
```

#Now take the backup of ssmtp.conf file and configure it.
```
cp -p  /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.orig.`date +%F`
```
```
> /etc/ssmtp/ssmtp.conf 

(now edit the ssmtp.conf file with vi editor or any editor which you like)

vi /etc/ssmtp/ssmtp.conf 

AuthUser=avasaniob@gmail.com
AuthPass=OB@123456
FromLineOverride=YES
mailhub=smtp.gmail.com:587
UseSTARTTLS=YES
```

#Now take the backup of sendmail script.
```
cp -p /usr/sbin/sendmail /usr/sbin/sendmail.orig.`date +%F`
rm /usr/sbin/sendmail
cd /usr/sbin
ln -s /usr/sbin/ssmtp sendmail
```

#Send an test email , replace emailid@example.com with your email id
```
echo "testing for nagios alerts"|mail -s "test nagiosalerts" emailid@example.com
```

#Configure with nagios:
```
cd /usr/local/nagios/etc/objects
sudo vi commands.cfg     ;(edite commands.cfg file)

# 'notify-host-by-email' command definition
define command{
	command_name	notify-host-by-email
	command_line	/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\nHost: $HOSTNAME$\nState: $HOSTSTATE$\nAddress: $HOSTADDRESS$\nInfo: $HOSTOUTPUT$\n\nDate/Time: $LONGDATETIME$\n" | mail -s "** $NOTIFICATIONTYPE$ Host Alert: $HOSTNAME$ is $HOSTSTATE$ **" $CONTACTEMAIL$
	}

# 'notify-service-by-email' command definition
define command{
	command_name	notify-service-by-email
	command_line	/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\n\nService: $SERVICEDESC$\nHost: $HOSTALIAS$\nAddress: $HOSTADDRESS$\nState: $SERVICESTATE$\n\nDate/Time: $LONGDATETIME$\n\nAdditional Info:\n\n$SERVICEOUTPUT$\n" | mail -s "** $NOTIFICATIONTYPE$ Service Alert: $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$ **" $CONTACTEMAIL$
	}
```

#Restart nagios
```
sudo service nagios restart
```


#Reference Link: http://sharadchhetri.com/2013/07/16/how-to-use-email-id-of-gmail-for-sending-nagios-email-alerts/

