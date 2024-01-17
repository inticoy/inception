# !/bin/bash

# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out $CERTS_ -subj "/C=MO/L=KH/O=1337/OU=student/CN=gyoon.42.ma"
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
    -subj "/C=GB/ST=London/L=London/O=Global Security/OU=R&D Department/CN=example.com" \
    -keyout /cert.key  -out /cert.crt

echo "
server {
	listen 443 ssl;
	listen [::]:443 ssl;
	server_name www.gyoon.42.fr gyoon.42.fr;

    ssl_protocols TLSv1.2 TLSv1.3;
	ssl_certificate /cert.crt;
	ssl_certificate_key /cert.key;

	location / {
		proxy_pass https://www.google.com;
	}

    # listen 443 ssl;
    # listen [::]:443 ssl;
    # ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    # ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    # index index.php;
    # root /var/www/html;
    # location ~ [^/]\.php(/|$) { 
    #         try_files $uri =404;
    #     }
}
" >  /etc/nginx/sites-available/default

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default