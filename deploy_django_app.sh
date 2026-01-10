#!/bin/bash

# Deploy a Django app and handle errors

# Function to clone the Django app code
code_clone() {
    echo "Cloning the Django app..."
    if [ -d "django-notes-app" ]; then
        echo "The code directory already exists. Skipping clone."
    else
        git clone https://github.com/LondheShubham153/django-notes-app.git || {
            echo "Failed to clone the code."
            return 1
        }
    fi
}

# Function to install required dependencies
install_requirements() {
    echo "Installing dependencies..."
    sudo apt-get update && sudo apt-get install -y docker.io nginx docker-compose || {
        echo "Failed to install dependencies."
        return 1
    }
}

# Function to perform required restarts
required_restarts() {
    echo "Performing required restarts..."
    sudo chown "$USER" /var/run/docker.sock || {
        echo "Failed to change ownership of docker.sock."
        return 1
    }

    # Uncomment the following lines if needed:
    # sudo systemctl enable docker
    # sudo systemctl enable nginx
    # sudo systemctl restart docker
}

# Function to deploy the Django app
deploy() {
    echo "Building and deploying the Django app..."
    docker build -t notes-app . && docker-compose up -d || {
	    #docker run -d -p 8000:8000 notes-app:latest
        echo "Failed to build and deploy the app."
        return 1
    }
}

# Main deployment script
echo "********** DEPLOYMENT STARTED *********"

# Clone the code
if ! code_clone; then
    echo "the code directory already exists"	
    cd django-notes-app || exit 1
fi

# Install dependencies
if ! install_requirements; then
    echo "Installation failed"  	
    exit 1
fi

# Perform required restarts
if ! required_restarts; then
    echo "System fault identified" 
    exit 1
fi

# Deploy the app
if ! deploy; then
    echo "Deployment failed. Mailing the admin..."
    # Add your sendmail or notification logic here
    exit 1
fi

echo "********** DEPLOYMENT DONE *********"

#Verification Steps : 
#docker ps
#open port 8080 in security group
#login with privateIP:8080
# #line in code if you don't want restart the docker everytime
