#!/bin/sh

# Use environment variable or default to testwebsite
DOMAIN_NAME=${DOMAIN_NAME:-testwebsite}

echo "Initializing SSL certificates for ${DOMAIN_NAME}..."

# Generate SSL certificates if they don't exist
if [ ! -f /etc/nginx/ssl/selfsigned.crt ]; then
    echo "Generating new SSL certificates..."
    mkdir -p /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/selfsigned.key \
        -out /etc/nginx/ssl/selfsigned.crt \
        -subj "/CN=${DOMAIN_NAME}"

    echo "Generating DHParam..."
    openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048
    
    echo "SSL certificate generation complete."
else
    echo "SSL certificates already exist, skipping generation."
fi

# Replace environment variables in nginx config
echo "Generating nginx configuration..."
envsubst '$DOMAIN_NAME' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# Verify nginx configuration
echo "Verifying nginx configuration..."
nginx -t

echo "Initialization complete."
