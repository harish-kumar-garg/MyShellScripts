
# myscripts
#!/bin/bash
apt-get update
wget -qO- https://get.docker.com/ | sh


docker run --name nginx_devops -d -p 80:80 -e NGINX_ADDR=orchard.southeastasia.cloudapp.azure.com -e JENKINS_ADDR=orchardjenkins.southeastasia.cloudapp.azure.com -e SONAR_ADDR=orchardsonar.southeastasia.cloudapp.azure.com preetick/nginx-devops:v13

