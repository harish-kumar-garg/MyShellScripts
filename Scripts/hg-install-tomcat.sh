#!bin/bash
# install Tomcat
sudo su
apt-get update
apt-get install -y default-jdk
cd
mkdir /opt/tomcat
cd /opt/tomcat
wget https://www.apache.org/dist/tomcat/tomcat-8/v8.5.6/bin/apache-tomcat-8.5.6.zip
wget https://www.apache.org/dist/tomcat/tomcat-8/v8.5.6/bin/apache-tomcat-8.5.6.zip.md5
cat apache-tomcat-8.5.6.zip.md5
md5sum apache-tomcat-8.5.6.zip
apt-get install unzip
unzip apache-tomcat-8.5.6.zip
cd apache-tomcat-8.5.6/bin
chmod 700 /opt/tomcat/apache-tomcat-8.5.6/bin/*.sh
cd /opt/tomcat/apache-tomcat-8.5.6/bin/
./startup.sh
