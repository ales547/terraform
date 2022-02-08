#!bin/bash
yum -y update
yum -y install httpd
echo "<h2>WebServer with ip: $(hostname -f)</h2><br>Built with Terraform using external script!" > var/www/html/index.html
sudo service httpd start
chkconfig httpd on
