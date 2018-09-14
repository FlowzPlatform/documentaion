## sudo user with different home directory.

```
adduser <user_name>
usermod -aG sudo <user_name>
usermod --home <path_to_directory> <user_name>
chown -R <user_name>:<user_name> <path_to_directory>
