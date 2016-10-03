#!bin/bash
sudo apt-get update
cd
#installing mysql
export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.6 mysql-server/root_password password welcome123 | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password welcome123 | debconf-set-selections
# install the LAMP stack
sudo apt-get -y install mysql-server-5.6
sudo sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
sudo service mysql restart
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'welcome123'; flush privileges;" | mysql -u root -pwelcome123
echo "CREATE DATABASE sonar CHARACTER SET utf8 COLLATE utf8_general_ci; CREATE USER 'sonar' IDENTIFIED BY 'sonar';GRANT ALL PRIVILEGES ON sonar.* TO 'sonar'@'%' IDENTIFIED BY 'sonar'; GRANT ALL ON sonar.* TO 'sonar'@'localhost' IDENTIFIED BY 'sonar'; flush privileges;" | mysql -u root -pwelcome123

# installing Mongo DATABASE
# Configure mongodb.list file with the correct location
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Disable THP
sudo echo never > /sys/kernel/mm/transparent_hugepage/enabled
sudo echo never > /sys/kernel/mm/transparent_hugepage/defrag
sudo grep -q -F 'transparent_hugepage=never' /etc/default/grub || echo 'transparent_hugepage=never' >> /etc/default/grub

# Install updates
sudo apt-get -y update

# Modified tcp keepalive according to https://docs.mongodb.org/ecosystem/platforms/windows-azure/
sudo bash -c "sudo echo net.ipv4.tcp_keepalive_time = 120 >> /etc/sysctl.conf"

#Install Mongo DB
sudo apt-get install -y mongodb-org

# Uncomment this to bind to all ip addresses
# sudo sed -i -e 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
# sudo service mongod restart
