FROM debian:bullseye

COPY ./tools/script.sh /
RUN ./script.sh
COPY conf/nginx.conf /etc/nginx/nginx.conf


EXPOSE 443
CMD ["nginx" ,"-g", "daemon off;"];