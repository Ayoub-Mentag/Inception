FROM debian:bullseye

COPY ./tools/script.sh /
RUN  ./script.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx" ,"-g", "daemon off;"];