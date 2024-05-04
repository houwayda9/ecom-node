#!/bin/bash

# Function to extract secrets and variables and save to .env file
create_env_file() {
    local branch_name=$1
    local upper_branch_name=${branch_name^^}
    local env_file=".env.${upper_branch_name}"

    echo "Creating $env_file for branch: $branch_name"

    # Initialize the .env file with branch name info
    echo "BRANCH=$upper_branch_name" > "$env_file"

    # Add environment variables that match the branch name prefix
    printenv | grep -iE "^${upper_branch_name}_" | sort >> "$env_file"

    echo "Generated .env file:"
    cat "$env_file"
}

# Check if GITHUB_REF is set
if [ -z "$GITHUB_REF" ]; then
    echo "Error: GITHUB_REF is not set. Make sure this is run in a GitHub Actions environment."
    exit 1
fi

# Extract branch name from GITHUB_REF
branch_name=$(echo "$GITHUB_REF" | awk -F'/' '{print tolower($3)}')

# Call function to generate the .env file
create_env_file "$branch_name"
