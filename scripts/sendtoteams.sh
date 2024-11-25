#!/bin/bash

# Variables
WEBHOOK_URL=${WEBHOOK_URL}
LOGS_LINK="https://github.com/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
LOG_FILE=$(cat workflow-logs.txt)

Prepare JSON payload
JSON_PAYLOAD=$(cat <<EOF
{
  "@type": "MessageCard",
  "@context": "https://schema.org/extensions",
  "summary": "GitHub Actions Workflow Logs",
  "themeColor": "0076D7",
  "title": "Workflow Logs for Run ID ${GITHUB_RUN_ID}",
  "text": $LOG_FILES,
  "sections": [
    {
      "text": "Download the attached logs for detailed information."
    }
  ]
}
EOF
)



# Send to Teams
curl -H "Content-Type: application/json" \
     -d "${JSON_PAYLOAD}" \
     "${WEBHOOK_URL}"

echo "Notification sent to Teams."

# #!/bin/bash

# # Variables
# WEBHOOK_URL=${WEBHOOK_URL}
# LOGS_LINK="https://github.com/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
# LOG_FILE="workflow-logs.zip"

# # Base64 encode the log file
# if [ -f "$LOG_FILE" ]; then
#     BASE64_LOG=$(base64 "$LOG_FILE")
# else
#     echo "Log file not found. Please ensure the download was successful."
#     exit 1
# fi

# # Prepare JSON payload with base64 encoded file
# JSON_PAYLOAD=$(cat <<EOF
# {
#   "@type": "MessageCard",
#   "@context": "https://schema.org/extensions",
#   "summary": "GitHub Actions Workflow Logs",
#   "themeColor": "0076D7",
#   "title": "Workflow Logs for Run ID ${GITHUB_RUN_ID}",
#   "text": "The workflow has completed. [View Logs](${LOGS_LINK}).",
#   "sections": [
#     {
#       "text": "Download the attached logs for detailed information."
#     }
#   ],
#   "attachments": [
#     {
#       "contentType": "application/octet-stream",
#       "content": "${BASE64_LOG}",
#       "name": "workflow-logs.zip"
#     }
#   ]
# }
# EOF
# )

# # Send to Teams via Webhook
# curl -H "Content-Type: application/json" \
#      -d "${JSON_PAYLOAD}" \
#      "${WEBHOOK_URL}"

# echo "Notification with logs sent to Teams."


# #!/bin/bash

# # Fetch environment variables
# RUN_ID=${RUN_ID}
# REPO=${REPO}
# TOKEN=${TOKEN}
# WEBHOOK_URL=${TEAMS_WEBHOOK_URL}

# # Validate environment variables
# if [ -z "$RUN_ID" ] || [ -z "$REPO" ] || [ -z "$TOKEN" ] || [ -z "$WEBHOOK_URL" ]; then
#   echo "Error: Missing required environment variables (RUN_ID, REPO, TOKEN, or WEBHOOK_URL)."
#   exit 1
# fi

# # Fetch workflow logs from GitHub
# echo "Fetching workflow logs for RUN_ID=${RUN_ID}..."
# logs=$(curl -s \
#   -H "Authorization: token ${TOKEN}" \
#   -H "Accept: application/vnd.github.v3+json" \
#   -L \
#   "https://api.github.com/repos/${REPO}/actions/runs/${RUN_ID}/logs")

# # Verify if logs were fetched successfully
# if [ $? -ne 0 ] || [ -z "$logs" ]; then
#   echo "Error: Failed to fetch logs."
#   exit 1
# fi

# # Prepare JSON payload for Teams
# summary="Workflow Logs for Run ID ${RUN_ID}"
# payload=$(jq -n \
#   --arg summary "$summary" \
#   --arg logs "$logs" \
#   '{
#     "@type": "MessageCard",
#     "@context": "https://schema.org/extensions",
#     "themeColor": "0076D7",
#     "summary": $summary,
#     "title": "GitHub Actions Workflow Logs",
#     "text": $logs
#   }')

# # Send logs to Microsoft Teams
# echo "Sending logs to Teams..."
# curl -s -H "Content-Type: application/json" \
#      -d "$payload" \
#      "$WEBHOOK_URL"

# if [ $? -eq 0 ]; then
#   echo "Logs sent to Teams successfully."
# else
#   echo "Error: Failed to send logs to Teams."
#   exit 1
# fi



# #!/bin/bash

# # Fetch environment variables
# RUN_ID=${GITHUB_RUN_ID}
# REPO=${GITHUB_REPOSITORY}
# TOKEN=${MY_TOKEN}
# WEBHOOK_URL=https://avaloqgroup.webhook.office.com/webhookb2/acc69694-4513-4770-9275-42f898a52f96@2ba8a4bf-3d7a-478b-b8d1-85cae49436ef/IncomingWebhook/ee99d20a71df4bb7993376f96e8a7427/9be00cee-8615-47cd-acdb-537181146f7d/V2vqRicQ0PbEBM-ImL6GUIwMByEgr2iZbJBdhuJXvNOV41


# # ${TEAMS_WEBHOOK_URL }

# # Validate environment variables
# if [ -z "$RUN_ID" ] || [ -z "$REPO" ] || [ -z "$TOKEN" ] || [ -z "$WEBHOOK_URL" ]; then
#   echo "Error: Missing required environment variables (RUN_ID, REPO, TOKEN, or WEBHOOK_URL)."
#   exit 1
# fi

# # Step 1: Get the URL for logs
# echo "Fetching logs URL for RUN_ID=${RUN_ID}..."
# logs_url=$(curl -s \
#   -H "Authorization: token ${TOKEN}" \
#   -H "Accept: application/vnd.github.v3+json" \
#   "https://api.github.com/repos/${REPO}/actions/runs/${RUN_ID}" | jq -r '.logs_url')

# if [ -z "$logs_url" ]; then
#   echo "Error: Failed to retrieve logs URL."
#   exit 1
# fi

# # Step 2: Download logs
# echo "Downloading logs from $logs_url..."
# logs=$(curl -s -L \
#   -H "Authorization: token ${TOKEN}" \
#   "$logs_url")

# if [ -z "$logs" ]; then
#   echo "Error: Failed to download logs."
#   exit 1
# fi

# # Step 3: Prepare JSON payload for Teams
# summary="Workflow Logs for Run ID ${RUN_ID}"
# payload=$(jq -n \
#   --arg summary "$summary" \
#   --arg logs "$(echo "$logs" | head -n 50)" \
#   '{
#     "@type": "MessageCard",
#     "@context": "https://schema.org/extensions",
#     "themeColor": "0076D7",
#     "summary": $summary,
#     "title": "GitHub Actions Workflow Logs",
#     "text": $logs
#   }')

# # Step 4: Send logs to Microsoft Teams
# echo "Sending logs to Teams..."
# curl -s -H "Content-Type: application/json" \
#      -d "$payload" \
#      "$WEBHOOK_URL"

# if [ $? -eq 0 ]; then
#   echo "Logs sent to Teams successfully."
# else
#   echo "Error: Failed to send logs to Teams."
#   exit 1
# fi
