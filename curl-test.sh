#!/bin/bash

# Define variables
URL="http://localhost:5000/api/timeline_post"
GET_URL="http://localhost:5000/api/timeline_post"
DELETE_URL="http://localhost:5000/api/delete_timeline_post"
NAME="Chizaram"
EMAIL="chizy7@outlook.com"
CONTENT=$(openssl rand -hex 16)

# Create timeline post using POST endpoint
curl -X POST $URL -d "name=$NAME&email=$EMAIL&content=$CONTENT"

# Check if the timeline post was added using GET endpoint
GET_RESPONSE=$(curl $GET_URL)
if [[ $GET_RESPONSE == *"\"content\":\"$CONTENT\""* ]]; then
  echo "Timeline post was added successfully"
else
  echo "Error: Timeline post was not added"
  exit 1
fi

# Delete the test timeline using post using DELETE endpoint
TIMELINE_POST_ID=$(echo $GET_RESPONSE | jq '.timeline_posts[0].id')
curl -X DELETE $DELETE_URL/$TIMELINE_POST_ID

# Check if the timeline post was deleted using GET endpoint
GET_RESPONSE=$(curl $GET_URL)
if [[ $GET_RESPONSE == *"\"id\":$TIMELINE_POST_ID"* ]]; then
  echo "Error: Timeline post was not deleted"
  exit 1
else
  echo "Timeline post was deleted successfully"
fi
