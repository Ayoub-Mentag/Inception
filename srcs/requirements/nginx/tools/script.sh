apt update
apt install nginx -y
apt install openssl -y
apt install curl -y
apt install vim -y

mkdir -p /etc/nginx/ssl

#generate a private key 
openssl genrsa -out /etc/nginx/ssl/private.key 2048

#Create a Certificate Signing Request
openssl req -new -key /etc/nginx/ssl/private.key -out /etc/nginx/ssl/request-certificate.csr -subj "/C=MO/L=KH/O=1337/OU=IT/CN=amentag.42.fr"

#Create the self-signed SSL Certificate
openssl x509 -req -days 365 -in /etc/nginx/ssl/request-certificate.csr -signkey /etc/nginx/ssl/private.key -out /etc/nginx/ssl/my-certificate.crt
