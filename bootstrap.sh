#!/usr/bin/env bash

# Install Ansible.

if [ ! -f /usr/bin/ansible-playbook ]
then
  apt-get install software-properties-common
  apt-add-repository ppa:ansible/ansible
  apt-get update
  apt-get install -y ansible
fi

# Install Apache Web Server.   

#apt-get update
#apt-get install -y apache2
#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi

