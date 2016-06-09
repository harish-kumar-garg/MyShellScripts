#install Tomcat
mkdir /opt/tomcat
cd /opt/tomcat
wget http://www.interior-dsgn.com/apache/tomcat/tomcat-8/v8.5.2/bin/apache-tomcat-8.5.2.zip
wget https://www.apache.org/dist/tomcat/tomcat-8/v8.5.2/bin/apache-tomcat-8.5.2.zip.md5
cat apache-tomcat-8.5.2.zip.md5
md5sum apache-tomcat-8.5.2.zip
unzip apache-tomcat-8.5.2.zip
cd apache-tomcat-8.5.2/bin
chmod 700 /opt/tomcat/apache-tomcat-8.5.2/bin/*.sh
cd /opt/tomcat/apache-tomcat-8.5.2/bin/ 
./startup.sh
