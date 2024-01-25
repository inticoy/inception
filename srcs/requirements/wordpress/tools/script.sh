# download wordpress
curl -LO https://wordpress.org/latest.tar.gz

# extract from lastest.tar.gz
tar -zxf latest.tar.gz

# move wordpress sources to /var/www/
mkdir /var/www
mkdir /var/www/html
mv /wordpress/* /var/www/html/
