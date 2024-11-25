# #!/bin/bash

# # Variables
# WEBHOOK_URL=${WEBHOOK_URL}
# LOGS_LINK="https://github.com/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
# LOG_FILE="workflow-logs.zip"

# # Prepare JSON payload
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
#   ]
# }
# EOF
# )

# # Send to Teams
# curl -H "Content-Type: application/json" \
#      -d "${JSON_PAYLOAD}" \
#      "${WEBHOOK_URL}"

# echo "Notification sent to Teams."

#!/bin/bash

# Variables
WEBHOOK_URL=${WEBHOOK_URL}
LOGS_LINK="https://github.com/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
LOG_FILE="workflow-logs.zip"

# Base64 encode the log file
if [ -f "$LOG_FILE" ]; then
    BASE64_LOG=$(base64 "$LOG_FILE")
else
    echo "Log file not found. Please ensure the download was successful."
    exit 1
fi

# Prepare JSON payload with base64 encoded file
JSON_PAYLOAD=$(cat <<EOF
{
  "@type": "MessageCard",
  "@context": "https://schema.org/extensions",
  "summary": "GitHub Actions Workflow Logs",
  "themeColor": "0076D7",
  "title": "Workflow Logs for Run ID ${GITHUB_RUN_ID}",
  "text": "The workflow has completed. [View Logs](${LOGS_LINK}).",
  "sections": [
    {
      "text": "Download the attached logs for detailed information."
    }
  ],
  "attachments": [
    {
      "contentType": "application/octet-stream",
      "content": "${BASE64_LOG}",
      "name": "workflow-logs.zip"
    }
  ]
}
EOF
)

# Send to Teams via Webhook
curl -H "Content-Type: application/json" \
     -d "${JSON_PAYLOAD}" \
     "${WEBHOOK_URL}"

echo "Notification with logs sent to Teams."
