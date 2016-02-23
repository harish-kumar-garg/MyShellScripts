# myscripts
#!/bin/bash
apt-get update
wget -qO- https://get.docker.com/ | sh

chmod 777 /home/orchard
docker run --name myjenkins -d -p 8080:8080 -p 50000:50000 -v /home/orchard/jen:/var/jenkins_home preetick/jenkins-devops:v5
