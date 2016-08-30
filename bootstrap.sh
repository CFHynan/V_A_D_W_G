#!/usr/bin/env bash

# Set SSH permissions for private key.

chmod 600 /home/vagrant/.ssh/id_rsa

# Install and configure Ansible.

if [ ! -f /usr/bin/ansible-playbook ]
then
  apt-get update
#  For >= v12.10, otherwise use python below: apt-get install -y software-properties-common
  apt-get install -y python-software-properties
  apt-add-repository -y ppa:ansible/ansible
  apt-get --purge remove -y ansible
  apt-get install -y ansible
fi

echo -e "10.0.0.5\n" >> /etc/ansible/hosts

# Install Apache Web Server.   

#apt-get update
#apt-get install -y apache2
#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi

