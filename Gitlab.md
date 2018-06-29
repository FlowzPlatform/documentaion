### (1) Copy gitlab backup folder from old server to new server:
```
rsync -avzh /srv/gitlab/ root@<new-server-ip>:/srv/gitlab/
```

### (2) chown of authorized_keys.lock file:
```
chown root:root /srv/gitlab/data/.ssh/authorized_keys.lock
```
### (3) start gitlab container:
```
sudo docker run --detach \
   --hostname gitlab.flowzcluster.tk \
   --publish 443:443 --publish 80:80 --publish 3022:22 \
   --name gitlab \
   --restart always \
   --volume /srv/gitlab/config:/etc/gitlab \
   --volume /srv/gitlab/logs:/var/log/gitlab \
   --volume /srv/gitlab/data:/var/opt/gitlab \
   gitlab/gitlab-ce:latest
```
### (4) Check status of new gitlab container:
```
docker ps 
docker logs gitlab
```
### (5) Also make change in:
```
Also make changes in Develope, Qa and Staging Environment in .netrc file
```
