FROM debian:bullseye

COPY ./tools/script.sh /
RUN  ./script.sh
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

RUN chown -R www-data:www-data /var/www/html
# RUN chown -R www-data:www-data /etc/nginx/ssl
# RUN chown -R www-data:www-data /run

EXPOSE 443

ENTRYPOINT ["nginx" ,"-g", "daemon off;"];