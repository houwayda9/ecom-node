#!/bin/bash

# Function to list secrets and variables
list_secrets_and_variables() {
    local branch_name=$1
    local env_file=".env.${branch_name^^}"  # Convert branch name to uppercase

    echo "Branch: $branch_name"
    echo "Environment: $branch_name"
    
    # List all secrets
    echo "Secrets:"
    cat "$env_file"

    # List all variables
    echo "Variables:"
    while IFS='=' read -r key value; do
        echo "$key=$value"
    done < <(printenv | grep -iE "^${branch_name^^}_" | sort)
}

# Main script
if [ -z "$GITHUB_REF" ]; then
    echo "Error: GITHUB_REF is not set. This script should be run within a GitHub Actions environment."
    exit 1
fi

# Extract branch name from GITHUB_REF
branch_name=$(echo "$GITHUB_REF" | awk -F'/' '{print tolower($3)}')

# Call function to list secrets and variables
list_secrets_and_variables "$branch_name"
