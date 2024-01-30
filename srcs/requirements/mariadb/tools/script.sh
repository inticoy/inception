service mariadb start

echo "CREATE DATABASE wordpress;"
echo "CREATE DATABASE wordpress;"| mariadb
echo "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';" | mariadb
echo "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost';" | mariadb
echo "FLUSH PRIVILEGES;" | mariadb