#!/bin/bash

PASSWORD="put password here"
DATABASE_NAME="put database name here"

yum install httpd mod_ssl mysql-server mysql php-mysql gcc perl* mod_perl-devel perl-CPAN
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
service iptables save
service httpd start
chkconfig httpd on
chkconfig mysqld on
service start mysqld
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$PASSWORD');"



wget http://ftp.mozilla.org/pub/mozilla.org/webtools/bugzilla-4.5.2.tar.gz
tar zxvf bugzilla-4.5.2.tar.gz -C /var/www/html/
cd /var/www/html/
mv -v bugzilla-4.4 bugzilla
mysql -u root -p -e "create database bugzilla_DB;"
mysql -u root -p -e "grant all on bugzilla_DB.* to bugz@localhost identified by '$DATABASE_NAME';"

./checksetup.pl
/usr/bin/perl install-module.pl --all
./checksetup.pl

sed -i "s/^db_name\(.*\)$/^db_name = $DATABASE_NAME$/g" ./localconfig

sed -i "s/^db_pass\(.*\)$/^db_pass = $DATABASE_NAME$/g" ./localconfig



echo /etc/httpd/conf/httpd.conf << EOF
<VirtualHost *:80>
     DocumentRoot /var/www/html/bugzilla/
</VirtualHost>
 
<Directory /var/www/html/bugzilla>
     AddHandler cgi-script .cgi
     Options +Indexes +ExecCGI
     DirectoryIndex index.cgi
     AllowOverride Limit FileInfo Indexes
</Directory>
EOF


service httpd restart
