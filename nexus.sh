#!/bin/bash 
# update_settings credentials
sed -i -e 's/#user#/'"$nexus_user"'/g' /home/.m2/settings.xml && sed -i -e 's/#pass#/'"$nexus_user_password"'/g' /home/.m2/settings.xml

# add repositories
echo deb https://nexus.electronicid.eu/repository/apt-release xenial main | sudo tee -a /etc/apt/sources.list.d/electronicid.list
echo deb https://nexus.electronicid.eu/repository/apt-edge xenial main | sudo tee -a /etc/apt/sources.list.d/electronicid.list

apt-get install curl

# add repository public key
curl -f -u user:pass https://nexus.electronicid.eu/repository/keys/apt/gpg | sudo apt-key add -


# adding nexus credentials for access to repository
touch /etc/apt/auth.conf
echo "machine nexus.electronicid.eu" >> /etc/apt/auth.conf
echo 'login '"$nexus_user" >> /etc/apt/auth.conf
echo 'password '"$nexus_user_password" >> /etc/apt/auth.conf


# update available packages
apt-get update
