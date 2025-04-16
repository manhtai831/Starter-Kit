#!/bin/sh

docker-compose up -d --build

# Delete all image dangling
docker rmi $(docker images -f "dangling=true" -q)

# Copy dist to host
docker cp fe:/app/dist/ ./

# Down service avoid appropriate resource
docker-compose down

APP_NAME=digi-gold-app

# Remove existed app
docker exec -it card_nginx rm -rf /usr/share/nginx/html/$APP_NAME

# Move app from host to nginx
docker cp dist/ card_nginx:/usr/share/nginx/html/$APP_NAME

echo "Done!"
