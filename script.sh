#!/bin/bash

# Specify the .env file path
ENV_FILE=".env"

# Clear existing file and start fresh
echo "# Exported Environment Variables" > "$ENV_FILE"

# Loop through all environment variables
# Customize the grep command to filter only variables with specific prefixes
printenv | grep -E "^(PROD_)" | while IFS='=' read -r key value; do
    echo "${key}=${value}" >> "$ENV_FILE"
done

echo "All environment variables with specified prefixes have been exported to ${ENV_FILE}"
