sudo su
cd ~ && wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
dpkg -i puppetlabs-release-pc1-trusty.deb
apt-get update
apt-get -y install puppetserver
service puppetserver restart
/opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true