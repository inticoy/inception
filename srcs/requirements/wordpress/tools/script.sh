mkdir /var/www
mkdir /var/www/html

cd /tmp
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html
rm -rf *

wp core download --allow-root

wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --allow-root

wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USERNAME --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_MAIL --skip-email --allow-root

wp user create $WP_USER_NAME $WP_USER_MAIL --user_pass=$WP_USER_PASS --allow-root

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

mkdir /run/php

/usr/sbin/php-fpm7.4 -F
