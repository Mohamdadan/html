#!/bin/bash
image="mohamedadan4323/pro1:v6"
containername="LMS"
# Navigate to the repository directory
cd /root/repos/html || { echo "Failed to change directory to /root/repos/html"; exit 1; }

# Fetch and pull the latest changes from the origin
git fetch origin || { echo "Failed to fetch from origin"; exit 1; }
git pull origin || { echo "Failed to pull from origin"; exit 1; }

# Build the Docker image
docker build -t $image .  

docker run -d -p 80:80 --name $containername   $image

echo "Script completed successfully"
