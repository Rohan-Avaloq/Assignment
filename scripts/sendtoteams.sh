#!/bin/bash

# Variables
WEBHOOK_URL=${WEBHOOK_URL}
LOGS_LINK="https://github.com/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
LOG_FILE=$(cat workflow-logs.txt)


# Truncate logs to avoid exceeding Teams' limits
LOG_FILES=$(echo "$LOG_FILES" | head -n 50)

# Escape logs for JSON compatibility
escaped_logs=$(echo "$LOG_FILES" | jq -R .)

# Create JSON payload
JSON_PAYLOAD=$(cat <<EOF
{
  "@type": "MessageCard",
  "@context": "https://schema.org/extensions",
  "summary": "GitHub Actions Workflow Logs",
  "themeColor": "0076D7",
  "title": "Workflow Logs for Run ID ${RUN_ID}",
  "text": $escaped_logs,
  "sections": [
    {
      "text": $escaped_logs 
    }
  ]
}
EOF
)


echo "Sending Payload: $JSON_PAYLOAD" | jq .


# Send to Teams
curl -H "Content-Type: application/json" \
     -d "${JSON_PAYLOAD}" \
     "${WEBHOOK_URL}"

echo "Notification sent to Teams."

