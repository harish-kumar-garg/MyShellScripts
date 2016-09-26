#!bin/bash
cd
#installing java
sudo apt-get update
#install oracle java
sudo mkdir /opt/java
cd /opt/java 
sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz"
sudo tar -zxvf jdk-8u45-linux-x64.tar.gz
cd jdk1.8.0_45/
sudo update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_45/bin/java 1080
sudo update-alternatives --config java
sudo update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_45/bin/javac 1079
sudo update-alternatives --config javac
sudo update-alternatives --install /usr/bin/jar jar /opt/java/jdk1.8.0_45/bin/jar 1078
sudo update-alternatives --config jar
export JAVA_HOME=/opt/java/jdk1.8.0_45/
export JRE_HOME=/opt/java/jdk1.8.0_45/jre
export PATH=$PATH:/opt/java/jdk1.8.0_45/bin:/opt/java/jdk1.8.0_45/jre/bin
java -version
#installing jenkins
cd
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install jenkins
# install sonarqube
cd
wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-6.0.zip
sudo apt-get install -y unzip
unzip sonarqube-6.0.zip
sudo mv sonarqube-6.0 /opt/sonar
# IP="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
echo '' >> /opt/sonar/conf/sonar.properties
echo 'sonar.jdbc.username=sonar' >> /opt/sonar/conf/sonar.properties
echo 'sonar.jdbc.password=sonar' >> /opt/sonar/conf/sonar.properties
# echo "sonar.jdbc.url=jdbc:mysql://${IP}:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance" >>/opt/sonar/conf/sonar.properties
echo "sonar.jdbc.url=jdbc:mysql://10.0.4.8:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance" >>/opt/sonar/conf/sonar.properties
echo 'sonar.web.host=0.0.0.0' >> /opt/sonar/conf/sonar.properties
echo 'sonar.web.context=/sonar' >> /opt/sonar/conf/sonar.properties
echo 'sonar.web.port=9000' >> /opt/sonar/conf/sonar.properties
sudo cp /opt/sonar/bin/linux-x86-64/sonar.sh /etc/init.d/sonar
sudo chmod 777 /etc/init.d/sonar
echo '' >> /etc/init.d/sonar
echo 'SONAR_HOME='/opt/sonar'' >> /etc/init.d/sonar
echo 'PLATFORM='linux-x86-64'' >> /etc/init.d/sonar
sudo sed -i 's/WRAPPER_CMD=".\/wrapper"/WRAPPER_CMD="\${SONAR_HOME}\/bin\/\${PLATFORM}\/wrapper"/g' /etc/init.d/sonar
sudo sed -i -e' s/WRAPPER_CONF="..\/..\/conf\/wrapper.conf"/WRAPPER_CONF="\${SONAR_HOME}\/conf\/wrapper.conf"/g' /etc/init.d/sonar
sudo sed -i -e 's/PIDDIR="."/PIDDIR="\/var\/run"/g' /etc/init.d/sonar
sudo update-rc.d -f sonar remove
sudo chmod 755 /etc/init.d/sonar
sudo update-rc.d sonar defaults
sudo /opt/sonar/bin/linux-x86-64/sonar.sh start
