#installing Apache HTTP2
sudo apt-get update
sudo apt-get install -y apache2
sudo useradd nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo apt-get install -y build-essential libgd2-xpm-dev openssl libssl-dev xinetd apache2-utils unzip
curl -L -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz
tar xvf nagios-*.tar.gz
cd nagios-*
./configure --with-nagios-group=nagios --with-command-group=nagcmd 
make all
sudo make install
sudo make install-commandmode
sudo make install-init
sudo make install-config
sudo /usr/bin/install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-available/nagios.conf
sudo usermod -G nagcmd www-data
cd ~
curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz
tar xvf nagios-plugins-*.tar.gz
cd nagios-plugins-*
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make
sudo make install
tar xvf nrpe-*.tar.gz
cd nrpe-*
./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu
make all
sudo make install
sudo make install-xinetd
sudo make install-daemon-config

sudo service xinetd restart
echo 'cfg_dir=/usr/local/nagios/etc/servers' >> /usr/local/nagios/etc/nagios.cfg
sudo mkdir /usr/local/nagios/etc/servers
