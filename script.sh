#!/bin/bash

# Function to list environment variables and secrets
list_environment_variables_and_secrets() {
    local branch_name=$1
    local env_file=".env.${branch_name}"  # File to store environment variables and secrets

    echo "Branch: $branch_name"
    echo "Environment: $branch_name"

    # Retrieve environment variables and secrets using GitHub API
    local response=$(curl -s -H "Authorization: Bearer secrets.G_TOKEN2" \
                            -H "Accept: application/vnd.github.v3+json" \
                            "https://api.github.com/repos/$GITHUB_REPOSITORY/actions/secrets")
    
    # Check if there are any secrets returned
    if [[ $(echo "$response" | jq -r '.secrets | length') -eq 0 ]]; then
        echo "No secrets found for environment $branch_name"
        return
    fi
    
    # Extract and save environment variables and secrets to .env file
    echo "$response" | jq -r --arg prefix "${branch_name^^}_" '.secrets | to_entries[] | select(.key | startswith($prefix)) | "\(.key | ltrimstr($prefix))=\(.value)"' > "$env_file"
}

# Main script
if [ -z "$GITHUB_REF" ]; then
    echo "Error: GITHUB_REF is not set. This script should be run within a GitHub Actions environment."
    exit 1
fi

if [ -z "secrets.G_TOKEN2" ]; then
    echo "Error: GITHUB_TOKEN is not set. Please set up a personal access token with repo scope and assign it to GITHUB_TOKEN."
    exit 1
fi

# Extract branch name from GITHUB_REF
branch_name=$(echo "$GITHUB_REF" | awk -F'/' '{print tolower($3)}')

# Call function to list environment variables and secrets
list_environment_variables_and_secrets "$branch_name"


