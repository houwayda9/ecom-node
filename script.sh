#!/bin/bash

# Extract the branch name from the GITHUB_REF environment variable
BRANCH=$(echo "$GITHUB_REF" | sed 's|refs/heads/||')
# Convert branch name to uppercase for environment name
ENV_NAME=$(echo "$BRANCH" | awk '{print toupper($0)}')

# Create a header for the list of environment variables
echo "# Listing All Environment Variables for ${ENV_NAME} Environment"

# Loop through environment variables and filter by prefix
while IFS='=' read -r key value; do
    # Only list variables that have the environment prefix
    if [[ "$key" == "${ENV_NAME}_"* ]]; then
        echo "${key}=${value}"
    fi
done < <(printenv)
