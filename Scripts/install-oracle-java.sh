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
java -version

cd

#install Tomcat
sudo mkdir /opt/tomcat
cd /opt/tomcat && wget http://www.interior-dsgn.com/apache/tomcat/tomcat-8/v8.5.2/bin/apache-tomcat-8.5.2.zip
cd /opt/tomcat && wget https://www.apache.org/dist/tomcat/tomcat-8/v8.5.2/bin/apache-tomcat-8.5.2.zip.md5
sudo cat /opt/tomcat/apache-tomcat-8.5.2.zip.md5
md5sum /opt/tomcat/apache-tomcat-8.5.2.zip
sudo unzip /opt/tomcat/apache-tomcat-8.5.2.zip
cd /opt/tomcat/apache-tomcat-8.5.2/bin
sudo chmod 700 /opt/tomcat/apache-tomcat-8.5.2/bin/*.sh
cd /opt/tomcat/apache-tomcat-8.5.2/webapps && wget https://adidaswarstorage.blob.core.windows.net/warfileupload/MyArenaREST.war
cd /opt/tomcat/apache-tomcat-8.5.2/bin/ 
sudo sh /opt/tomcat/apache-tomcat-8.5.2/bin/startup.sh
