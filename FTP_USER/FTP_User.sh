# create FTP user and give access of perticuler folder


USER=$1
DIRECTORY_PATH=$2

adduser $USER
groupadd $USER
chown -R .$USER $DIRECTORY_PATH
chmod -R g+rw $DIRECTORY_PATH
usermod -d $DIRECTORY_PATH $USER

echo "Done..............."




# Run script using this command

# sh FTP_User.sh testuser /var/test
