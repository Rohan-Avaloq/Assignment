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
     "https://github.com/Rohan-Avaloq/Assignment/actions/runs/12009335708/job/33473838312/logs" \
     -o workflow-logs.txt


chmod -x workflow-logs.txt
cat workflow-logs.txt