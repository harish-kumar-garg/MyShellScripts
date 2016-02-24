#!/bin/bash
apt-get update

#install java
sudo apt-get update
sudo apt-get -y install default-jdk


apt-get update

# set up a silent install of MySQL

export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.6 mysql-server/root_password password welcome123 | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password welcome123 | debconf-set-selections

# install the LAMP stack
apt-get -y install mysql-server 

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

sudo service mysql restart

echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'welcome123'; flush privileges;" | mysql -u root -pwelcome123

#install tomcat
sudo mkdir /opt/tomcat
cd /opt/tomcat
sudo wget http://www.interior-dsgn.com/apache/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.zip
sudo wget https://www.apache.org/dist/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.zip.md5
cat apache-tomcat-8.0.29.zip.md5
md5sum apache-tomcat-8.0.29.zip
sudo unzip apache-tomcat-8.0.29.zip
cd apache-tomcat-8.0.29/bin
sudo chmod 777 /opt/tomcat/apache-tomcat-8.0.29/bin/*.sh
sudo ln -s /opt/tomcat/apache-tomcat-8.0.29/bin/startup.sh /usr/bin/tomcatup
 sudo ln -s /opt/tomcat/apache-tomcat-8.0.29/bin/shutdown.sh /usr/bin/tomcatdown
sudo chmod 777 /opt/tomcat/apache-tomcat-8.0.29/logs/
tomcatup

#install sikuli
sudo apt-get update
sudo apt-get install sikuli-ide

#install maven
sudo apt-get install maven

#install ant
sudo apt-get install ant

