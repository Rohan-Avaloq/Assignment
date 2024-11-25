#!/bin/bash

# Variables
WEBHOOK_URL=${WEBHOOK_URL}
LOGS_LINK="https://github.com/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
LOG_FILE="workflow-logs.zip"

# Prepare JSON payload
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
  ]
}
EOF
)

# Send to Teams
curl -H "Content-Type: application/json" \
     -d "${JSON_PAYLOAD}" \
     "${WEBHOOK_URL}"

echo "Notification sent to Teams."