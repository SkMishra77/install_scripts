#!/bin/bash

# Update package index
echo "Updating package index..."
sudo apt-get update -y

# Install necessary dependencies
echo "Installing necessary dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable Docker repository
echo "Setting up Docker repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package index again after adding the Docker repository
echo "Updating package index after adding Docker repository..."
sudo apt-get update -y

# Install Docker CE (Community Edition)
echo "Installing Docker..."
sudo apt-get install -y docker-ce

# Start Docker and enable it to start at boot
echo "Starting Docker and enabling it to start at boot..."
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to the 'docker' group to use Docker without sudo
echo "Adding your user to the Docker group..."
sudo usermod -aG docker $USER

# Install Docker Compose
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION="1.29.2"
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the Docker Compose binary
echo "Applying executable permissions to Docker Compose..."
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Verify Docker Compose installation
echo "Verifying Docker Compose installation..."
docker-compose --version

# Inform user to log out and log back in
echo "Docker and Docker Compose have been installed successfully."
echo "You need to log out and log back in for the group changes to take effect."
