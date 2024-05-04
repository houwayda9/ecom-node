#!/bin/bash

# Function to save branch-prefixed environment variables to an .env file
create_branch_specific_env_file() {
    local branch_name=$1
    local upper_branch_name=${branch_name^^}
    local env_file=".env.${upper_branch_name}"

    echo "Creating $env_file with variables starting with '${upper_branch_name}_'"

    # Initialize the .env file
    echo "# Environment variables for branch $upper_branch_name" > "$env_file"

    # Extract only variables starting with the branch name in uppercase and add them to the .env file
    printenv | grep -iE "^${upper_branch_name}_" | sort >> "$env_file"

    echo "Generated .env file:"
    cat "$env_file"
}

# Check if GITHUB_REF is set (used in GitHub Actions to identify the branch)
if [ -z "$GITHUB_REF" ]; then
    echo "Error: GITHUB_REF is not set. Make sure this is run in a CI environment like GitHub Actions."
    exit 1
fi

# Extract the branch name from GITHUB_REF and convert to lowercase
branch_name=$(echo "$GITHUB_REF" | awk -F'/' '{print tolower($3)}')

# Call function to generate the .env file with branch-specific variables
create_branch_specific_env_file "$branch_name"
