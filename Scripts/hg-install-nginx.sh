#!bin/bash
# install nginx server
apt-get update -y 
apt-get install gcc -y
apt-get install make -y
apt-get install build-essential -y
apt-get install libssl-dev -y
cd /opt
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.gz
tar -zxf pcre-8.39.tar.gz
cd pcre-8.39
./configure
make
sudo make install
cd /opt
wget http://zlib.net/zlib-1.2.8.tar.gz
tar -zxf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
make
sudo make install
cd /opt
wget http://nginx.org/download/nginx-1.10.2.tar.gz
tar zxf nginx-1.10.2.tar.gz
cd nginx-1.10.2
./configure --sbin-path=/usr/local/nginx/nginx --conf-path=/usr/local/nginx/nginx.conf --pid-path=/usr/local/nginx/nginx.pid --with-http_ssl_module --with-stream --with-pcre=../pcre-8.39 --with-zlib=../zlib-1.2.8 --without-http_empty_gif_module
make
sudo make install
cd /usr/local/nginx
./nginx
