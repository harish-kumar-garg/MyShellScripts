sudo su
cd ~ && wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
dpkg -i puppetlabs-release-pc1-trusty.deb
apt-get update
apt-get install puppet-agent
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true