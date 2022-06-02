echo "Wait until DB Service Connects"
sleep 10;
if  [ ! -f /var/www/wordpress/wp-config.php ]; then     
    echo "WP Core Downloaded"
    sleep 5;
    while  [ ! -f /var/www/wordpress/wp-config.php ]; do   
        wp core config --allow-root --dbname=wordpress --dbuser=$DBASE_LOGIN --dbpass=$DBASE_PSWD --dbhost=mysql:3306
    done
    echo "Creating Users"
    wp core install --allow-root  --title='mlizzie Inception' --admin_user=$WP_USER1_LOGIN --admin_password=$WP_USER1_PSWD  --admin_email="mlizzie@gmail.com" --path='/var/www/wordpress';
    wp user create --allow-root $WP_USER2_LOGIN user2@user.com --user_pass=$WP_USER2_PSWD --role=author
fi

php-fpm7.3 --nodaemonize
php -S 0.0.0.0:5050 -t /var/www/wordpress/
