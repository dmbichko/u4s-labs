# Use Node.js for building
FROM node:22.9.0-alpine AS build

# Set working directory
WORKDIR /app

# Install npm 10.8.3 explicitly
RUN npm install -g npm@10.8.3

# Copy dependencies files
COPY package*.json ./

# Install dependencies
RUN npm ci --progress=true

# Copy the rest of the application
COPY . .

# Set environment variables for build
ARG REACT_APP_API_URL
ARG REACT_APP_API_PORT
ENV REACT_APP_API_URL=$REACT_APP_API_URL
ENV REACT_APP_API_PORT=$REACT_APP_API_PORT

# Build the application
RUN npm run build --progress=true

# Use Nginx for serving static files
FROM nginx:alpine AS stage-1

# Add SSL support
RUN apk add --no-cache openssl
COPY ./docker/init-ssl.sh /docker-entrypoint.d/20-init-ssl.sh
RUN chmod +x /docker-entrypoint.d/20-init-ssl.sh

# Copy the built frontend
COPY --from=build /app/build /usr/share/nginx/html

# Configure Nginx
COPY ./docker/nginx.conf.template /etc/nginx/conf.d/default.conf.template

# Add SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Expose ports
EXPOSE 80 443
