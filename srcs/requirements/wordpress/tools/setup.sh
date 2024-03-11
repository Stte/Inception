#! /bin/sh

echo "Wait for MariaDB to be ready"
attempts=0
while ! mariadb -h$MARIADB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE >/dev/null 2>&1; do
	attempts=$((attempts + 1))
    echo "MariaDB unavailable. Attempt $attempts: Trying again in 5 sec."
    sleep 5
done
echo "MariaDB connection established!"

if [ -f "wp-config.php" ]; then
	echo "WordPress: already installed"
else
	wp core download --allow-root

	wp config create --allow-root \
		--dbhost=${MARIADB_HOST} \
		--dbname=${MARIADB_DATABASE} \
		--dbuser=${MARIADB_USER} \
		--dbpass=${MARIADB_PASSWORD}

	wp core install --allow-root \
		--url=tspoof.42.fr \
		--title=${WP_TITLE} \
		--admin_user=${WP_ADMIN_USER} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL} \
		--skip-email

	wp user create --allow-root \
		${WP_USER} ${WP_EMAIL} \
		--role=${WP_ROLE} \
		--user_pass=${WP_PASSWORD}

	wp theme install --allow-root fluida
	wp theme activate --allow-root fluida

	chown -R www-data:www-data /var/www/html
	chmod -R 775 /var/www/html

	echo Finished installation and setup!
fi

/usr/sbin/php-fpm7.4 -R -F
