#!/bin/bash
apt-get update
wget -qO- https://get.docker.com/ | sh
#Run Docker
docker run --name sonar1 -d -p 9000:9000 -e DB_USER=sonar -e DB_PWD=sonar -e DB_URL=orchardmysql.southeastasia.cloudapp.azure.com -e DB_PORT=3306  preetick/sonar-devops:v18


