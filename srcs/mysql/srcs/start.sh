#! /bin/sh
if [ ! -d "/var/lib/mysql/wordpress" ]; then 
    mariadb-install-db -u root
    mysqld -u root & sleep 5
    mysql -u root --execute="CREATE DATABASE wordpress;"
    mysql -u root --execute="CREATE USER '${DBASE_LOGIN}'@'%' IDENTIFIED BY '${DBASE_PSWD}'; GRANT ALL PRIVILEGES ON *.* TO '${DBASE_LOGIN}'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"
    telegraf & sleep infinite
fi
mysqld_safe & telegraf