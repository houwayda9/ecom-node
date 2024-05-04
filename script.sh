#!/bin/bash

# Function to save environment variables to a .env file, stripping a prefix
create_env_file_without_prefix() {
    local prefix=$1
    local branch_name=$2
    local env_file=".env.${branch_name^^}"

    echo "Creating $env_file with variables starting with '${prefix}_' but without the prefix"

    # Initialize the .env file
    echo "# Environment variables for branch $branch_name (prefix '${prefix}_' removed)" > "$env_file"

    # Extract variables with the prefix and remove the prefix
    while IFS='=' read -r key value; do
        stripped_key="${key#${prefix}_}"  # Remove the prefix
        echo "${stripped_key}=${value}" >> "$env_file"
    done < <(printenv | grep -iE "^${prefix}_")

    echo "Generated .env file:"
    cat "$env_file"
}

# Check if GITHUB_REF is set (used in GitHub Actions to identify the branch)
if [ -z "$GITHUB_REF" ]; then
    echo "Error: GITHUB_REF is not set. Make sure this is run in a CI environment like GitHub Actions."
    exit 1
fi

# Extract the branch name from GITHUB_REF
branch_name=$(echo "$GITHUB_REF" | awk -F'/' '{print tolower($3)}')

# Define the prefix you want to remove (e.g., PROD)
prefix="PROD"

# Call function to generate the .env file without the given prefix
create_env_file_without_prefix "$prefix" "$branch_name"
