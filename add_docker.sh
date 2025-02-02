#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo"
    exit 1
fi

# Check if username is provided
if [ $# -eq 0 ]; then
    echo "Please provide a username"
    echo "Usage: $0 username"
    exit 1
fi

USERNAME=$1

# Check if user exists
if ! id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME does not exist"
    exit 1
fi

# Check if docker group exists, if not create it
if ! getent group docker >/dev/null; then
    echo "Creating docker group..."
    groupadd docker
fi

# Add user to docker group
usermod -aG docker $USERNAME
newgrp docker

# Verify the addition
if groups $USERNAME | grep &>/dev/null '\bdocker\b'; then
    echo "Successfully added $USERNAME to docker group"
    echo "Please log out and log back in for changes to take effect"
else
    echo "Failed to add $USERNAME to docker group"
    exit 1
fi