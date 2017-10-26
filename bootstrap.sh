#!/usr/bin/env bash

# Configure SSH.

cp /vagrant/.vagrant/machines/Target1/virtualbox/private_key /home/vagrant/.ssh/id_rsa_1
cp /vagrant/.vagrant/machines/Target2/virtualbox/private_key /home/vagrant/.ssh/id_rsa_2
cp /vagrant/.vagrant/machines/Target3/virtualbox/private_key /home/vagrant/.ssh/id_rsa_3
cp /vagrant/ssh/config /home/vagrant/.ssh/
chown vagrant:vagrant /home/vagrant/.ssh/*
chmod 600 /home/vagrant/.ssh/*

# Install and configure Ansible.

if [ ! -f /usr/bin/ansible-playbook ]
then
  apt-get update
  apt-get install -y ansible
  rm -rf /vagrant/.vagrant/machines/*/cache/apt/partial # Take care of a small bug here as vagrant-cachier is now getting on and not maintained anymore !
  apt-get update
fi

echo -e "[Targets]\n\n10.0.0.5\n10.0.0.6\n10.0.0.7\n" >> /etc/ansible/hosts

####################