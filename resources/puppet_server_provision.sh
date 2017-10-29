#!/bin/bash
echo "Installing repos.."
sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable rhel-server-rhscl-7-rpms
sudo yum clean all
sudo yum repolist

echo "Installing packages.."
sudo yum -y install wget vim-enhanced mlocate tree epel-release centos-release-scl puppetserver
sudo updatedb

echo "Enabling and starting puppetserver service.."
sudo systemctl enable puppetserver
sudo systemctl start puppetserver

echo "Installing some baseline puppet modules.."
/opt/puppetlabs/bin/puppet module install stahnma-epel --version 1.2.2 --modulepath=/opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install adamcrews-mlocate --version 0.4.0 --modulepath=/opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install maestrodev-wget --version 1.7.3 --modulepath=/opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install puppetlabs-firewall --version 1.8.1 --modulepath=/opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install willdurand-composer --version 1.2.6 --modulepath=/opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install akandels-phpunit --version 1.0.0 --modulepath=/opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install saz-memcached --version 3.0.2 --modulepath=/opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install puppetlabs-ntp --version 6.3.0 --modulepath=/opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install saz-timezone --version 3.5.0 --modulepath=/opt/puppetlabs/puppet/modules


echo "Linking user provided puppet directories.."
if [ -d /vagrant/puppeteer/environments ]; then
	if [ -d /etc/puppetlabs/code/environments ]; then
		echo "Default environments directory detected, moving it over.."
		mv /etc/puppetlabs/code/environments /etc/puppetlabs/code/environments.original
	fi

	ln -s /vagrant/puppeteer/environments /etc/puppetlabs/code/environments
fi

if [ -d /vagrant/puppeteer/modules ]; then
	if [ -d /etc/puppetlabs/code/modules ]; then
		echo "Default modules directory detected, moving it over.."
		mv /etc/puppetlabs/code/modules /etc/puppetlabs/code/modules.original
	fi

	ln -s /vagrant/puppeteer/modules /etc/puppetlabs/code/modules
fi

echo "Updating user prompt.."
wget 'https://gist.githubusercontent.com/templesofcode/8961138a2110842e86b5a5b69b82add0/raw/ee29fcbf00b3cbc173b43ad4e6bfdddabe5cc465/prompt.sh'  -O - >> /home/vagrant/.bash_profile
