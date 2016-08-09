#!bin/bash
sudo su
cd
#installing java and jenkins
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get -y install default-jdk
apt-get -y install jenkins
cd
#installing mysql and sonar

export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.6 mysql-server/root_password password welcome123 | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password welcome123 | debconf-set-selections

# install the LAMP stack
apt-get -y install mysql-server 

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

sudo service mysql restart
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'welcome123'; flush privileges;" | mysql -u root -pwelcome123

echo "CREATE DATABASE sonar CHARACTER SET utf8 COLLATE utf8_general_ci; CREATE USER 'sonar' IDENTIFIED BY 'sonar';GRANT ALL PRIVILEGES ON sonar.* TO 'sonar'@'%' IDENTIFIED BY 'sonar'; GRANT ALL ON sonar.* TO 'sonar'@'localhost' IDENTIFIED BY 'sonar'; flush privileges;" | mysql -u root -pwelcome123

apt-get install -y unzip
unzip sonarqube-5.6.zip
mv sonarqube-5.6 /opt/sonar
ip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
echo "sonar.jdbc.username=sonar" >> /opt/sonar/conf/sonar.properties
echo "sonar.jdbc.password=sonar" >> /opt/sonar/conf/sonar.properties
echo "sonar.jdbc.url=jdbc:mysql://{$ip}:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance" >>/opt/sonar/conf/sonar.properties
echo "sonar.web.host=0.0.0.0" >> /opt/sonar/conf/sonar.properties
echo "sonar.web.context=/sonar" >> /opt/sonar/conf/sonar.properties
echo "sonar.web.port=9000" >> /opt/sonar/conf/sonar.properties
cp /opt/sonar/bin/linux-x86-64/sonar.sh /etc/init.d/sonar
echo "SONAR_HOME=/opt/sonar" >> /etc/init.d/sonar
echo "PLATFORM=linux-x86-64" >> /etc/init.d/sonar
echo "WRAPPER_CMD="${SONAR_HOME}/bin/${PLATFORM}/wrapper"" >> /etc/init.d/sonar
echo "WRAPPER_CONF="${SONAR_HOME}/conf/wrapper.conf"" >> /etc/init.d/sonar
echo "PIDDIR="/var/run"" >> /etc/init.d/sonar
update-rc.d -f sonar remove
chmod 755 /etc/init.d/sonar
update-rc.d sonar defaults
/opt/sonar/bin/linux-x86-64/sonar.sh start
