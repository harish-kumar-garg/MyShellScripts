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
export JRE_HOME=/opt/java/jdk1.8.0._45/jre
export PATH=$PATH:/opt/java/jdk1.8.0_45/bin:/opt/java/jdk1.8.0_45/jre/bin
java -version

#install Tomcat
cd /opt/tomcat
wget http://www.interior-dsgn.com/apache/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.zip
wget https://www.apache.org/dist/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.zip.md5
cat apache-tomcat-8.0.29.zip.md5
md5sum apache-tomcat-8.0.29.zip
unzip apache-tomcat-8.0.29.zip
cd apache-tomcat-8.0.29/bin
chmod 700 /opt/Tomcat/apache-tomcat-8.0.29/bin/*.sh
cd /opt/Tomcat/apache-tomcat-8.0.29/bin/ 
./startup.sh
curl -i localhost:8080
