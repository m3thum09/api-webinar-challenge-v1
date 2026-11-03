#!/bin/bash
TEAM_TAG=$1
DOCKERHUB_USER=$2

echo "Testing Submission for $TEAM_TAG by $DOCKERHUB_USER..."

docker pull $DOCKERHUB_USER/api-frontend:$TEAM_TAG
docker pull $DOCKERHUB_USER/api-backend:$TEAM_TAG

if [ $? -ne 0 ]; then
    echo "FAIL: Docker images not found on Docker Hub"
    exit 1
fi

DOCKERHUB_USER=$DOCKERHUB_USER TEAM_TAG=$TEAM_TAG docker-compose up -d

sleep 10

BACKEND_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000/api/health)
FRONTEND_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)

docker-compose down -v

if [ "$BACKEND_CODE" -eq 200 ] && [ "$FRONTEND_CODE" -eq 200 ]; then
    echo "SUCCESS: All Health Checks Passed!"
    exit 0
else
    echo "FAIL: Health checks failed with Backend Code $BACKEND_CODE and Frontend Code $FRONTEND_CODE"
    exit 1
fi