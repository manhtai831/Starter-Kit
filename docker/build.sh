# Delete all image, network, container dangling & unused
# docker system prune -af
docker-compose up -d --build

# Delete all image dangling
docker rmi $(docker images -f "dangling=true" -q)
