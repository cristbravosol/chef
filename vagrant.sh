#!/bin/bash

# Install EPEL and package python dependencies
yum install -y epel-release
yum install -y gcc python3 python3-devel openssl-devel vim


# Install Molecule Ansible-lint
pip3 install molecule ansible-lint docker-py molecule-goss molecule-vagrant molecule-inspec

# Install Goss
curl -fsSL https://goss.rocks/install | GOSS_DST=/usr/local/sbin sh > /dev/null 2>&1


# Install Docker + some dependencies
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl start docker && systemctl enable docker
usermod -G docker -a vagrant



# Copy the roles ansible to the home directory of the vagrant user
#if [ ! -d /home/vagrant/ansible ] || [ ! -d /home/vagrant/kitchen ]; then
#   echo "Creating folder structure roles.."
#   mkdir -p /home/vagrant/ansible/roles
#   mkdir -p /home/vagrant/kitchen
#   cp -a /vagrant/ansible/roles/. /home/vagrant/ansible/roles
#   cp -a /vagrant/chef /home/vagrant/kitchen
#   chown -R vagrant:vagrant /home/vagrant
#   #cd /home/vagrant/roles/httpd_webserver/molecule/default && ln -s tests molecule
#
#else
#    echo "Already create folder structure roles"
#
#fi


# Install Chef Kitchen
echo "Install Chef Kitchen..."
if [ ! -d /opt/chefdk ]; then
   cd /var/tmp && wget https://packages.chef.io/files/stable/chefdk/4.7.73/el/7/chefdk-4.7.73-1.el7.x86_64.rpm > /dev/null 2>&1
   rpm -ivh chefdk-*.rpm
   echo "Install Chef Libs..."
   echo -e "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/opt/chefdk/embedded/bin" >> /etc/profile.d/ruby.sh
   echo -e "export PATH" >> /etc/profile.d/ruby.sh
   source /etc/profile.d/ruby.sh
   chef gem install kitchen-docker kitchen-ansible kitchen-ansiblepush kitchen-puppet busser busser-bats busser-bash busser-goss
   cp /vagrant/chef/kitchen-ansible-inventory /opt/chefdk/embedded/bin
   chown -R vagrant.vagrant /opt/chefdk
else
   echo "Already create /opt/chefdk"
fi


