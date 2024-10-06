#!/bin/bash

# Remove dangling images
echo "Removing dangling images..." >> /volume1/docker/projects-docker_autoclean/cleanup.log
docker image prune -f >> /volume1/docker/projects-docker_autoclean/cleanup.log 2>&1

# Remove all unused images
echo "Removing unused images..." >> /volume1/docker/projects-docker_autoclean/cleanup.log
docker image prune -af >> /volume1/docker/projects-docker_autoclean/cleanup.log 2>&1

# Optional: remove unused volumes and networks
echo "Removing unused volumes and networks..." >> /volume1/docker/projects-docker_autoclean/cleanup.log
docker system prune -af >> /volume1/docker/projects-docker_autoclean/cleanup.log 2>&1

echo "Docker cleanup completed." >> /volume1/docker/projects-docker_autoclean/cleanup.log
