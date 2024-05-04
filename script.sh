#!/bin/bash

# Name of the .env file to be created
ENV_FILE=".env"

# Create or clear the .env file
echo "# Exported Environment Variables" > "$ENV_FILE"

# Loop through each environment variable, excluding GitHub Actions specific prefixes
printenv | grep -Ev "^(PROD_)" | while IFS='=' read -r key value; do
    echo "$key=$value" >> "$ENV_FILE"
done

echo "Environment variables exported to ${ENV_FILE}"
