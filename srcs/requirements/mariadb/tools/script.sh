# allow other container can access mariadb
mv /etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server-default.cnf
cat /etc/mysql/mariadb.conf.d/50-server-default.cnf | sed 's/127.0.0.1/0.0.0.0/' > /etc/mysql/mariadb.conf.d/50-server.cnf

# start a mariadb process
service mariadb start

# 있으나 없으나 왜 에러가 나지
#gyoon-mariadb  | /usr/bin/mysqladmin: connect to server at 'localhost' failed
#gyoon-mariadb  | error: 'Can't connect to local MySQL server through socket '/run/mysqld/mysqld.sock' (2)'
#gyoon-mariadb  | Check that mysqld is running and that the socket: '/run/mysqld/mysqld.sock' exists!
# while ! mysqladmin ping;
# do
# 	sleep 2
# done

# make a database
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" | mariadb -u root

# make a mariadb user
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" | mariadb -u root

# grant all privileges to user on database : user can perform all operations (SELECT, INSERT, ...) on tables within $DB_NAME
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';" | mariadb -u root

# reload/apply new privilege tables immediately
echo "FLUSH PRIVILEGES;" | mariadb -u root

# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root12345';" | mariadb -u root 

service mariadb stop

mysqld