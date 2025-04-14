#!/bin/bash

set -e
date
echo "Updating Python application on VM..."

APP_DIR="/home/azureuser/stage6.5"
REPO_URL="https://github.com/azooooz2021/stage6.5.git"
BRANCH="master"
GITHUB_TOKEN=$GITHUB_TOKEN

# Update code
if [ -d "$APP_DIR" ]; then
    sudo -u azureuser bash -c "cd $APP_DIR && git pull origin $BRANCH"
else
    sudo -u azureuser git clone -b $BRANCH "https://${GITHUB_TOKEN}@${REPO_URL}"
    sudo -u azureuser bash -c "cd $APP_DIR"
fi

# Install dependencies
sudo -u azureuser /home/azureuser/stage6.5/venv/bin/pip install --upgrade pip
sudo -u azureuser /home/azureuser/stage6.5/venv/bin/pip install -r ${APP_DIR}/requirements.txt


# Restart the service
sudo systemctl restart backend
sudo systemctl restart frontend

echo "Python application update completed!"