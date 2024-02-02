# !/bin/bash
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
	-keyout $SSL_KEY_PATH  -out $SSL_CRT_PATH -subj "$SSL_SUBJECT"

echo "
server {
    index index.php;
    root /var/www/html/;

	listen 443 ssl;
	listen [::]:443 ssl;

    ssl_protocols TLSv1.3;
	ssl_certificate $SSL_CRT_PATH;
	ssl_certificate_key $SSL_KEY_PATH; "  > /etc/nginx/sites-available/default

echo '
	location ~ [^/]\.php(/|$) {
		try_files $uri =404;
        include fastcgi_params;
        fastcgi_pass wordpress:9000;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

    }
}
' >> /etc/nginx/sites-available/default 

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

nginx -g "daemon off;"