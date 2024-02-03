# allow other container can access mariadb
mv /etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server-default.cnf
cat /etc/mysql/mariadb.conf.d/50-server-default.cnf | sed 's/127.0.0.1/0.0.0.0/' > /etc/mysql/mariadb.conf.d/50-server.cnf

# start a mariadb process
service mariadb start

sleep 2

# make a database
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" | mariadb -u root

# make a mariadb user
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" | mariadb -u root

# grant all privileges to user on database : user can perform all operations (SELECT, INSERT, ...) on tables within $DB_NAME
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';" | mariadb -u root

# reload/apply new privilege tables immediately
echo "FLUSH PRIVILEGES;" | mariadb -u root

# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '1234';" | mariadb -u root 

service mariadb stop

mysqld