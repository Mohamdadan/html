# Use the official NGINX image as a base
FROM nginx:latest

# Copy the index.html file to the NGINX HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Run NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
