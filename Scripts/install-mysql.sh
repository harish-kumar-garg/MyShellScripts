#!/bin/bash
sudo apt-get update

#install java
sudo apt-get -y install default-jdk

# set up a silent install of MySQL

export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.6 mysql-server/root_password password welcome123 | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password welcome123 | debconf-set-selections

# install the LAMP stack
sudo apt-get -y install mysql-server 

sudo sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

sudo service mysql restart

echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'welcome123'; flush privileges;" | mysql -u root -pwelcome123
echo "create database sonar; commit;" | mysql -u root -pwelcome123 
echo "CREATE USER 'sonar' IDENTIFIED BY 'sonar'; commit;" | mysql -u root -pwelcome123
echo "GRANT ALL ON sonar.* TO 'sonar'@'%' IDENTIFIED BY 'sonar'; commit;" | mysql -u root -pwelcome123
echo "GRANT ALL ON sonar.* TO 'sonar'@'localhost' IDENTIFIED BY 'sonar'; commit; flush privileges;" | mysql -u root -pwelcome123
wget http://dist.sonar.codehaus.org/sonarqube-5.1.zip
sudo apt-get -y install unzip
unzip sonarqube-5.1.zip
sudo mv sonarqube-5.1 /opt/sonar

echo "sonar.jdbc.username=root
sonar.jdbc.password=welcome123
sonar.jdbc.url=jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance
sonar.web.host=127.0.0.1
sonar.web.context=/sonar
sonar.web.port=9000
"> /opt/sonar/conf/sonar.properties;
cat /opt/sonar/conf/sonar.properties;

sudo /opt/sonar/bin/linux-x86-64/sonar.sh start

#install tomcat
sudo mkdir /opt/tomcat
cd /opt/tomcat
sudo wget https://www.apache.org/dist/tomcat/tomcat-7/v7.0.68/bin/apache-tomcat-7.0.68.zip
sudo wget https://www.apache.org/dist/tomcat/tomcat-7/v7.0.68/bin/apache-tomcat-7.0.68.zip.md5
cat apache-tomcat-7.0.68.zip.md5
md5sum apache-tomcat-7.0.68.zip
sudo unzip apache-tomcat-7.0.68.zip
cd apache-tomcat-7.0.68/bin
sudo chmod 777 /opt/tomcat/apache-tomcat-7.0.68/bin/*.sh
sudo ln -s /opt/tomcat/apache-tomcat-7.0.68/bin/startup.sh /usr/bin/tomcatup
 sudo ln -s /opt/tomcat/apache-tomcat-7.0.68/bin/shutdown.sh /usr/bin/tomcatdown
sudo chmod 777 /opt/tomcat/apache-tomcat-7.0.68/logs/
tomcatup

#install sikuli
sudo apt-get update
sudo apt-get -y install sikuli-ide

#install maven
sudo apt-get -y install maven

#install ant
sudo apt-get install ant

#install jenkins
sudo apt-get -y upgrade
sudo apt-get -y install apache2
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get -y install jenkins

# Create folder to place selenium in
#
echo "\r\nCreating folder to place selenium in ...\r\n"
sudo mkdir ~/selenium
cd ~/selenium


# Get Selenium and install headless Java runtime
#
echo "\r\nInstalling Selenium and headless Java runtime ...\r\n"
sudo wget http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar
sudo apt-get install openjdk-7-jre-headless -y


# Install Firefox
#
echo "\r\nInstalling Firefox ...\r\n"
sudo apt-get install firefox -y


# Install headless GUI for firefox.  'Xvfb is a display server that performs graphical operations in memory'
#
echo "\r\nInstalling XVFB (headless GUI for Firefox) ...\r\n"
sudo apt-get install xvfb -y

