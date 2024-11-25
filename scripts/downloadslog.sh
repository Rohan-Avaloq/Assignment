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

# Unzip logs for further processing (if needed)
# unzip -o workflow-logs.zip -d workflow-logs
# echo "Workflow logs downloaded and unzipped."

# #!/bin/bash

# # Variables
# RUN_ID=${GITHUB_RUN_ID}
# REPO=${GITHUB_REPOSITORY}
# TOKEN=${MY_TOKEN} 
# # Download logs
# curl -H "Authorization: token ${TOKEN}" \
#      -H "Accept: application/vnd.github.v3+json" \
#      -L \
#      "https://api.github.com/repos/${REPO}/actions/runs/${RUN_ID}/logs" \
#      -o workflow-logs.zip

# # Verify download
# if [ ! -s workflow-logs.zip ]; then
#   echo "Error: No logs found or ZIP file is empty. Skipping unzip."
#   exit 1
# fi

# # Unzip logs
# unzip -o workflow-logs.zip -d workflow-logs
# echo "Workflow logs downloaded and unzipped."