#!/usr/bin/env bash

# Configure SSH.

cp /vagrant/.vagrant/machines/Target1/virtualbox/private_key /home/vagrant/.ssh/id_rsa
cp /vagrant/ssh/config /home/vagrant/.ssh/
chown vagrant:vagrant /home/vagrant/.ssh/*
chmod 600 /home/vagrant/.ssh/*

# Install and configure Ansible.

if [ ! -f /usr/bin/ansible-playbook ]
then
  apt-get update
  apt-get install -y software-properties-common
  apt-add-repository -y ppa:ansible/ansible
  apt-get update
  apt-get --purge remove -y ansible
  apt-get install -y ansible
fi

echo -e "[Targets]\n\n10.0.0.5\n" >> /etc/ansible/hosts

