#install Tomcat
sudo su
apt-get update
apt-get install -y default-jdk
cd
mkdir /opt/tomcat
cd /opt/tomcat
wget https://www.apache.org/dist/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.zip
wget https://www.apache.org/dist/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.zip.md5
cat apache-tomcat-8.5.4.zip.md5
md5sum apache-tomcat-8.5.4.zip
unzip apache-tomcat-8.5.4.zip
cd apache-tomcat-8.5.4/bin
chmod 700 /opt/tomcat/apache-tomcat-8.5.4/bin/*.sh
cd /opt/tomcat/apache-tomcat-8.5.4/bin/ 
./startup.sh
