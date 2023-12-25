apt update && apt upgrade
apt install nginx -y
apt install openssl -y
apt install curl -y
apt install vim -y

mkdir -p /etc/nginx/ssl

export PRIV_KEY_PATH=/etc/nginx/ssl/private.key
export CERT_REQ_PATH=/etc/nginx/ssl/request-certificate.csr
export CERT_PATH=/etc/nginx/ssl/my-certificate.crt


#generate a private key 
openssl genrsa -out $PRIV_KEY_PATH 2048

#Create a Certificate Signing Request
openssl req -new -key $PRIV_KEY_PATH -out $CERT_REQ_PATH -subj "/C=MO/L=KH/O=1337/OU=student/CN=amentag.42.ma"

#Create the self-signed SSL Certificate
openssl x509 -req -days 365 -in $CERT_REQ_PATH -signkey $PRIV_KEY_PATH -out $CERT_PATH
