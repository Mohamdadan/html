#!/bin/bash

# Stop all running containers
echo "Stopping all running containers..."
docker stop $(docker ps -q) 2>/dev/null

# Remove all containers (both running and stopped)
echo "Removing all containers..."
docker rm $(docker ps -aq) 2>/dev/null

echo "All containers have been stopped and removed."
