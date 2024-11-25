#!/bin/bash

# Variables
RUN_ID=${GITHUB_RUN_ID}
REPO=${GITHUB_REPOSITORY}
TOKEN=${MY_TOKEN}


echo "$REPO"



# API call to fetch logs
curl -H "Authorization: token ${TOKEN}" \
     -H "Accept: application/vnd.github.v3+json" \
     -L \
     "https://api.github.com/repos/${REPO}/actions/runs/${RUN_ID}/logs" \
     -o workflow-logs.txt


chmod -x workflow-logs.txt
cat workflow-logs.txt