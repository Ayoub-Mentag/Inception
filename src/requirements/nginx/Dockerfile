FROM alpine

# Install Nginx
RUN apk update && apk add nginx

# Copy the Nginx config
COPY conf /etc/nginx/sites-available/conf

# Expose the port for access
EXPOSE 80/tcp

# Run the Nginx server
CMD ["nginx", "-g", "daemon off;"]
