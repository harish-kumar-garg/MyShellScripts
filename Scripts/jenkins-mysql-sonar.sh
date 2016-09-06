#!bin/bash
cd
#installing java
sudo apt-get update
#install oracle java
mkdir /opt/java 
cd /opt/java 
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz"
tar -zxvf jdk-8u45-linux-x64.tar.gz
cd jdk1.8.0_45/
update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_45/bin/java 100
update-alternatives --config java
update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_45/bin/javac 100
update-alternatives --config javac
update-alternatives --install /usr/bin/jar jar /opt/java/jdk1.8.0_45/bin/jar 100
update-alternatives --config jar
export JAVA_HOME=/opt/java/jdk1.8.0_45/
export JRE_HOME=/opt/java/jdk1.8.0_45/jre
export PATH=$PATH:/opt/java/jdk1.8.0_45/bin:/opt/java/jdk1.8.0_45/jre/bin
#installing jenkins
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get -y install jenkins
cd
#installing mysql and sonar
export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.6 mysql-server/root_password password welcome123 | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password welcome123 | debconf-set-selections

# install the LAMP stack
sudo apt-get -y install mysql-server 

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

sudo service mysql restart
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'welcome123'; flush privileges;" | mysql -u root -pwelcome123

echo "CREATE DATABASE sonar CHARACTER SET utf8 COLLATE utf8_general_ci; CREATE USER 'sonar' IDENTIFIED BY 'sonar';GRANT ALL PRIVILEGES ON sonar.* TO 'sonar'@'%' IDENTIFIED BY 'sonar'; GRANT ALL ON sonar.* TO 'sonar'@'localhost' IDENTIFIED BY 'sonar'; flush privileges;" | mysql -u root -pwelcome123

wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.6.zip
sudo apt-get install -y unzip
unzip sonarqube-5.6.zip
sudo mv sonarqube-5.6 /opt/sonar
IP="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
echo 'sonar.jdbc.username=sonar' >> /opt/sonar/conf/sonar.properties
echo 'sonar.jdbc.password=sonar' >> /opt/sonar/conf/sonar.properties
echo "sonar.jdbc.url=jdbc:mysql://${IP}:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance" >>/opt/sonar/conf/sonar.properties
echo 'sonar.web.host=0.0.0.0' >> /opt/sonar/conf/sonar.properties
echo 'sonar.web.context=/sonar' >> /opt/sonar/conf/sonar.properties
echo 'sonar.web.port=9000' >> /opt/sonar/conf/sonar.properties
cp /opt/sonar/bin/linux-x86-64/sonar.sh /etc/init.d/sonar
echo 'SONAR_HOME='/opt/sonar'' >> /etc/init.d/sonar
echo 'PLATFORM='linux-x86-64'' >> /etc/init.d/sonar
sudo sed -i -e"s/^WRAPPER_CMD\s*=\s*./wrapper/WRAPPER_CMD = ${SONAR_HOME}/bin/${PLATFORM}/wrapper" /etc/init.d/sonar
sudo sed -i -e"s/^WRAPPER_CONF\s*=\s*../../conf/wrapper.conf/WRAPPER_CONF = ${SONAR_HOME}/conf/wrapper.conf" /etc/init.d/sonar
sudo sed -i -e"s/^PIDDIR\s*=\s*./PIDDIR = /var/run/" /etc/init.d/sonar
sudo update-rc.d -f sonar remove
sudo chmod 755 /etc/init.d/sonar
sudo update-rc.d sonar defaults
sudo /opt/sonar/bin/linux-x86-64/sonar.sh start
