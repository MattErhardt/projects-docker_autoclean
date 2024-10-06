#!/bin/bash

# Remove dangling images
echo "Removing dangling images..."
docker image prune -f

# Remove all unused images
echo "Removing unused images..."
docker image prune -af

# Optional: remove unused volumes and networks
echo "Removing unused volumes and networks..."
docker system prune -af

echo "Docker cleanup completed."
